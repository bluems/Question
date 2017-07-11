unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls, IdBaseComponent, IdComponent, IdCustomTCPServer, IdTCPServer;

type
  TMainFrm = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image13: TImage;
    Image14: TImage;
    Image15: TImage;
    Image16: TImage;
    Image17: TImage;
    Image18: TImage;
    Image19: TImage;
    Image20: TImage;
    Image21: TImage;
    Image22: TImage;
    Image23: TImage;
    Image24: TImage;
    Image25: TImage;
    Image26: TImage;
    Image27: TImage;
    Image28: TImage;
    Image29: TImage;
    Image30: TImage;
    Image31: TImage;
    Image32: TImage;
    Image33: TImage;
    Image34: TImage;
    Image35: TImage;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    lblIP: TLabel;
    ImageRed: TImage;
    ImageSky: TImage;
    ImageGray: TImage;
    IdTCPServer1: TIdTCPServer;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FPort: integer;
    FIP: string;
  public
    { Public declarations }
    procedure SetPort(Const Value: integer);
    procedure SetIP(Const Value: string);
    property Port: integer read FPort write SetPort;
    property IP: string read FIP write SetIP;
  end;

var
  MainFrm: TMainFrm;

implementation

{$R *.dfm}

uses uSettings, Winsock;

function My_LocalIP: String;
var
  wData: WSADATA;
  HostName: String;
  pHostInfo: pHostEnt;
begin
  WSAStartup(MAKEWORD(2, 2), wData);
  GetHostName(PAnsiChar(HostName), 512);
  pHostInfo := GetHostByName(PAnsiChar(HostName));

  if Assigned(pHostInfo) then
    Result := inttostr(ord(pHostInfo.h_addr_list^[0])) + '.' +
      inttostr(ord(pHostInfo.h_addr_list^[1])) + '.' +
      inttostr(ord(pHostInfo.h_addr_list^[2])) + '.' +
      inttostr(ord(pHostInfo.h_addr_list^[3]))
  else
    Result := '';
  WSACleanup;
end;

{ TMainFrm }

procedure TMainFrm.Button1Click(Sender: TObject);
var
  SettingsFrm: TSettingsFrm;
begin
  SettingsFrm := TSettingsFrm.Create(self);
  SettingsFrm.Port := Port;
  try
    if SettingsFrm.ShowModal = mrOk then
    begin
      Port := SettingsFrm.Port;
    end;
    showmessage(inttostr(Port));
  finally
    SettingsFrm.Free;
    SettingsFrm := nil;
  end;

end;

procedure TMainFrm.Button2Click(Sender: TObject);
begin
  MainFrm.Close;
end;

procedure TMainFrm.FormShow(Sender: TObject);
begin
  IP:=My_LocalIP;
  lblIP.Caption := 'IP : ' + IP;
end;

procedure TMainFrm.SetIP(const Value: string);
begin
  if FIP <> Value then
    FIP:=Value;
end;

procedure TMainFrm.SetPort(const Value: integer);
begin
  if FPort <> Value then
    FPort := Value;
end;



end.
