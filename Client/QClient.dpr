program QClient;

uses
  Vcl.Forms,
  uLogin in 'uLogin.pas' {LoginFrm},
  uMainFrm in 'uMainFrm.pas' {MainFrm};

{$R *.res}
var
  PCName:string;
  UserName:String;

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainFrm, MainFrm);
  //Application.CreateForm(TLoginFrm, LoginFrm);
  if LoginFrm.Login(PCName,UserName) then
  begin
  MainFrm.pcName:=pcname;
  MainFrm.userName:=username;
  Application.Run;
  end
  else
  Application.Terminate;
end.
