unit uDadosCOVID;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Variants,
  System.Generics.Collections,
  Data.DB,
  uIDadosCOVID;

type
  TDadosCOVID = class(TInterfacedObject, IDadosCOVID)
  private
    FValores: TArray<Variant>;
  public
    type
      TCampoDef = record
        NomeJSON: string;
        Tipo: TFieldType;
        Tamanho: Integer;
        Descricao: string;
        DisplayWidth: Integer;
        Visible: Boolean;

        // Construtor estático para facilitar a inicialização
        class function Create(NomeJSON: string;
                              Tipo: TFieldType;
                              Tamanho: Integer;
                              Descricao: string;
                              DisplayWidth: Integer;
                              Visible: Boolean): TCampoDef; static;
      end;

    class var Campos: TList<TCampoDef>;

    function GetCampo(Index: Integer): Variant;
    procedure SetCampo(Index: Integer; const Value: Variant);
    property Campo[Index: Integer]: Variant read GetCampo write SetCampo;

    constructor Create;
    destructor Destroy; override;

    class constructor Create;
    class destructor Destroy;
  end;

implementation

{ TDadosCOVID }

constructor TDadosCOVID.Create;
begin
  inherited Create;
  SetLength(FValores, TDadosCOVID.Campos.Count);
end;

destructor TDadosCOVID.Destroy;
begin
  Finalize(FValores);
  inherited;
end;

function TDadosCOVID.GetCampo(Index: Integer): Variant;
begin
  if (Index >= 0) and (Index < Length(FValores)) then
    Result := FValores[Index]
  else
    Result := Null;
end;

procedure TDadosCOVID.SetCampo(Index: Integer; const Value: Variant);
begin
  if (Index >= 0) and (Index < Length(FValores)) then
    FValores[Index] := Value;
end;

{ Definição dos metadados dos campos.
  Sempre que for necessário adicionar um novo campo vindo do JSON, ele deve ser incluído aqui.
  Dessa forma, garantimos que todas as propriedades essenciais (tipo, tamanho, nome, exibição)
   fiquem padronizadas e consistentes em toda a aplicação. }
class constructor TDadosCOVID.Create;
begin
  Campos := TList<TCampoDef>.Create;

  Campos.Add(TCampoDef.Create('country',   ftString,  100, 'País',        50,  True));
  Campos.Add(TCampoDef.Create('confirmed', ftInteger,   0, 'Confirmados', 15,  True));
  Campos.Add(TCampoDef.Create('deaths',    ftInteger,   0, 'Óbitos',      15,  True));
  Campos.Add(TCampoDef.Create('recovered', ftInteger,   0, 'Recuperados', 15,  True));
end;

class destructor TDadosCOVID.Destroy;
begin
  FreeAndNil(Campos);
end;

class function TDadosCOVID.TCampoDef.Create(NomeJSON: string; Tipo: TFieldType;
  Tamanho: Integer; Descricao: string; DisplayWidth: Integer; Visible: Boolean): TCampoDef;
begin
  Result.NomeJSON := NomeJSON;
  Result.Tipo := Tipo;
  Result.Tamanho := Tamanho;
  Result.Descricao := Descricao;
  Result.DisplayWidth := DisplayWidth;
  Result.Visible := Visible;
end;

end.
