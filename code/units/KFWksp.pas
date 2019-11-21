unit KFWksp;

interface

uses
  Classes,
  SysUtils,
  MiscFunc,
  System.StrUtils,
  KFTypes,
{$IFDEF MSWINDOWS}
  System.Net.HttpClientComponent,
  System.Net.HttpClient,
  MSHTML,
  System.Net.URLClient,
  DownloaderTool,
  forms,
{$ENDIF}
  IOUtils;

type

  TKFWorkshop = class(TObject)

  private
  var
    svPath: string;
    FsteamCmdTool: string;
{$IFDEF MSWINDOWS}
    function GetWorkshopItemImageURL(ID: string): String;
{$ENDIF}
  public
  var

    constructor Create(serverPath: string);
    destructor Destroy; override;
{$IFDEF MSWINDOWS}
    function DownloadWorkshopImage(ID: String;
      dlManager: TDownloadManager): boolean;
{$ENDIF}
    function DownloadWorkshopItem(ID: string; VerboseCmd: boolean): boolean;
    function CopyItemToCache(ID: string): boolean;
    function RemoveServeItemCache(ID: string): boolean;
    function RemoveWorkshoItemCache(ID: string): boolean;
    function AddAcfReference(ID: string): boolean;
    function RemoveAcfReference(ID: string; removeAll: boolean): boolean;
    function GetMapName(MapFolder: string; withExt: boolean): string;
    function GetItemType(itemFolder: string): TKFItemType;
    function CreateBlankACFFile: boolean;
    property steamCmdTool: string read FsteamCmdTool write FsteamCmdTool;

  const
    // SteamCmdTool commands
    ST_LOGIN = '+login anonymous ';
    ST_INSTALLDIR = '+force_install_dir';
    ST_WKPITEM = '+workshop_download_item 232090';
    ST_VALIDADE = 'validate';
    ST_EXIT = '+exit';
    FO_DELETE = 3;
    SW_HIDE = 2;
    FO_COPY = 2;

  end;

implementation

{ TKFWorkshop }

function TKFWorkshop.AddAcfReference(ID: string): boolean;
begin

  Result := False;
end;

function TKFWorkshop.CopyItemToCache(ID: string): boolean;
var
  source: TStringList;
begin
  source := TStringList.Create;
  try
    source.Add(svPath + WKP_CACHEFOLDER + PathDelim + ID + PathDelim);
    Result := FileOperation(source, svPath + SERVERCACHEFOLDER + ID, FO_COPY);

  finally
    source.Free;
  end;
end;

constructor TKFWorkshop.Create(serverPath: string);

begin
  svPath := serverPath;
{$IFDEF LINUX64}
  steamCmdTool := 'steamcmd';
{$ELSE}
  steamCmdTool := serverPath + 'STEAMCMD\steamcmd.exe';
{$ENDIF}
end;

destructor TKFWorkshop.Destroy;
begin

  inherited;
end;

function TKFWorkshop.CreateBlankACFFile(): boolean;
var
  wkspacf: TStringList;
begin
  Result := False;
  wkspacf := TStringList.Create;
  try
    if DirectoryExists(svPath + WKP_ACFFILEFOLDER) = False then
      ForceDirectories(PWideChar(svPath + WKP_ACFFILEFOLDER));

{$IFDEF LINUX64}
    wkspacf.SaveToFile(svPath + WKP_ACFFILEFOLDER + WKP_ACFFILENAME,
      TEncoding.ANSI);
{$ELSE}
    wkspacf.SaveToFile(svPath + WKP_ACFFILEFOLDER + WKP_ACFFILENAME);
{$ENDIF }
  finally
    wkspacf.Free;
  end;
  if FileExists(svPath + WKP_ACFFILEFOLDER + WKP_ACFFILENAME) then
    Result := True;

end;
{$IFDEF MSWINDOWS}

function TKFWorkshop.DownloadWorkshopImage(ID: String;
  dlManager: TDownloadManager): boolean;
var
  dlTool: TDownloaderTool;
  imgURL: String;
  destIMG: String;
begin
  Result := False;
  imgURL := GetWorkshopItemImageURL(ID);
  destIMG := svPath + IMGCACHEFOLDER + ID + '.jpg';
  if imgURL <> '' then
  begin
    dlTool := TDownloaderTool.Create;
    try
      Result := dlTool.downloadFile(imgURL, destIMG, dlManager);
    finally
      FreeAndNil(dlTool);
    end;

  end;

end;
{$ENDIF}

function TKFWorkshop.DownloadWorkshopItem(ID: string;
  VerboseCmd: boolean): boolean;
var
  paramStCmd: string;
  itemSteamAppFolder: String;
  ItemType: TKFItemType;
  exResult: TStringList;
  aborEx: boolean;
begin
  if (svPath = '') then
  begin
    raise Exception.Create('ERROR: No server path found');
    Exit;
  end;

  paramStCmd := ST_LOGIN + ' ' + ST_INSTALLDIR + ' ' +
    StrEmAspas(svPath + STEAMAPPCACHEFOLDER) + ' ' + ST_WKPITEM + ' ' + ID + ' '
    + ST_EXIT;
  if VerboseCmd then
  begin
    Writeln('sv path: ' + svPath);
    Writeln('steamcmd tool: ' + steamCmdTool);
    Writeln('ParamStr: ' + paramStCmd);
  end;
  exResult := ExecuteTerminalProcess(steamCmdTool, paramStCmd, aborEx,
    procedure(text: String)
    begin
      if VerboseCmd then
        Writeln('Debug: ' + text);
{$IFDEF CONSOLE}
{$ELSE}
      Application.processmessages;
{$ENDIF}
    end);
  try
    if Assigned(exResult) then
    begin
      itemSteamAppFolder := svPath + WKP_CACHEFOLDER + PathDelim + ID +
        PathDelim;
      ItemType := GetItemType(itemSteamAppFolder);
      if (ItemType = KFMap) or (ItemType = KFmod) then
      begin
        Result := True;
      end
      else
      begin
        raise Exception.Create('Falied to download ' + ID);

      end;

    end
    else
    begin
      raise Exception.Create('Falied to launcher steamcmd');
    end;

  finally
    if Assigned(exResult) then
      FreeAndNil(exResult);

  end;
end;

function TKFWorkshop.GetMapName(MapFolder: string; withExt: boolean): string;
var
  mapsFound: TStringList;
var
  I: integer;
  mainKFMFile: String;
begin
  Result := '';
  try

    mapsFound := GetAllFilesSubDirectory(MapFolder, '*' + KF_MAPPREFIX);
    try
      if mapsFound.Count > 0 then
      begin
        // Get main kfm file
        for I := 0 to mapsFound.Count - 1 do
        begin
          if Pos('KF-', UpperCase(mapsFound[I])) > 1 then
          begin
            if withExt then
              mainKFMFile := ExtractFileName(mapsFound.Strings[I])
            else
              mainKFMFile := TPath.GetFileNameWithoutExtension
                (mapsFound.Strings[I]);
          end;

        end;
        if mainKFMFile = '' then
          Result := ExtractFileName(mapsFound.Strings[0])
        else
          Result := mainKFMFile;

      end;

    finally
      mapsFound.Free;
    end;
  except

    Result := '';
  end;
end;
{$IFDEF MSWINDOWS}

function TKFWorkshop.GetWorkshopItemImageURL(ID: string): String;
var
  httpRq: TNetHTTPClient;
  httpres: IHTTPResponse;
  imgURL: String;
  htmlContent: String;
  posBeginTagImg: integer;
  posEndTagImg: integer;
  imgTags: array [0 .. 2] of String;
  imgTagIdx: integer;
begin

  httpRq := TNetHTTPClient.Create(nil);
  imgTagIdx := 0;
  imgTags[0] := '<link rel="image_src" href="';
  imgTags[1] :=
    '<img id="previewImageMain" class="workshopItemPreviewImageMain" src="';
  imgTags[2] :=
    '<img id="previewImage" class="workshopItemPreviewImageEnlargeable" src="';
  try
    httpRq.UserAgent :=
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36';
    httpres := httpRq.Get
      ('https://steamcommunity.com/sharedfiles/filedetails/?id=' + ID,
      nil, nil);

    try
      htmlContent := httpres.ContentAsString;
      // Alternate img tags if not found
      while (Pos(imgTags[imgTagIdx], htmlContent) < 1) and
        (imgTagIdx < High(imgTags)) do
      begin
        Inc(imgTagIdx);
      end;
      if Pos(imgTags[imgTagIdx], htmlContent) < 1 then
        Exit;
      posBeginTagImg := Pos(imgTags[imgTagIdx], htmlContent) +
        Length(imgTags[imgTagIdx]);
      posEndTagImg := Pos('"', htmlContent.Substring(posBeginTagImg,
        Length(htmlContent) - posBeginTagImg)) + posBeginTagImg;
      imgURL := Copy(htmlContent, posBeginTagImg,
        posEndTagImg - posBeginTagImg);
    except
      on E: Exception do
        raise Exception.Create('Falied to extract IMG URL from HTML page');
    end;
    Result := imgURL;
  finally
    FreeAndNil(httpRq);

  end;
end;
{$ENDIF}

function TKFWorkshop.GetItemType(itemFolder: string): TKFItemType;
var
  ItemsFound: TStringList;
  I: integer;
  ext: string;
begin
  Result := KFUnknown;
  try
    // test if is map
    ItemsFound := GetAllFilesSubDirectory(itemFolder, '*.*');
    try

      for I := 0 to ItemsFound.Count - 1 do
      begin

        ext := UpperCase(ExtractFileExt(ItemsFound[I]));
        if MatchStr(ext, KF_MODPREFIX) then
        begin

          Result := KFmod;

        end
        else
        begin

          if ext = KF_MAPPREFIX then
          begin
            Result := KFMap;
            Break;
          end;

        end;

      end;
    finally
      ItemsFound.Free;
    end;
  except

    Result := KFUnknown;
  end;
end;

function TKFWorkshop.RemoveAcfReference(ID: string; removeAll: boolean)
  : boolean;
var
  acfFile: TStringList;
  I: integer;
  rmvSubSection: boolean;
begin

  Result := False;
  acfFile := TStringList.Create;
  try
    if FileExists(svPath + WKP_ACFFILEFOLDER + WKP_ACFFILENAME) then
    begin
      acfFile.LoadFromFile(svPath + WKP_ACFFILEFOLDER + WKP_ACFFILENAME);
      I := 0;

      while I <= acfFile.Count - 1 do
      begin
        // If is the entry
        if Pos('"' + ID + '"', acfFile[I]) > 0 then
        begin
          // Delete "ID"
          acfFile.Delete(I);
          // Delete while if there is {
          rmvSubSection := (Pos('{', acfFile[I]) > 0);
          while rmvSubSection do
          begin
            acfFile.Delete(I);
            if (Pos('}', acfFile[I]) > 0) then
            begin
              acfFile.Delete(I);
              Break;
            end;
          end;
          Result := True;
          if removeAll = False then
            Break;
        end
        else
        begin;
          I := I + 1;
        end;
      end;
{$IFDEF LINUX64}
      acfFile.SaveToFile(svPath + WKP_ACFFILEFOLDER + WKP_ACFFILENAME,
        TEncoding.ANSI);
{$ELSE}
      acfFile.SaveToFile(svPath + WKP_ACFFILEFOLDER + WKP_ACFFILENAME);
{$ENDIF }
    end
    else
    begin
      // raise Exception.Create(CAcfFile + ' file not found.');
    end;
  finally
    FreeAndNil(acfFile);
  end;

end;

function TKFWorkshop.RemoveServeItemCache(ID: string): boolean;
var
  DeleteFolder: TStringList;
begin
  Result := False;
  try

    DeleteFolder := TStringList.Create;
    try
      DeleteFolder.Add(svPath + SERVERCACHEFOLDER + ID);
      Result := FileOperation(DeleteFolder, '', FO_DELETE);
    finally
      DeleteFolder.Free;
    end;
  except

  end;

end;

function TKFWorkshop.RemoveWorkshoItemCache(ID: string): boolean;
var
  DeleteFolder: TStringList;
begin
  Result := False;
  try

    DeleteFolder := TStringList.Create;
    try
      DeleteFolder.Add(svPath + STEAMAPPCACHEFOLDER + PathDelim +
        WORKSHOPSUBITEM + PathDelim + ID);
      Result := FileOperation(DeleteFolder, '', FO_DELETE);
    finally
      DeleteFolder.Free;
    end;
  except

  end;

end;

end.
