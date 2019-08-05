unit frmDnt;

interface

uses
  Windows,
  Classes,
  Controls,
  Forms,
  ShellAPI,
  StdCtrls,
  ExtCtrls,
  jpeg;

type
  TfrmDonate = class(TForm)
    imgPagSeguro: TImage;
    imgPayPal: TImage;
    lblPayPal: TLabel;
    lblPagSeguro: TLabel;
    lblTextDonate: TLabel;
    procedure imgPagSeguroClick(Sender: TObject);
    procedure imgPayPalClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDonate: TfrmDonate;

implementation

uses main;
{$R *.dfm}

procedure TfrmDonate.FormCreate(Sender: TObject);
begin
  lblTextDonate.Caption := formMain._s(lblTextDonate.Caption);
end;

procedure TfrmDonate.imgPagSeguroClick(Sender: TObject);
begin
  ShellExecute(0, 'open', PChar('https://pag.ae/blmH1h2'), nil, nil,
    SW_SHOWNORMAL);
end;

procedure TfrmDonate.imgPayPalClick(Sender: TObject);
begin
  ShellExecute(0, 'open',
    PChar('https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=Z5TNFU5Y468X2&lc=BR&item_name=DKS%20DARK%20PROJECTS'),
    nil, nil, SW_SHOWNORMAL);

end;

end.
