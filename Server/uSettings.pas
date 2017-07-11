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
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
    FPort: integer;
  public
    { Public declarations }
    procedure SetPort(Const value: integer);
    property Port: integer read FPort write SetPort;

  end;

var
  SettingsFrm: TSettingsFrm;

implementation

{$R *.dfm}

procedure TSettingsFrm.Button1Click(Sender: TObject);
begin
  SetPort(strtoint(Edit1.Text));
end;

procedure TSettingsFrm.Button3Click(Sender: TObject);
begin
  showmessage(inttostr(FPort));
end;


procedure TSettingsFrm.FormShow(Sender: TObject);
begin
  edit1.Text:= inttostr(port);
end;

procedure TSettingsFrm.SetPort(const value: integer);
begin
  if FPort <> value then
    FPort := value;
end;

end.
