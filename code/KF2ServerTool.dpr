program KF2ServerTool;

uses
  Forms,
  Main in 'Main.pas' {FormMain},
  AddMap in 'AddMap.pas' {FormAdd},
  Workshop in 'Workshop.pas' {FormWorkshop},
  KFFile in 'KFFile.pas',
  KFWksp in 'KFWksp.pas',
  UFuncoes in 'UFuncoes.pas',
  KFItemEntity in 'KFItemEntity.pas',
  ItemProgress in 'ItemProgress.pas' {formPB},
  frmDnt in 'frmDnt.pas' {frmDonate},
  PathDialog in 'PathDialog.pas' {kfPathDialog},
  Queue in 'Queue.pas' {frmQueue};

{$R *.res}
 {$R 'Manifest.res'}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'KF2 Server Tool';
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TfrmDonate, frmDonate);
  Application.CreateForm(TkfPathDialog, kfPathDialog);
  Application.CreateForm(TfrmQueue, frmQueue);
  Application.Run;
end.
