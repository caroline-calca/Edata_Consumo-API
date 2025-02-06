program Dados_COVID;

uses
  Vcl.Forms,
  frmPrincipal in 'src\Views\frmPrincipal.pas' {fPrincipal},
  uDadosCOVID in 'src\Models\uDadosCOVID.pas',
  uDadosCOVIDService in 'src\Services\uDadosCOVIDService.pas',
  uIDadosCOVID in 'src\Models\uIDadosCOVID.pas',
  uIDadosCOVIDService in 'src\Services\uIDadosCOVIDService.pas',
  uIDadosCOVIDViewModel in 'src\ViewModels\uIDadosCOVIDViewModel.pas',
  uDadosCOVIDViewModel in 'src\ViewModels\uDadosCOVIDViewModel.pas',
  uDadosCOVIDFactory in 'src\Factories\uDadosCOVIDFactory.pas',
  uConstantes in 'src\Common\uConstantes.pas',
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Emerald Light Slate');
  Application.CreateForm(TfPrincipal, fPrincipal);
  Application.Run;
end.
