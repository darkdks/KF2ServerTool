unit uFormLanguageTranslator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, toolLanguage, Vcl.Grids,
  Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    cbLanguage: TComboBox;
    Label1: TLabel;
    pnlStrings: TScrollBox;
    procedure FormCreate(Sender: TObject);
    procedure cbLanguageChange(Sender: TObject);
  private
    procedure LoadLanguage;
    { Private declarations }
  public
  var
    tlTool: TKFTranslation;
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.cbLanguageChange(Sender: TObject);
begin
  LoadLanguage
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  availableLanguages: TKFLanguages;
  I: Integer;
begin
  tlTool := TKFTranslation.Create(ExtractFilePath(Application.ExeName));
  tlTool.loadSource('KF2ServerTool.lc');
  tlTool.setLanguage('EN');
  availableLanguages := tlTool.getLanguages;
  for I := 0 to High(availableLanguages) do
  begin
    cbLanguage.Items.Add(availableLanguages[I].name);
  end;

end;

procedure TForm1.LoadLanguage();
var
  I: Integer;
  key, text: string;
  pnlContainer: TPanel;
  edtTrans: TEdit;
  lblkey: TLabel;
begin
  tlTool.setLanguage(tlTool.getLanguageByName(cbLanguage.text).initial);

  for I := 0 to tlTool.getCurrentLanguage.tlsource.Count - 1 do
  begin
    key := tlTool.getCurrentLanguage.tlsource.KeyNames[I];;
    key := StringReplace(key, '"', '', [rfReplaceAll]);
    key := StringReplace(key, '\n', #10 + #13, [rfReplaceAll]);
    text := tlTool.getCurrentLanguage.tlsource.ValueFromIndex[I];
    text := StringReplace(text, '"', '', [rfReplaceAll]);
    text := StringReplace(text, '\n', #10 + #13, [rfReplaceAll]);

    pnlContainer := TPanel.Create(pnlStrings);
    pnlStrings.InsertControl(pnlContainer);
    pnlContainer.Align := alTop;
    lblkey := TLabel.Create(pnlContainer);
    lblkey.Caption := key;
    lblkey.Align := alTop;
    lblkey.Parent := pnlContainer;
    edtTrans := TEdit.Create(pnlContainer);
    edtTrans.text := text;
    edtTrans.Align := alBottom;
    pnlContainer.InsertControl(edtTrans);
    pnlContainer.InsertControl(lblkey);

    edtTrans.Parent := pnlContainer;
    pnlContainer.Height := lblkey.Height + edtTrans.Height + 30 { margin };

  end;

end;

end.
