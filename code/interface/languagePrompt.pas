unit languagePrompt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ToolLanguage;

type
  TFormSetLanguage = class(TForm)
    cbbLanguageSet: TComboBox;
    lblSelectLanguage: TLabel;
    btnOk: TButton;
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
    procedure fillCBLanguages(lgTool: TKFTranslation);
  public
    { Public declarations }

    function askLang(lgTool: TKFTranslation): String;
  end;

var
  FormSetLanguage: TFormSetLanguage;

implementation

{$R *.dfm}

procedure TFormSetLanguage.btnOkClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFormSetLanguage.fillCBLanguages(lgTool: TKFTranslation);
var
  aLang: TKFCustomLanguage;
begin
  cbbLanguageSet.Clear;
  for aLang in lgTool.getLanguages do
    cbbLanguageSet.Items.Add(aLang.name);

  if cbbLanguageSet.Items.Count > 0 then
    cbbLanguageSet.ItemIndex := 0;
end;

function TFormSetLanguage.askLang(lgTool: TKFTranslation): String;
begin
  fillCBLanguages(lgTool);
  if self.ShowModal = mrOk then
    result := lgTool.getLanguageByName(cbbLanguageSet.text).initial
  else
    result := 'EN'
end;

end.
