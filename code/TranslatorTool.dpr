program TranslatorTool;

uses
  Vcl.Forms,
  uFormLanguageTranslator in 'uFormLanguageTranslator.pas' {Form1},
  toolLanguage in 'units\toolLanguage.pas',
  MiscFunc in 'units\MiscFunc.pas';


{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
