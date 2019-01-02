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
  classes,
  System.SysUtils,
  dialogs,
  GitAutoUpdate in 'units\GitAutoUpdate.pas',
  DownloaderTool in 'units\DownloaderTool.pas',
  KFTypes in 'units\KFTypes.pas',
  toolLanguage in 'units\toolLanguage.pas';

const
  UPDATEPARAM = '-installupdate';
  LOCALIZATIONFILE ='KF2ServerTool.lc';
{$R *.res}
{$R 'Manifest.res' 'Manifest.rc'}

function VerifyToInstallUpdate(): Boolean;
var
  ExeName: String;
  exePath: String;
  fSource: TStringList;
 // i: Integer;
  upd: TGitAutoUpdate;
begin
  Result := False;
  {
    fSource := TStringList.Create;
    try
    for i := 0 to ParamCount do
    fSource.Add(IntToStr( i) + ': ' + ParamStr(i));
    ShowMessage(fSource.Text);
    finally
    FreeAndNil(fSource);
    end;
  }

  if ParamCount > 1 then
  begin
    if ParamStr(1) = UPDATEPARAM then
    begin
      try
        exePath := ParamStr(2);
        ExeName := ExtractFileName(exePath);
        fSource := TStringList.Create;
        try
          if FileExists(exePath) then
          begin
            // KillProcessByName(ExeName);
            Sleep(500);

            fSource.Add(exePath);
            fSource.Add(ExtractFilePath(exePath) + LOCALIZATIONFILE);  //Delete old localization file
            FileOperation(fSource, '', 3); // deleteOldExe
            Sleep(100);
            fSource.Clear;
            fSource.Add(Application.ExeName);
            FileOperation(fSource, exePath, 2); // copyNewExe
            fSource.Clear;
            fSource.Add( ExtractFilePath(Application.ExeName)+LOCALIZATIONFILE);
            FileOperation(fSource,ExtractFilePath(exePath) +LOCALIZATIONFILE, 2); // copyLocalizationFile
            Sleep(100);
            ExecuteFile(0, exePath, '', 1);
            Result := True;
          end;
        Finally
          FreeAndNil(fSource);
        end;
      except
        on E: Exception do
          ShowMessage('Falied to install Update : ' + E.Message);
      end;
    end;

  end
  else
  begin

    upd := TGitAutoUpdate.Create(ExtractFilePath(Application.ExeName));
    try
      upd.DeleteUpdateFolder;
    finally
      FreeAndNil(upd);
    end;

  end;
end;

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  {$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
{$ENDIF}
  Application.Title := 'KF2 Server Tool';
  if VerifyToInstallUpdate then
    exit;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;

end.
