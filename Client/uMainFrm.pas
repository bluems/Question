unit uMainFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, System.Win.ScktComp;

type
  TMainFrm = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    ClientSocket1: TClientSocket;
    Image2: TImage;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ClientSocket1Connect(Sender: TObject; Socket: TCustomWinSocket);
    procedure FormShow(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
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
  MainFrm: TMainFrm;
  sHost: string = '127.0.0.1';
  sPort: integer = 3030;

implementation

{$R *.dfm}

procedure TMainFrm.Button1Click(Sender: TObject);
begin
  application.Terminate;
end;

procedure TMainFrm.ClientSocket1Connect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  ClientSocket1.Socket.SendText('Hi, Server');
end;

procedure TMainFrm.ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
var
  List1:TStringList;
  readString:string;
begin
  readString:= Socket.ReceiveText;

  List1:=TStringList.Create;
  List1.Delimiter:=',';
  List1.DelimitedText:=readString;
  if List1[0] = pcname then
  begin
    if List1[1] = 'close' then
    begin
      Image2Click(sender);
    end;
  end;


end;

procedure TMainFrm.FormCreate(Sender: TObject);
var
  ScrWidth: integer;
  ScrHeight: integer;
begin
  ScrWidth := screen.WorkAreaWidth;
  ScrHeight := screen.WorkAreaHeight;

  MainFrm.Top := ScrHeight - MainFrm.Height;
  MainFrm.Left := ScrWidth - MainFrm.Width;

  ClientSocket1.Host := sHost;
  ClientSocket1.Port := sPort;
end;

procedure TMainFrm.FormShow(Sender: TObject);
begin
  ClientSocket1.Active := true;

end;

procedure TMainFrm.Image1Click(Sender: TObject);
begin
    ClientSocket1.Socket.SendText(pcName + ',' + userName + ',true');
    Image2.Visible := true;
end;

procedure TMainFrm.Image2Click(Sender: TObject);
begin
  ClientSocket1.Socket.SendText(pcName + ',' + userName + ',false');
  Image2.Visible := false;
end;

procedure TMainFrm.SetPCName(const AValue: string);
begin
  if FPCName <> AValue then
  begin
    FPCName := AValue;
  end;
end;

procedure TMainFrm.SetUserName(const AValue: string);
begin
  if FUserName <> AValue then
  begin
    FUserName := AValue;
  end;
end;

end.
