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
    procedure SetPCName(const AValue: string);
    procedure SetUserName(const AValue: string);
    property pcName: string read FPCName write SetPCName;
    property userName: string read FUserName write SetUserName;
  end;

var
  LoginFrm: TLoginFrm;

implementation

{$R *.dfm}

procedure TLoginFrm.FormCanResize(Sender: TObject;
  var NewWidth, NewHeight: Integer; var Resize: Boolean);
begin
  Resize := false;
end;

procedure TLoginFrm.SetPCName(const AValue: string);
begin
  if FPCName <> AValue then
    FPCName := AValue;
end;

procedure TLoginFrm.SetUserName(const AValue: string);
begin
  if FUserName <> AValue then
    FUserName := AValue;
end;

procedure TLoginFrm.SpeedButton1Click(Sender: TObject);
begin
  if edtPC.Text = '' then
  begin
    showmessage('PC번호를 입력하세요');
    SetPCName(edtPC.Text);
  end
  else if edtName.Text = '' then
  begin
    showmessage('사용자 이름을 입력하세요');
    SetUserName(edtName.Text);
  end
  else
  begin
  modalresult:=mrOk;
    loginfrm.Close;

  end;

end;

procedure TLoginFrm.SpeedButton2Click(Sender: TObject);
begin
  loginfrm.Close;
  modalResult:=mrCancel;
end;

end.
