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

  //Application.CreateForm(TLoginFrm, LoginFrm);
  if Login(PCName,UserName) then
  begin
  Application.CreateForm(TMainFrm, MainFrm);
  MainFrm.pcName:=pcname;
  MainFrm.userName:=UserName;
  Application.Run;
  end
  else
    Application.Terminate;
end.
