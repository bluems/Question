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
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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

implementation

{$R *.dfm}

procedure TMainFrm.Button1Click(Sender: TObject);
begin
  application.Terminate;
end;



procedure TMainFrm.FormCreate(Sender: TObject);
var
  ScrWidth:integer;
  ScrHeight:integer;
begin
  ScrWidth:=screen.WorkAreaWidth;
  ScrHeight:=screen.WorkAreaHeight;

  MainFrm.Top := ScrHeight - MainFrm.Height;
  MainFrm.Left := ScrWidth - MainFrm.Width;
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
