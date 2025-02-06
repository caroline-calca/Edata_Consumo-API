unit frmPrincipal;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Generics.Collections,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Datasnap.DBClient,
  Vcl.Buttons,
  uDadosCOVIDFactory,
  uIDadosCOVIDViewModel,
  uDadosCOVIDViewModel;

type
  TfPrincipal = class(TForm)
    pnlFiltros: TPanel;
    pnlGrid: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtNomePais: TEdit;
    cmbOrdenacao: TComboBox;
    dbgDadosCOVID: TDBGrid;
    ClientDataSet1: TClientDataSet;
    ClientDataSet1aa: TStringField;
    btnAtualizarDados: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnAtualizarDadosClick(Sender: TObject);
    procedure edtNomePaisChange(Sender: TObject);
    procedure cmbOrdenacaoSelect(Sender: TObject);
  private
    FViewModel: IDadosCOVIDViewModel;
  public
    { Public declarations }
  end;

var
  fPrincipal: TfPrincipal;

implementation

{$R *.dfm}

procedure TfPrincipal.FormCreate(Sender: TObject);
begin
  btnAtualizarDados.Caption := EmptyStr;

  // Utiliza uma Fábrica para criar e configurar o ViewModel, garantindo a injeção correta de dependências
  FViewModel := TDadosCOVIDFactory.CriarViewModel;

  dbgDadosCOVID.DataSource := FViewModel.GetDataSource;
  FViewModel.CarregarDados;
  FViewModel.PreencherOpcoesOrdenacao(cmbOrdenacao);
end;

procedure TfPrincipal.cmbOrdenacaoSelect(Sender: TObject);
begin
  FViewModel.OrdenarPor(cmbOrdenacao.ItemIndex);
end;

procedure TfPrincipal.edtNomePaisChange(Sender: TObject);
begin
  FViewModel.FiltrarPorNome(edtNomePais.Text);
end;

procedure TfPrincipal.btnAtualizarDadosClick(Sender: TObject);
begin
  FViewModel.CarregarDados;
end;

end.
