unit uClient;

interface

type
  TQClient = class(Tobject)
  private
    FHost: string;
    FHostname: string;
  public
    constructor Create; override;
    procedure SetHost(Const AValue: string);
    procedure SetHostname(Const AValue: string);
    property Host: string read FHost write SetHost;
    property Hostname: string read FHostname write SetHostname;
  end;

implementation

{ TQClient }

constructor TQClient.Create;
begin
  inherited;
  FHost := '';
  FHostname := '';
end;

procedure TQClient.SetHost(const AValue: string);
begin
  if FHost <> AValue then
    FHost := AValue;
end;

procedure TQClient.SetHostname(const AValue: string);
begin
  if FHostname <> AValue then
    FHostname := AValue;
end;

end.
