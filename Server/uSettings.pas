unit uSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TSettingsFrm = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    { Private declarations }
    FPort: integer;
    FName: string;
    FRoom: string;
  public
    { Public declarations }
    procedure SetPort(Const value: integer);
    procedure SetAdminName(Const AValue: string);
    procedure SetRoom(Const AValue: string);
    property Port: integer read FPort write SetPort;
    property AdminName: string read FName write SetAdminName;
    property Room: string read FRoom write SetRoom;

  end;

var
  SettingsFrm: TSettingsFrm;

implementation

{$R *.dfm}

procedure TSettingsFrm.Button1Click(Sender: TObject);
begin
  Port := strtoint(Edit1.Text);
  AdminName := Edit2.Text;
  Room := Edit3.Text;
end;

procedure TSettingsFrm.Button3Click(Sender: TObject);
begin
  showmessage(inttostr(FPort));
end;

procedure TSettingsFrm.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
    Button1.Click;
end;

procedure TSettingsFrm.FormShow(Sender: TObject);
begin
  Edit1.Text := inttostr(Port);
  Edit2.Text := AdminName;
  Edit3.Text := Room;
end;

procedure TSettingsFrm.SetAdminName(const AValue: string);
begin
  if FName <> AValue then
  begin
    FName := AValue;
  end;
end;

procedure TSettingsFrm.SetPort(const value: integer);
begin
  if FPort <> value then
  begin
    FPort := value;
  end;
end;

procedure TSettingsFrm.SetRoom(const AValue: string);
begin
  if FRoom <> AValue then
  begin
    FRoom := AValue;
  end;

end;

end.
