unit frmDnt;

interface

uses
  Windows, Classes, Controls, Forms,
  ShellAPI, StdCtrls, ExtCtrls, jpeg;

type
  TfrmDonate = class(TForm)
    img1: TImage;
    img2: TImage;
    lbl1: TLabel;
    lbl2: TLabel;
    lblTextDonate: TLabel;
    procedure img1Click(Sender: TObject);
    procedure img2Click(Sender: TObject);
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

procedure TfrmDonate.img1Click(Sender: TObject);
begin
  ShellExecute(0, 'open', PChar('https://pag.ae/blmH1h2'), nil, nil,
    SW_SHOWNORMAL);
end;

procedure TfrmDonate.img2Click(Sender: TObject);
begin
  ShellExecute(0, 'open',
    PChar('https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=Z5TNFU5Y468X2&lc=BR&item_name=DKS%20DARK%20PROJECTS'),
    nil, nil, SW_SHOWNORMAL);

end;

end.
