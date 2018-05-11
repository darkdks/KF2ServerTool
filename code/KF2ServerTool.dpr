program KF2ServerTool;

uses
  Forms,
  Main in 'interface\Main.pas' {FormMain},
  AddItem in 'interface\AddItem.pas' {FormAdd},
  Workshop in 'interface\Workshop.pas' {FormWorkshop},
  KFFile in 'units\KFFile.pas',
  KFRedirect in 'units\KFRedirect.pas',
  MiscFunc in 'units\MiscFunc.pas',
  KFServerTool in 'units\KFServerTool.pas',
  ItemProgress in 'interface\ItemProgress.pas' {formPB},
  frmDnt in 'interface\frmDnt.pas' {frmDonate},
  PathDialog in 'interface\PathDialog.pas' {kfPathDialog},
  Queue in 'interface\Queue.pas' {frmQueue},
  uRedirectItemsDialog in 'interface\uRedirectItemsDialog.pas' {frmRedirectItemsDialog},
  KFWksp in 'units\KFWksp.pas',
  Vcl.Themes,
  Vcl.Styles,
  GitAutoUpdate in 'units\GitAutoUpdate.pas',
  downloaderTool in 'units\DownloaderTool.pas';

{$R *.res}
{$R 'Manifest.res' 'Manifest.rc'}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'KF2 Server Tool';
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
