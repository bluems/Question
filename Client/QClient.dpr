program QClient;

uses
  Vcl.Forms,
  uLogin in 'uLogin.pas' {LoginFrm},
  uMainFrm in 'uMainFrm.pas' {MainFrm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TLoginFrm, LoginFrm);
  Application.Run;
end.
