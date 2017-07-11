program QServer;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {MainFrm},
  uSettings in 'uSettings.pas' {SettingsFrm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainFrm, MainFrm);
  Application.CreateForm(TSettingsFrm, SettingsFrm);
  Application.Run;
end.
