unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.Buttons;

type
  TLoginFrm = class(TForm)
    Image1: TImage;
    edtPC: TEdit;
    edtName: TEdit;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
    FPCName: string;
    FUserName: string;
  public
    { Public declarations }
    // function Login(var PCName, UserName: String): Boolean;
    procedure SetPCName(const AValue: string);
    procedure SetUserName(const AValue: string);
    property PCName: string read FPCName write SetPCName;
    property UserName: string read FUserName write SetUserName;
  end;

function Login(var PCName: String; var UserName: String): Boolean;
{ var
  LoginFrm: TLoginFrm; }

implementation

{$R *.dfm}

function Login(var PCName, UserName: String): Boolean;
var
  LLoginView: TLoginFrm;
begin
  LLoginView := TLoginFrm.Create(nil);
  try
    Result := LLoginView.Showmodal = mrOk;

    if Result then
    begin
      PCName := LLoginView.PCName;
      UserName := LLoginView.UserName;
    end;
  finally
    LLoginView.Free;
  end;
end;

procedure TLoginFrm.FormCanResize(Sender: TObject;
  var NewWidth, NewHeight: Integer; var Resize: Boolean);
begin
  Resize := false;
end;

procedure TLoginFrm.SetPCName(const AValue: string);
begin
  if FPCName <> AValue then
  begin
    FPCName := AValue;
  end;
end;

procedure TLoginFrm.SetUserName(const AValue: string);
begin
  if FUserName <> AValue then
  begin
    FUserName := AValue;
  end;

end;

procedure TLoginFrm.SpeedButton1Click(Sender: TObject);
var
  LUserNAme, LPcName: string;
begin
  LPcName := trim(edtPC.Text);
  LUserNAme := trim(edtName.Text);

  if LPcName = '' then
  begin
    ShowMessage('PC번호를 입력하세요.');
    exit;
  end;

  if LUserNAme = '' then
  begin
    ShowMessage('사용자 이름을 입력하세요');
    exit;
  end;

  FPCName := LPcName;
  FUserName := LUserNAme;

  Modalresult := mrOk;

end;

procedure TLoginFrm.SpeedButton2Click(Sender: TObject);
begin
  Modalresult := mrCancel;
end;

end.
