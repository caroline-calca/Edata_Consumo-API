unit uIDadosCOVIDViewModel;

interface

uses
  System.Generics.Collections,
  System.Classes,
  Datasnap.DBClient,
  Data.DB,
  Vcl.StdCtrls;

type
  IDadosCOVIDViewModel = interface
    ['{BB21E91F-1A6B-4138-8147-8EE9585CAB85}']
    function GetDataSource: TDataSource;
    function ObterListaDescricao: TStrings;
    procedure CarregarDados;
    procedure FiltrarPorNome(const Nome: string);
    procedure OrdenarPor(Index: Integer);
    procedure PreencherOpcoesOrdenacao(AComboBox: TComboBox);
  end;

implementation

end.
