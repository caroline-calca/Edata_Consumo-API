unit uDadosCOVIDFactory;

interface

uses
  uIDadosCOVIDService,
  uDadosCOVIDService,
  uIDadosCOVIDViewModel,
  uDadosCOVIDViewModel;

type
  TDadosCOVIDFactory = class
  public
    class function CriarViewModel: IDadosCOVIDViewModel;
  end;

implementation

{ TDadosCOVIDFactory }

class function TDadosCOVIDFactory.CriarViewModel: IDadosCOVIDViewModel;
var
  Service: IDadosCOVIDService;
begin
  Service := TDadosCOVIDService.Create;
  Result := TDadosCOVIDViewModel.Create(Service);
end;

end.
