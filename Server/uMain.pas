unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls, IdBaseComponent, IdComponent, IdCustomTCPServer, IdTCPServer,
  System.Win.ScktComp;

type
  TMainFrm = class(TForm)
    GImage1: TImage;
    GImage2: TImage;
    GImage3: TImage;
    GImage4: TImage;
    GImage5: TImage;
    GImage6: TImage;
    GImage7: TImage;
    GImage8: TImage;
    GImage9: TImage;
    GImage10: TImage;
    GImage11: TImage;
    GImage12: TImage;
    GImage13: TImage;
    GImage14: TImage;
    GImage15: TImage;
    GImage16: TImage;
    GImage17: TImage;
    GImage18: TImage;
    GImage19: TImage;
    GImage20: TImage;
    GImage21: TImage;
    GImage22: TImage;
    GImage23: TImage;
    GImage24: TImage;
    GImage25: TImage;
    GImage26: TImage;
    GImage27: TImage;
    GImage28: TImage;
    GImage29: TImage;
    GImage30: TImage;
    GImage31: TImage;
    GImage32: TImage;
    GImage33: TImage;
    GImage34: TImage;
    GImage35: TImage;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    lblIP: TLabel;
    ImageRed: TImage;
    ImageSky: TImage;
    ImageGray: TImage;
    ServerSocket1: TServerSocket;
    Memo1: TMemo;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure GImage35Click(Sender: TObject);
  private
    { Private declarations }
    FPort: integer;
    FIP: string;
  public
    { Public declarations }
    procedure SetPort(Const Value: integer);
    procedure SetIP(Const Value: string);
    procedure ServerInfoRedraw(Const Aip: string; Const Aport: integer);
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
  LSettingsFrm: TSettingsFrm;
begin
  LSettingsFrm := TSettingsFrm.Create(self);
  LSettingsFrm.Port := Port;
  try
    if LSettingsFrm.ShowModal = mrOk then
    begin
      Port := LSettingsFrm.Port;
    end;
    showmessage(inttostr(Port));
  finally
    LSettingsFrm.Destroy;
    LSettingsFrm := nil;
    ServerInfoRedraw(IP, Port);
  end;

end;

procedure TMainFrm.Button2Click(Sender: TObject);
begin
  MainFrm.Close;
end;

procedure TMainFrm.Button3Click(Sender: TObject);
begin
  if ServerSocket1.Active = false then
  begin
    ServerSocket1.Port := Port;
    ServerSocket1.Active := true;
    (Sender As TButton).Caption := 'Stop';
  end
  else
  begin
    ServerSocket1.Active := false;
    (Sender As TButton).Caption := 'Run';
  end;
end;

procedure TMainFrm.FormCreate(Sender: TObject);
begin
  Port := 3030;
end;

procedure TMainFrm.FormShow(Sender: TObject);
begin
  IP := My_LocalIP;
  ServerInfoRedraw(IP, Port);
  GImage1.Picture := ImageGray.Picture;
  GImage2.Picture := ImageGray.Picture;
  GImage3.Picture := ImageGray.Picture;
  GImage4.Picture := ImageGray.Picture;
  GImage5.Picture := ImageGray.Picture;
  GImage6.Picture := ImageGray.Picture;
  GImage7.Picture := ImageGray.Picture;
  GImage8.Picture := ImageGray.Picture;
  GImage9.Picture := ImageGray.Picture;
  GImage10.Picture := ImageGray.Picture;
  GImage11.Picture := ImageGray.Picture;
  GImage12.Picture := ImageGray.Picture;
  GImage13.Picture := ImageGray.Picture;
  GImage14.Picture := ImageGray.Picture;
  GImage15.Picture := ImageGray.Picture;
  GImage16.Picture := ImageGray.Picture;
  GImage17.Picture := ImageGray.Picture;
  GImage18.Picture := ImageGray.Picture;
  GImage19.Picture := ImageGray.Picture;
  GImage20.Picture := ImageGray.Picture;
  GImage21.Picture := ImageGray.Picture;
  GImage22.Picture := ImageGray.Picture;
  GImage23.Picture := ImageGray.Picture;
  GImage24.Picture := ImageGray.Picture;
  GImage25.Picture := ImageGray.Picture;
  GImage26.Picture := ImageGray.Picture;
  GImage27.Picture := ImageGray.Picture;
  GImage28.Picture := ImageGray.Picture;
  GImage29.Picture := ImageGray.Picture;
  GImage30.Picture := ImageGray.Picture;
  GImage31.Picture := ImageGray.Picture;
  GImage32.Picture := ImageGray.Picture;
  GImage33.Picture := ImageGray.Picture;
  GImage34.Picture := ImageGray.Picture;
  GImage35.Picture := ImageGray.Picture;
end;

procedure TMainFrm.GImage35Click(Sender: TObject);
var

begin
  if count = false then
  begin
    count := true;
    //해결중 표시
  end else
  begin
    count := false;
    GImage35.Picture := ImageSky.Picture;
  end;
end;

procedure TMainFrm.ServerInfoRedraw(const Aip: string; const Aport: integer);
begin
  lblIP.Caption := 'IP : ' + Aip + ' / Port : ' + inttostr(Aport);
end;

procedure TMainFrm.ServerSocket1ClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  Memo1.Lines.Add('Connect: ' + Socket.RemoteHost);
end;

procedure TMainFrm.ServerSocket1ClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  Memo1.Lines.Add('Disconnected: ' + Socket.RemoteHost);
end;

procedure TMainFrm.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  List1: TStringList;
  readString: string;

begin
  readString := Socket.ReceiveText;
  Memo1.Lines.Add(Socket.RemoteHost + ': ' + readString);

  List1 := TStringList.Create;
  List1.Delimiter := ',';
  List1.DelimitedText := readString;

  if List1[0] = '35' then
  begin
    if List1[2] = 'true' then
    begin
      GImage35.Picture := ImageRed.Picture;
    end else
    begin
      GImage35.Picture := ImageSky.Picture;
    end;

  end;

end;

procedure TMainFrm.SetIP(const Value: string);
begin
  if FIP <> Value then
    FIP := Value;
end;

procedure TMainFrm.SetPort(const Value: integer);
begin
  if FPort <> Value then
    FPort := Value;
end;

end.
