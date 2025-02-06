unit uDadosCOVIDViewModel;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  System.TypInfo,
  System.Classes,
  Vcl.StdCtrls,
  Datasnap.DBClient,
  Data.DB,
  uIDadosCOVIDViewModel,
  uIDadosCOVIDService,
  uDadosCOVID,
  uIDadosCOVID,
  uConstantes;

type
  TDadosCOVIDViewModel = class(TInterfacedObject, IDadosCOVIDViewModel)
  private
    FService: IDadosCOVIDService;
    FDataSource: TDataSource;
    FClientDataSet: TClientDataSet;

    function GetClientDataSet: TClientDataSet;

    procedure ConfigurarClientDataSet;
    procedure ConfigurarExibicaoCampos;
    procedure ConfigurarDataSource;
    procedure FormatarNumero(Sender: TField; var Text: string; DisplayText: Boolean);
  public
    constructor Create(AService: IDadosCOVIDService);
    destructor Destroy; override;
    function GetDataSource: TDataSource;
    function ObterListaDescricao: TStrings;
    procedure CarregarDados;
    procedure FiltrarPorNome(const Nome: string);
    procedure OrdenarPor(Index: Integer);
    procedure PreencherOpcoesOrdenacao(AComboBox: TComboBox);
  end;

implementation

{ TDadosCOVIDViewModel }

constructor TDadosCOVIDViewModel.Create(AService: IDadosCOVIDService);
begin
  inherited Create;
  FService := AService;
  ConfigurarClientDataSet;
  ConfigurarDataSource;
end;

destructor TDadosCOVIDViewModel.Destroy;
begin
  FreeAndNil(FClientDataSet);
  FreeAndNil(FDataSource);
  inherited;
end;

function TDadosCOVIDViewModel.GetDataSource: TDataSource;
begin
  Result := FDataSource;
end;

function TDadosCOVIDViewModel.GetClientDataSet: TClientDataSet;
begin
  Result := FClientDataSet;
end;

// Cria os campos no ClientDataSet
procedure TDadosCOVIDViewModel.ConfigurarClientDataSet;
var
  Campo: TDadosCOVID.TCampoDef;
begin
  FClientDataSet := TClientDataSet.Create(nil);

  for Campo in TDadosCOVID.Campos do
  begin
    FClientDataSet.FieldDefs.Add(Campo.NomeJSON, Campo.Tipo, Campo.Tamanho);
  end;

  FClientDataSet.CreateDataSet;

  ConfigurarExibicaoCampos;
end;

// Altera a parte visual dos campos no ClientDataSet
procedure TDadosCOVIDViewModel.ConfigurarExibicaoCampos;
var
  Campo: TDadosCOVID.TCampoDef;
begin
  for Campo in TDadosCOVID.Campos do
  begin
    with FClientDataSet.FieldByName(Campo.NomeJSON) do
    begin
      DisplayLabel := Campo.Descricao;
      DisplayWidth := Campo.DisplayWidth;
      Visible := Campo.Visible;

      if Campo.Tipo in [ftInteger, ftFloat, ftCurrency] then
        OnGetText := FormatarNumero;
    end;
  end;
end;

// Amarra o ClientDataSet no DataSource
procedure TDadosCOVIDViewModel.ConfigurarDataSource;
begin
  FDataSource := TDataSource.Create(nil);
  FDataSource.DataSet := GetClientDataSet;
end;

// Define a máscara dos campos numéricos
procedure TDadosCOVIDViewModel.FormatarNumero(Sender: TField; var Text: string; DisplayText: Boolean);
const
  TextoValorAusente = 'N/D';
  Mascara = '#,##0';
begin
  if Sender.AsInteger = VALOR_AUSENTE then
    Text := TextoValorAusente
  else
    Text := FormatFloat(Mascara, Sender.AsInteger);
end;

// Carrega os dados do JSON para o ClientDataSet
procedure TDadosCOVIDViewModel.CarregarDados;
var
  Lista: TList<IDadosCOVID>;
  Dados: IDadosCOVID;
  Campo: TDadosCOVID.TCampoDef;
  Index: Integer;
begin
  Lista := FService.ObterDadosCOVID;
  try
    FClientDataSet.DisableControls;
    try
      FClientDataSet.EmptyDataSet;

      for Dados in Lista do
      begin
        FClientDataSet.Append;
        for Index := 0 to TDadosCOVID.Campos.Count - 1 do
        begin
          Campo := TDadosCOVID.Campos[Index];
          FClientDataSet.FieldByName(Campo.NomeJSON).Value := Dados.Campo[Index];
        end;
        FClientDataSet.Post;
      end;

      FClientDataSet.First;
    finally
      FClientDataSet.EnableControls;
    end;
  finally
    FreeAndNil(Lista);
  end;
end;

// Obtém uma lista das descrições de todos os campos
function TDadosCOVIDViewModel.ObterListaDescricao: TStrings;
var
  Campo: TDadosCOVID.TCampoDef;
begin
  Result := TStringList.Create;
  for Campo in TDadosCOVID.Campos do
  begin
    Result.AddObject(Campo.Descricao, TObject(Campo.NomeJSON));
  end;
end;

// Realiza o filtro pelo nome do país
procedure TDadosCOVIDViewModel.FiltrarPorNome(const Nome: string);
var
  CampoNome: string;
begin
  if not FClientDataSet.Active then
    Exit;

  CampoNome := TDadosCOVID.Campos[0].NomeJSON;

  if Nome.Trim = '' then
    FClientDataSet.Filter := ''
  else
    FClientDataSet.Filter := Format('Upper(%s) LIKE Upper(''%%%s%%'')', [CampoNome, Nome]);

  FClientDataSet.Filtered := Nome.Trim <> '';
end;

// Realiza a ordenação pelo campo definido
procedure TDadosCOVIDViewModel.OrdenarPor(Index: Integer);
var
  ListaOrdenacao: TStrings;
  CampoJSON,
  CampoPadrao: string;
begin
  if (Index < 0) or (Index >= TDadosCOVID.Campos.Count) then
    Exit;

  ListaOrdenacao := ObterListaDescricao;
  try
    CampoJSON := string(ListaOrdenacao.Objects[Index]);
    CampoPadrao := TDadosCOVID.Campos[0].NomeJSON;

    FClientDataSet.IndexFieldNames := CampoJSON + ';' + CampoPadrao;

    FClientDataSet.First;
  finally
    FreeAndNil(ListaOrdenacao);
  end;
end;

// Preenche um combobox com as opções de filtros para ordenação
procedure TDadosCOVIDViewModel.PreencherOpcoesOrdenacao(AComboBox: TComboBox);
var
  Campo: TDadosCOVID.TCampoDef;
  Index: Integer;
begin
  AComboBox.Items.Clear;

  for Index := 0 to TDadosCOVID.Campos.Count - 1 do
  begin
    Campo := TDadosCOVID.Campos[Index];

    if Campo.Visible then  // Não deixa ordenar por campos que não estão visíveis
      AComboBox.Items.AddObject(Campo.Descricao, TObject(Index));
  end;

  if AComboBox.Items.Count > 0 then
    AComboBox.ItemIndex := 0;
end;

end.
