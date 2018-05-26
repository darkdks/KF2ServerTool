unit GitAutoUpdate;

interface

uses
  REST.Client, json, SysUtils, IPPeerClient, MiscFunc, classes,
  System.zip, downloaderTool;

type
  TLatestRelease = class(TObject)
  public
    download_url: String;
    change_log: String;
    version: String;
    constructor Create();
  end;

  TGitAutoUpdate = class(TObject)

  private
    workingPath: string;

  var

  public
  var
    function DownloadAndExtractUpdate(updateURL: String; dlManager: TDownloadManager;
      setupExe: string;  GenerateTempSetup: Boolean)
      : Boolean;
    function GetLatestRelease(resource: String): TLatestRelease;
    procedure PrepareUpdateFolder();
    procedure DeleteUpdateFolder();
    procedure executeUpdateInstall(exeName: String; exeParam: String);
    constructor Create(Path: string);
    destructor Destroy; override;

  const

    GITAPIURL = 'https://api.github.com';
    UPDATEFOLDER = '_UPDATE';
    UPDATEFILE = 'KF2SVTOOLUPDATE.zip';
    TEMUPDATEFILE = 'UPDATEINSTALL.EXE';
  end;

implementation

{ TGitAutoUpdate }

constructor TGitAutoUpdate.Create(Path: string);
begin
  workingPath := IncludeTrailingPathDelimiter(Path);
end;



destructor TGitAutoUpdate.Destroy;
begin

  inherited;
end;

function TGitAutoUpdate.DownloadAndExtractUpdate(updateURL: String;
  dlManager: TDownloadManager; setupExe: string;
  GenerateTempSetup: Boolean): Boolean;
var
  dlTool: TDownloaderTool;
  updateDownloaded: Boolean;
  fSource: TStringlist;
  updateFolderPath: string;
  updateFilePath: String;
  updateZipFile: TZipFile;
begin
  dlTool := TDownloaderTool.Create;
  updateFolderPath := workingPath + UPDATEFOLDER + PathDelim;
  updateFilePath := updateFolderPath + UPDATEFILE;
  Result := False;


  //Prepare Update Folder
  PrepareUpdateFolder;

  // Download
  try
    try
      updateDownloaded := dlTool.downloadFile(updateURL, updateFilePath,
        dlManager);
    finally
      FreeAndNil(dlTool);
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create('Error downloading the update: ' + E.Message);
      Exit
    end;
  end;
  // extract update
  if updateDownloaded then
  begin
    if TZipFile.IsValid(updateFilePath) then
    begin
      updateZipFile := TZipFile.Create;
      try
        updateZipFile.Open(updateFilePath, zmRead);
        updateZipFile.ExtractAll(updateFolderPath);
        updateZipFile.Close;
      finally
        FreeAndNil(updateZipFile);
      end;
    end;

  end;

  if FileExists(updateFolderPath + setupExe) then
  begin
    //GenerateTempSetup
    if GenerateTempSetup then
    begin
      fSource := TStringlist.Create;
      try
        fSource.Add(updateFolderPath + setupExe);
        Result := FileOperation(fSource, updateFolderPath + TEMUPDATEFILE,
          2 { FO_COPY } )

      finally
        FreeAndNil(fSource);
      end;
    end
    else
    begin
      Result := True;
    end;
  end;
end;

procedure TGitAutoUpdate.executeUpdateInstall(exeName, exeParam: String);
var updateFolderPath: String;
begin
  updateFolderPath := workingPath + UPDATEFOLDER + PathDelim;
ExecuteFile(0, updateFolderPath + exeName, exeParam, 1);
end;

function TGitAutoUpdate.GetLatestRelease(resource: String): TLatestRelease;
var
  jvalue: TJSONObject;
  jAssets: TJSONArray;
  tag_name, body, download_url: string;
  restClient: TRESTClient;
  restRequest: TRESTRequest;
  restResonse: TRESTResponse;
begin
  Result := TLatestRelease.Create;
  restClient := TRESTClient.Create(GITAPIURL);
  restRequest := TRESTRequest.Create(restClient);
  restResonse := TRESTResponse.Create(restClient);
  try
    restRequest.Client := restClient;
    restRequest.Response := restResonse;
    restRequest.resource := 'repos/' + resource + '/releases/latest';
    restRequest.Execute;
    try
      jvalue := restResonse.JSONValue as TJSONObject;
    except
      Exit
    end;
    try
      jAssets := jvalue.GetValue('assets') as TJSONArray;
    except
      Exit
    end;
    try
      tag_name := (jvalue as TJSONObject).GetValue('tag_name').ToString;
    except
      tag_name := 'error';
    end;
    try
      body := (jvalue as TJSONObject).GetValue('body').ToString;
    except
      body := 'error';
    end;
    try
      download_url := (jAssets.Items[0] as TJSONObject)
        .GetValue('browser_download_url').ToString;
    except
      download_url := 'error';
    end;
    Result.download_url := (Copy(download_url, 2, length(download_url) - 2));
    Result.version := (Copy(tag_name, 2, length(tag_name) - 2));
    Result.change_log := (Copy(body, 2, length(body) - 2));

  finally
    FreeAndNil(restClient);
  end;

end;

procedure TGitAutoUpdate.PrepareUpdateFolder;
 var fSource: TStringList;
 updateFolderPath : String;
begin
 updateFolderPath := workingPath + UPDATEFOLDER + PathDelim;
  try
    if DirectoryExists(updateFolderPath) then
    begin
       fSource := GetAllFilesSubDirectory(updateFolderPath, '*');
      try
        if fSource.Count > 0 then
          FileOperation(fSource, '', 3 { FO_DELETE } );
      finally
        FreeAndNil(fSource);
      end;
    end
    else
      CreateNewFolderInto(workingPath, UPDATEFOLDER);
  except
    on E: Exception do
      raise Exception.Create('Error prepraring update folder: ' + E.Message);

  end;
end;

procedure TGitAutoUpdate.DeleteUpdateFolder;
 var fSource: TStringList;
 updateFolderPath : String;
begin
 updateFolderPath := workingPath + UPDATEFOLDER + PathDelim;

  try
    if DirectoryExists(updateFolderPath) then
    begin
     fSource := TStringList.Create;
      try
        fSource.Add(updateFolderPath);
        FileOperation(fSource, '', 3 { FO_DELETE } );
      finally
        FreeAndNil(fSource);
      end;
    end
  except
    on E: Exception do
      raise Exception.Create('Cant delete update folder: ' + E.Message);
  end;
end;

{ TLatestRelease }

constructor TLatestRelease.Create;
begin
  download_url := 'unknowed';
  change_log := 'unknowed';
  version := '0';
end;

end.
