program KF2ServerTool;

uses
  Forms,
  Main in 'Main.pas' {FormMain},
  AddItem in 'AddItem.pas' {FormAdd},
  Workshop in 'Workshop.pas' {FormWorkshop},
  KFFile in 'KFFile.pas',
  KFRedirect in 'KFRedirect.pas',
  MiscFunc in 'MiscFunc.pas',
  KFServerTool in 'KFServerTool.pas',
  ItemProgress in 'ItemProgress.pas' {formPB},
  frmDnt in 'frmDnt.pas' {frmDonate},
  PathDialog in 'PathDialog.pas' {kfPathDialog},
  Queue in 'Queue.pas' {frmQueue},
  uRedirectItemsDialog in 'uRedirectItemsDialog.pas' {frmRedirectItemsDialog};

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
  Application.CreateForm(TfrmRedirectItemsDialog, frmRedirectItemsDialog);
  Application.Run;
end.
