unit KFServerInstall;

interface

uses
  classes, System.SysUtils, MiscFunc, JclSysUtils, Stdctrls, forms;

type
  KFUPDATE_TYPE = (KFU_CURRENT, KFU_BETA, KFU_INTEGRITY_CURRENT,
    KFU_INTEGRITY_BETA);

  TKFServerInstall = class(TObject)
  private
    steamCmdPath: String;
  public

    function InstallServer(Path: String; Handle: Cardinal): Boolean;
    procedure SetSteamCmdPath(Path: String);
    function GetSteamCmdPath(): string;
    function generateDefaultConfigFiles(serverPath: String): Boolean;
    procedure UpdateInstallation(updateType: KFUPDATE_TYPE; serverPath: String;
      Handle: Cardinal);
   procedure returnHandle(const Text: string);
  var
      memoOut: ^TMemo;
      abort: ^Boolean;
    constructor Create();
    destructor Destroy; override;

  end;

implementation

{ TKFServerInstall }
uses KFTypes;



constructor TKFServerInstall.Create;
begin
  steamCmdPath := '';
end;

destructor TKFServerInstall.Destroy;
begin

  inherited;
end;

function TKFServerInstall.generateDefaultConfigFiles(serverPath: String): Boolean;
begin
serverPath := IncludeTrailingPathDelimiter(serverPath);
  ExecuteFileAndWait(0, serverPath + STARTSERVERBIN, '', 0 { SW_HIDE } ,
    60 { SECONDS } );
  KillProcessByName(ExtractFileName(STARTSERVERBIN));
  Result := (fileExists(serverPath + 'KFGame\Config\PCServer-KFEngine.ini')) and
    (fileExists(serverPath + 'KFGame\Config\PCServer-KFGame.ini')) and
    (fileExists(serverPath + 'KFGame\Config\KFWeb.ini'));
end;

function TKFServerInstall.GetSteamCmdPath: string;
begin
  Result := steamCmdPath;
end;

function TKFServerInstall.InstallServer(Path: String; Handle: Cardinal)
  : Boolean;
var
  cmdToolArgs: string;
  abortP: Boolean;
begin
abortP := False;
  if steamCmdPath = '' then
    raise Exception.Create('Steam cmd path not set');
  cmdToolArgs := '+login anonymous +force_install_dir "' + Path +
    '" +app_update 232130 +exit';
  ExecuteFileAndWait(Handle, steamCmdPath, cmdToolArgs, 1 { SW_NORMAL } );
   //Execute({steamCmdPath + cmdToolArgs}'dir',returnHandle, True, @abort, ppNormal, false);
  Sleep(2000);
  Result := (fileExists(IncludeTrailingPathDelimiter(Path) + STARTSERVERBIN)) and
    (fileExists(IncludeTrailingPathDelimiter(Path) + 'KF2Server.bat'));

end;

procedure TKFServerInstall.returnHandle(const Text: string);
var mmo: TMemo;
begin
mmo := @memoOut;
   if Assigned(mmo) then begin

     mmo.Lines.Add(text);
   end;
   Application.ProcessMessages;
end;

procedure TKFServerInstall.SetSteamCmdPath(Path: String);
begin
  if fileExists(Path) then
    steamCmdPath := Path
  else
    raise Exception.Create('Invalid Steam cmd path');

end;

procedure TKFServerInstall.UpdateInstallation(updateType: KFUPDATE_TYPE;
  serverPath: String; Handle: Cardinal);
var
  cmdToolArgs: String;
begin
  if steamCmdPath = '' then
    raise Exception.Create('Steam cmd path not set');

  case updateType of
    KFU_CURRENT:
      cmdToolArgs := '+login anonymous +force_install_dir ' + serverPath +
        ' +app_update 232130 +exit';
    KFU_BETA:
      cmdToolArgs := '+login anonymous +force_install_dir ' + serverPath +
        ' +app_update 232130 -beta +exit';
    KFU_INTEGRITY_CURRENT:
      cmdToolArgs := '+login anonymous +force_install_dir ' + serverPath +
        ' +app_update 232130 validate +exit';
    KFU_INTEGRITY_BETA:
      cmdToolArgs := '+login anonymous +force_install_dir ' + serverPath +
        ' +app_update 232130 validate -beta preview +exit';
  end;
  ExecuteFileAndWait(Handle, steamCmdPath, cmdToolArgs, 1 { SW_NORMAL } );

end;

end.
