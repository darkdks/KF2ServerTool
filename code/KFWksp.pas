unit KFWksp;

interface

uses
  Windows, Classes, Forms, ShellAPI,
  SysUtils, UFuncoes, IOUtils;

type
  TKFItemType = (KFMap, KFmod, KFUnknowed);

  TKFWorkshop = class(TObject)

  private
  var
    svPath: string;

  public
  var

    constructor Create(serverPath: string);
    destructor Destroy; override;
    function DownloadWorkshopItem(ID: string): Boolean;
    function CopyItemToCache(ID: string): Boolean;
    function RemoveServeItemCache(ID: string): Boolean;
    function RemoveWorkshoItemCache(ID: string): Boolean;
    function AddAcfReference(ID: string): Boolean;
    function RemoveAcfReference(ID: string; removeAll: Boolean): Boolean;
    function GetMapName(MapFolder: string; withExt: Boolean): string;
    function GetItemType(itemFolder: string): TKFItemType;
    function CreateBlankACFFile: Boolean;

  const
    CAcfFile = 'appworkshop_232090.acf';
    CWorkshopCacheFolder = 'Binaries\Win64\steamapps\workshop\content\232090';
    CSteamAppCacheFolder = 'Binaries\Win64';
    CServeCacheFolder = 'KFGame\Cache\';
    cMapPrefix = '.KFM';
    cModPrefix1 = '.U';
    cModPrefix2 = '.UPX';
    cModPrefix3 = '.UC';
    cStCmdTool = 'STEAMCMD\SteamCmd.exe';
    cStCmdLogin = '+login anonymous ';
    cStCmdInstallDir = ' +force_install_dir ';
    cStCmdWkspItem = ' +workshop_download_item 232090 ';
    cStCmdValidate = ' validate ';
    cStCmdExit = ' +exit';
    cAcfSubFolder = 'Binaries\Win64\steamapps\workshop\';
    cWorkshopSubItem = 'steamapps\workshop\content\232090';

  end;

implementation

{ TKFWorkshop }

function TKFWorkshop.AddAcfReference(ID: string): Boolean;
begin
  Result := False;
end;

function TKFWorkshop.CopyItemToCache(ID: string): Boolean;
var
  source: TStringList;
begin
  source := TStringList.Create;
  try
    source.Add(svPath + CWorkshopCacheFolder + '\' + ID + '\');
    Result := ExplorerFileOp(source, svPath + CServeCacheFolder, FO_COPY, True,
      Application.Handle);

  finally
    source.Free;
  end;
end;

constructor TKFWorkshop.Create(serverPath: string);
begin
  svPath := serverPath;
end;

destructor TKFWorkshop.Destroy;
begin

  inherited;
end;

function TKFWorkshop.CreateBlankACFFile(): Boolean;
var
  wkspacf: TStringList;
begin
  Result := False;
  wkspacf := TStringList.Create;
  try
    if DirectoryExists(svPath + cAcfSubFolder) = False then
      ForceDirectories(PWideChar(svPath + cAcfSubFolder));
    wkspacf.SaveToFile(svPath + cAcfSubFolder + CAcfFile);
  finally
    wkspacf.Free;
  end;
  if FileExists(svPath + cAcfSubFolder + CAcfFile) then
    Result := True;

end;

function TKFWorkshop.DownloadWorkshopItem(ID: string): Boolean;
var
  paramStCmd: string;
  itemSteamAppFolder: String;
  ItemType: TKFItemType;
begin
  ItemType := KFUnknowed;
  if (svPath <> '') = False then
  begin
    raise Exception.Create('ERROR: No server path found');
    Exit;
  end;

  paramStCmd := cStCmdLogin + cStCmdInstallDir + StrEmAspas
    (svPath + CSteamAppCacheFolder) + cStCmdWkspItem + ID + cStCmdExit;
  if ExecuteFileAndWait(Application.Handle, svPath + cStCmdTool, paramStCmd,
    SW_HIDE) then
  begin
    itemSteamAppFolder := svPath + CWorkshopCacheFolder + '\' + ID + '\';
    ItemType := GetItemType(itemSteamAppFolder);
    if (ItemType = KFMap) or (ItemType = KFmod) then
    begin
      Result := True;
    end
    else
    begin
      raise Exception.Create('Falied to download');

    end;

  end
  else
  begin
    raise Exception.Create('Falied to launcher steamcmd');
  end;

end;

function TKFWorkshop.GetMapName(MapFolder: string; withExt: Boolean): string;
var
  mapsFound: TStringList;
begin
  Result := '';
  try

    mapsFound := GetAllFilesSubDirectory(MapFolder, '*' + cMapPrefix);
    try
      if mapsFound.Count > 0 then
      begin
        if withExt then
          Result := ExtractFileName(mapsFound.Strings[0])
        else
          Result := TPath.GetFileNameWithoutExtension(mapsFound.Strings[0]);
      end;

    finally
      mapsFound.Free;
    end;
  except

    Result := '';
  end;
end;

function TKFWorkshop.GetItemType(itemFolder: string): TKFItemType;
var
  ItemsFound: TStringList;
  i: Integer;
  ext: string;
begin
  Result := KFUnknowed;
  try
                            // test if is map
      ItemsFound := GetAllFilesSubDirectory(itemFolder, '*.*');
    try

      for i := 0 to ItemsFound.Count - 1 do
      begin

        ext := UpperCase(ExtractFileExt(ItemsFound[i]));
        if (ext = cModPrefix1) or (ext = cModPrefix2) or (ext = cModPrefix3)
          then
        begin

          Result := KFmod;

        end
        else
        begin

          if ext = cMapPrefix then
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

    Result := KFUnknowed;
  end;
end;

function TKFWorkshop.RemoveAcfReference(ID: string;
  removeAll: Boolean): Boolean;
var
  acfFile: TStringList;
  i: Integer;
  rmvSubSection: Boolean;
begin

  Result := False;
  acfFile := TStringList.Create;
  try
    if FileExists(svPath + cAcfSubFolder + CAcfFile) then
    begin
      acfFile.LoadFromFile(svPath + cAcfSubFolder + CAcfFile);
      i := 0;

      while i <= acfFile.Count - 1 do
      begin
        // If is the entry
        if Pos('"' + ID + '"', acfFile[i]) > 0 then
        begin
          // Delete "ID"
          acfFile.Delete(i);
          // Delete while if there is {
          rmvSubSection := (Pos('{', acfFile[i]) > 0);
          while rmvSubSection do
          begin
            acfFile.Delete(i);
            if (Pos('}', acfFile[i]) > 0) then
            begin
              acfFile.Delete(i);
              Break;
            end;
          end;
          Result := True;
          if removeAll = False then
            Break;
        end
        else
        begin ;
          i := i + 1;
        end;
      end;

      acfFile.SaveToFile(svPath + cAcfSubFolder + CAcfFile);
    end
    else
    begin
      // raise Exception.Create(CAcfFile + ' file not found.');
    end;
  finally
    acfFile.Free;
  end;

end;

function TKFWorkshop.RemoveServeItemCache(ID: string): Boolean;
var
  DeleteFolder: TStringList;
begin
  Result := False;
  try

    DeleteFolder := TStringList.Create;
    try
      DeleteFolder.Add(svPath + CServeCacheFolder + ID);
      Result := ExplorerFileOp(DeleteFolder, '', FO_DELETE, True,
        Application.Handle);
    finally
      DeleteFolder.Free;
    end;
  except

  end;
end;

function TKFWorkshop.RemoveWorkshoItemCache(ID: string): Boolean;
var
  DeleteFolder: TStringList;
begin
  Result := False;
  try

    DeleteFolder := TStringList.Create;
    try
      DeleteFolder.Add(svPath + CSteamAppCacheFolder + '\' + cWorkshopSubItem +
          '\' + ID);
      Result := ExplorerFileOp(DeleteFolder, '', FO_DELETE, True,
        Application.Handle);
    finally
      DeleteFolder.Free;
    end;
  except

  end;

end;

end.
