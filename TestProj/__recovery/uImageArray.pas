unit uImageArray;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure PNGLoad;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  pcList: array[0..99] of timage;
  ResStreamPngGray:TResourceStream;
  ResStreamPngRed:TResourceStream;
  ResStreamPngSky:TResourceStream;
  DllHandle: THandle;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  pcList[0]:= timage.Create(form1);
  pcList[0].Canvas.rectangle(0,0,100,100);
  DllHandle := LoadLibrary('imgRes.dll');
  ResSTreamPngGray:=TResourceStream.Create(DllHandle, 'btGray','PNG');
end;

procedure TForm1.PNGLoad;
begin
   pcList[0].Picture.Bitmap.assign(resStreamPngGray);
end;

end.
