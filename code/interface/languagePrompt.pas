unit languagePrompt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormSetLanguage = class(TForm)
    cbbLanguageSet: TComboBox;
    lblSelectLanguage: TLabel;
    btnOk: TButton;
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSetLanguage: TFormSetLanguage;

implementation

{$R *.dfm}

procedure TFormSetLanguage.btnOkClick(Sender: TObject);
begin
ModalResult := mrOk;
end;

end.
