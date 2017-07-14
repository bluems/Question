unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls, IdBaseComponent, IdComponent, IdCustomTCPServer, IdTCPServer,
  System.Win.ScktComp, System.ImageList, Vcl.ImgList;

type
  TMainFrm = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    lblIP: TLabel;
    ServerSocket1: TServerSocket;
    Memo1: TMemo;
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
    GrayImage: TImage;
    RedImage: TImage;
    SkyImage: TImage;
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
  private
    { Private declarations }
    FPort: integer;
    FIP: string;
    imgCount:integer;
    myImg: array of TImage;
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
var
  i:integer;
begin
  Port := 3030;
  SetLength(myImg,36);
  for i := 1 to 35 do
    begin
       myImg[i]:=(FindComponent('Image'+inttostr(i)) as Timage);
       myImg[i].Stretch:=true;
       myImg[i].Picture:=GrayImage.Picture;
    end;


end;

procedure TMainFrm.FormShow(Sender: TObject);
begin
  IP := My_LocalIP;
  ServerInfoRedraw(IP, Port);
end;

{
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
end;     }

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
  target:integer;
begin
  readString := Socket.ReceiveText;
  Memo1.Lines.Add(Socket.RemoteHost + ': ' + readString);

  List1 := TStringList.Create;
  List1.Delimiter := ',';
  List1.DelimitedText := readString;

  target:= strtoint(List1[0]);
  if List1[2] = 'add' then
  begin
    myImg[target].Picture := SkyImage.Picture;
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
