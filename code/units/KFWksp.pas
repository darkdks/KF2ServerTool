unit KFWksp;

interface

uses
  Classes,
  SysUtils, MiscFunc, IOUtils;

type
  TKFItemType = (KFMap, KFmod, KFUnknowed);

  TKFWorkshop = class(TObject)

  private
  var
    svPath: string;
    FsteamCmdTool: string;
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
    property steamCmdTool: string read FsteamCmdTool write FsteamCmdTool;

  const
    // KF2 File types prefix
    KF_MAPPREFIX = '.KFM';
    KF_MODPREFIX: array [1 .. 3] of string = ('.U', '.UPX', '.UC');

    // Workshop files paths and names
    WKP_ACFFILENAME = 'appworkshop_232090.acf';
{$IFDEF LINUX64}
    WKP_ACFFILEFOLDER = 'Binaries/Win64/steamapps/workshop/';
    WKP_CACHEFOLDER = 'Binaries/Win64/steamapps/workshop/content/232090';
    STEAMAPPCACHEFOLDER = 'Binaries/Win64';
    SERVERCACHEFOLDER = 'KFGame/Cache/';
    WORKSHOPSUBITEM = 'steamapps/workshop/content/232090';
{$ELSE}
    WKP_ACFFILEFOLDER = 'Binaries\Win64\steamapps\workshop\';
    WKP_CACHEFOLDER = 'Binaries\Win64\steamapps\workshop\content\232090';
    STEAMAPPCACHEFOLDER = 'Binaries\Win64';
    SERVERCACHEFOLDER = 'KFGame\Cache\';
    WORKSHOPSUBITEM = 'steamapps\workshop\content\232090';
{$ENDIF}
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

function TKFWorkshop.CreateBlankACFFile(): Boolean;
var
  wkspacf: TStringList;
begin
  Result := False;
  wkspacf := TStringList.Create;
  try
    if DirectoryExists(svPath + WKP_ACFFILEFOLDER) = False then
      ForceDirectories(PWideChar(svPath + WKP_ACFFILEFOLDER));
    wkspacf.SaveToFile(svPath + WKP_ACFFILEFOLDER + WKP_ACFFILENAME);
  finally
    wkspacf.Free;
  end;
  if FileExists(svPath + WKP_ACFFILEFOLDER + WKP_ACFFILENAME) then
    Result := True;

end;

function TKFWorkshop.DownloadWorkshopItem(ID: string): Boolean;
var
  paramStCmd: string;
  itemSteamAppFolder: String;
  ItemType: TKFItemType;
begin
  ItemType := KFUnknowed;
  if (svPath = '') then
  begin
    raise Exception.Create('ERROR: No server path found');
    Exit;
  end;

  paramStCmd := ST_LOGIN + ' '+ ST_INSTALLDIR + ' ' +
    StrEmAspas(svPath + STEAMAPPCACHEFOLDER) + ' ' + ST_WKPITEM + ' ' + ID + ' '+ ST_EXIT;



  {   ExecuteTerminalProcess(steamCmdTool, paramStCmd,aborEx, procedure (text: String)begin
        Writeln('Debug: ' + text);
     end);
   }

  if ExecuteFileAndWait(0, steamCmdTool, paramStCmd, SW_HIDE) then
  begin
    itemSteamAppFolder := svPath + WKP_CACHEFOLDER + PathDelim + ID + PathDelim;
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

end;

function TKFWorkshop.GetMapName(MapFolder: string; withExt: Boolean): string;
var
  mapsFound: TStringList;
begin
  Result := '';
  try

    mapsFound := GetAllFilesSubDirectory(MapFolder, '*' + KF_MAPPREFIX);
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
        if (ext = KF_MODPREFIX[1]) or (ext = KF_MODPREFIX[2]) or
          (ext = KF_MODPREFIX[3]) then
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

    Result := KFUnknowed;
  end;
end;

function TKFWorkshop.RemoveAcfReference(ID: string; removeAll: Boolean)
  : Boolean;
var
  acfFile: TStringList;
  i: Integer;
  rmvSubSection: Boolean;
begin

  Result := False;
  acfFile := TStringList.Create;
  try
    if FileExists(svPath + WKP_ACFFILEFOLDER + WKP_ACFFILENAME) then
    begin
      acfFile.LoadFromFile(svPath + WKP_ACFFILEFOLDER + WKP_ACFFILENAME);
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
        begin;
          i := i + 1;
        end;
      end;

      acfFile.SaveToFile(svPath + WKP_ACFFILEFOLDER + WKP_ACFFILENAME);
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
      DeleteFolder.Add(svPath + SERVERCACHEFOLDER + ID);
      Result := FileOperation(DeleteFolder, '', FO_DELETE);
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
