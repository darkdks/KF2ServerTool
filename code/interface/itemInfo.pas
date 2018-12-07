unit itemInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage;

type
  TFormItemInfo = class(TForm)
    pnl1: TPanel;
    img1: TImage;
    lblTitle: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormItemInfo: TFormItemInfo;

implementation

{$R *.dfm}

procedure TFormItemInfo.FormCreate(Sender: TObject);
begin
lbl1.Caption := '';
lbl2.Caption := '';
lbl3.Caption := '';
lbl4.Caption := '';
lbl5.Caption := '';
lblTitle.Caption := '';

end;

end.
