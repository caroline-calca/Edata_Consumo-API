unit uDadosCOVIDService;

interface

uses
  System.Net.HttpClient,
  System.Net.HttpClientComponent,
  System.JSON,
  System.Generics.Collections,
  System.SysUtils,
  System.Classes,
  System.Variants,
  Data.DB,
  uIDadosCOVIDService,
  uIDadosCOVID,
  uDadosCOVID,
  uConstantes;

type
  TDadosCOVIDService = class(TInterfacedObject, IDadosCOVIDService)
  private
    FHttpClient: TNetHTTPClient;
    function ObterJSON: TJSONArray;
  public
    constructor Create;
    destructor Destroy; override;
    function ObterDadosCOVID: TList<IDadosCOVID>;
  end;

implementation

{ TDadosCOVIDService }

constructor TDadosCOVIDService.Create;
begin
  FHttpClient := TNetHTTPClient.Create(nil);
end;

destructor TDadosCOVIDService.Destroy;
begin
  FreeAndNil(FHttpClient);
  inherited;
end;

// Faz a requisição HTTP para a API e retorna o JSON como um JSONArray
function TDadosCOVIDService.ObterJSON: TJSONArray;
var
  Response: IHTTPResponse;
  JSONValue: TJSONValue;
  JSONObject: TJSONObject;
begin
  Response := FHttpClient.Get(API_URL);

  // Verifica se a requisição foi bem-sucedida
  if Response.StatusCode <> 200 then
    raise Exception.CreateFmt(ERRO_API, [Response.StatusCode]);

  // Tenta converter a resposta em um objeto JSON
  JSONValue := TJSONObject.ParseJSONValue(Response.ContentAsString);
  if not Assigned(JSONValue) or not (JSONValue is TJSONObject) then
  begin
    FreeAndNil(JSONValue);
    raise Exception.Create(ERRO_JSON_INVALIDO);
  end;

  JSONObject := JSONValue as TJSONObject;
  try
    // Obtém o array de países dentro do JSON
    Result := JSONObject.GetValue<TJSONArray>('data');
    if not Assigned(Result) then
      raise Exception.Create(ERRO_ESTRUTURA_JSON);

    // Faz uma cópia do JSONArray antes de liberar o objeto JSON principal
    Result := TJSONArray(Result.Clone);
  finally
    FreeAndNil(JSONObject);
  end;
end;

// Processa os dados da API e os converte para a lista de objetos TDadosCOVID
function TDadosCOVIDService.ObterDadosCOVID: TList<IDadosCOVID>;
var
  CountryArray: TJSONArray;
  CountryObj: TJSONObject;
  Lista: TList<IDadosCOVID>;
  Dados: IDadosCOVID;
  Campo: TDadosCOVID.TCampoDef;
  I, J: Integer;
  JSONValue: TJSONValue;
  Valor: Variant;
begin
  Lista := TList<IDadosCOVID>.Create;
  try
    CountryArray := ObterJSON;
    try
      for I := 0 to CountryArray.Count - 1 do
      begin
        if not (CountryArray.Items[I] is TJSONObject) then
          Continue;  // Ignora itens que não são objetos JSON

        CountryObj := CountryArray.Items[I] as TJSONObject;
        Dados := TDadosCOVID.Create;

        // Processa todos os campos automaticamente, cada um com seu tipo
        for J := 0 to TDadosCOVID.Campos.Count - 1 do
        begin
          Campo := TDadosCOVID.Campos[J];

          JSONValue := CountryObj.GetValue(Campo.NomeJSON);

          if Assigned(JSONValue) then
          begin
            // Converte o JSONValue para um tipo compatível com Variant
            if JSONValue is TJSONNumber then
              Valor := TJSONNumber(JSONValue).AsDouble
            else if JSONValue is TJSONString then
              Valor := TJSONString(JSONValue).Value
            else
              Valor := Null; // Se for TJSONNull ou outro tipo inesperado
          end
          else
            Valor := Null; // Caso o campo não exista no JSON

          // Se o valor for Null, definimos como VALOR_AUSENTE para inteiros
          if VarIsNull(Valor) and (Campo.Tipo in [ftInteger, ftFloat]) then
            Valor := VALOR_AUSENTE;

          Dados.Campo[J] := Valor;
        end;

        Lista.Add(Dados);
      end;
    finally
      FreeAndNil(CountryArray);
    end;

    Result := Lista;
  except
    on E: Exception do
    begin
      Writeln('Erro ao buscar dados da API: ' + E.Message);
      FreeAndNil(Lista);
      raise;
    end;
  end;
end;

end.
