unit KFServerTool;

interface

uses
  Classes, Controls,
  SysUtils, KFFile, KFWksp, MiscFunc, IOUtils, KFRedirect;

type

  TApplicationType = (atCmd, atGUI);
  TKFSource = (KFSteamWorkshop, KFOfficial, KFRedirectOrLocal);
  TKFAppLanguage = (KFL_ENGLISH, KFL_PORTUGUESE);

  TKFServerProfile = class(TObject)
  private

  public
  var
    DefaultDifficulty: Integer;
    DefaultLength: Integer;
    DefaultGameMode: Integer;
    DefaultPass: string;
    AdditionalParam: string;
    DefaultMap: string;
    ProfileName: string;
    constructor Create;
    destructor Destroy; override;

  end;

  TKFItem = class(TObject)
  private

  public
  var
    FileName: string;
    ID: string;
    ServerSubscribe: Boolean;
    MapEntry: Boolean;
    MapCycleEntry: Boolean;
    ServerCache: Boolean;
    ItemType: TKFItemType;
    SourceFrom: TKFSource;

    constructor Create;
    destructor Destroy; override;

  end;

  TKFServerTool = class(TObject)
  private
  var
    kfWebIniSubPath: string;
    kfGameIniSubPath: string;
    kfEngineIniSubPath: string;
    kfApplicationPath: string;
    KFServerPathEXE: string;
    GenerateLog: Boolean;
    appLanguage: TKFAppLanguage;
    function GetIDIndex(ID: string): Integer;
    function GetModName(files: TStringList): string;

  public
  var
    Items: array of TKFItem;
    appType: TApplicationType;
    constructor Create;
    destructor Destroy; override;
    function AddMapCycle(name: String): Boolean;
    function AddMapEntry(name: String): Boolean;
    function AddWorkshopSubcribe(ID: String): Boolean;
    function CreateBlankACFFile: Boolean;
    function DownloadWorkshopItem(ID: String): Boolean;
    function ExportItemsList(itemsList: Array of TKFItem;
      outputPath: String): Integer;
    function ImportItemsList(inputPath: string): Integer;
    function ForceUpdate(itemID: String; IsMod: Boolean): Boolean;
    function GetCustomRedirect: string;
    function GetGameCycle(): TStringList;
    function GetKFApplicationPath(): string;
    function GetMapName(ID: string): string;
    function GetWebPort(): Integer;
    function GetWebPass(): string;
    procedure SetWebPass(pass: String);
    function GetWebStatus(): Boolean;
    procedure GetKFServerPathEXE(path: string);
    function InstallWorkshopManager: Boolean;
    function IsOfficialMap(mapName: String): Boolean;
    function IsWorkshopManagerInstalled: Boolean;
    function LoadItems(): Boolean;
    function InstallWorkshopItem(ID: String; Name: String;
      WorkshopSubscribe: Boolean; DownloadNow: Boolean; MapCycle: Boolean;
      MapEntry: Boolean): Boolean;
    function NewRedirectItem(downURL, itemName: String;
      DownloadNow, MapCycle, MapEntry: Boolean;
      var dlManager: TKFRedirectDownloadManager): Boolean;

    function RemoveItem(itemName: string; itemID: string;
      rmvMapEntry, rmvMapCycle, rmvSubcribe, rmvLocalFile: Boolean;
      ItemSource: TKFSource): Boolean;
    function RemoveWorkshopManager: Boolean;
    function SetCustomRedirect(URL: String): Boolean;
    procedure SetKFApplicationPath(path: string);
    procedure SetKFGameIniSubPath(path: string);
    procedure SetKFServerPathEXE(path: string);
    procedure SetKFWebIniSubPath(path: string);
    procedure SetWebPort(Port: Integer);
    procedure SetWebStatus(Status: Boolean);
    procedure SetKFngineIniSubPath(path: string);
    procedure SetKFAppLanguage(language: TKFAppLanguage);
    function GetKFAppLanguage(): TKFAppLanguage;
    procedure KillKFServer();
    procedure LogEvent(eventName: String; eventDescription: String);
    function IsServerRunning: Boolean;

  const
    KFOfficialMaps: array [1 .. 21] of string = ('KF-BioticsLab.kfm',
      'KF-BlackForest.kfm', 'KF-BurningParis.kfm', 'KF-Catacombs.kfm',
      'KF-ContainmentStation.kfm', 'KF-DieSector.kfm',
      'KF-EvacuationPoint.kfm', 'KF-Farmhouse.kfm', 'KF-HostileGrounds.kfm',
      'KF-InfernalRealm.kfm', 'KF-KrampusLair.kfm', 'FX_Manor.kfm',
      'KF-Nightmare.kfm', 'KF-Nuked.kfm', 'KF-Outpost.kfm',
      'KF-PowerCore_Holdout.kfm', 'KF-Prison.kfm', 'KF-TheDescent.kfm',
      'KF-TragicKingdom.kfm', 'KF-ZedLanding.kfm', 'KF-VolterManor.kfm');

    CLocalMapsSubFolder = 'KFGame\BrewedPC\Maps\';
  end;

implementation

constructor TKFItem.Create;
begin

end;

destructor TKFItem.Destroy;
begin

  inherited;
end;

function TKFServerTool.AddWorkshopSubcribe(ID: String): Boolean;
var
  egIni: TKFEngineIni;
begin
  result := False;

  egIni := TKFEngineIni.Create;
  try
    if egIni.LoadFile(kfApplicationPath + kfEngineIniSubPath) then
    begin
      result := egIni.AddWorkshopItem(ID);
      egIni.SaveFile(kfApplicationPath + kfEngineIniSubPath);

    end;
  finally
    egIni.Free;
  end;

end;

function TKFServerTool.GetCustomRedirect(): string;
var
  egIni: TKFEngineIni;
begin
  result := '';
  egIni := TKFEngineIni.Create;
  try
    if egIni.LoadFile(kfApplicationPath + kfEngineIniSubPath) then
    begin
      result := egIni.GetCustomRedirect();
    end;
  finally
    egIni.Free;
  end;

end;

function TKFServerTool.SetCustomRedirect(URL: String): Boolean;
var
  egIni: TKFEngineIni;
begin
  result := False;
  egIni := TKFEngineIni.Create;
  try
    if egIni.LoadFile(kfApplicationPath + kfEngineIniSubPath) then
    begin
      egIni.SetCustomRedirect(URL);
      result := egIni.SaveFile(kfApplicationPath + kfEngineIniSubPath);
    end;
  finally
    egIni.Free;
  end;

end;

function TKFServerTool.NewRedirectItem(downURL: String; itemName: String;
  DownloadNow: Boolean; MapCycle: Boolean; MapEntry: Boolean;
  var dlManager: TKFRedirectDownloadManager): Boolean;
var
  ItemDownloaded: Boolean;
  AddedMapEntry: Boolean;
  AddedMapCycle: Boolean;
  KFRedirect: TKFRedirect;
begin

  result := False;
  AddedMapEntry := False;
  AddedMapCycle := False;

  try

    if (downURL <> '') or (itemName <> '') then
    begin
      try

        // Download redirect Item
        if DownloadNow and (downURL <> '') then
        begin
          KFRedirect := TKFRedirect.Create;
          try
            ItemDownloaded := KFRedirect.downloadFile(downURL,
              kfApplicationPath + CLocalMapsSubFolder +
                itemName, dlManager);
            if not ItemDownloaded then
              raise Exception.Create
                ('Falied to download file from url: ' + downURL);

          finally
            KFRedirect.Free;
          end;
        end;

        // MapCycle and Map Entry
        if (itemName <> '') then
        begin
          itemName := IOUtils.TPath.GetFileNameWithoutExtension(itemName);
          if MapEntry then
          begin
            AddedMapEntry := AddMapEntry(itemName);
          end;
          if MapCycle then
          begin
            AddedMapCycle := AddMapCycle(itemName);
          end;
        end;

        result := True;

      except
        on E: Exception do
        begin
          raise Exception.Create('Error Adding item: ' + E.Message);
          result := False;
        end;
      end;

    end
    else
    begin
      // No id passed
      raise Exception.Create('No DownURL or itemname passed');
      result := False;
    end;

  finally

  end;

end;

function TKFServerTool.DownloadWorkshopItem(ID: String): Boolean;
var
  wksp: TKFWorkshop;
  ItemDownloaded: Boolean;
  ItemInCache: Boolean;
begin
  result := False;
  wksp := TKFWorkshop.Create(kfApplicationPath);
  try
    wksp.RemoveAcfReference(ID, True);
    ItemDownloaded := wksp.DownloadWorkshopItem(ID);
    ItemInCache := wksp.CopyItemToCache(ID);
    result := ItemDownloaded and ItemInCache;
  finally
    wksp.Free
  end;
end;

function TKFServerTool.ExportItemsList(itemsList: array of TKFItem;
  outputPath: String): Integer;
var
  I: Integer;
  outputList: TStringList;
  separator: String;
begin
  separator := '\\';
  result := 0;
  outputList := TStringList.Create;
  try
    try
      for I := 0 to High(itemsList) do
      begin
        outputList.Add(itemsList[I].ID + separator + itemsList[I].FileName);
        Inc(result);
      end;
      outputList.SaveToFile(outputPath);

    except

      on E: Exception do
      begin
        result := 0;
        raise Exception.Create('Falied to export list: ' + E.Message);
      end;
    end;
  finally
    outputList.Free;
  end;

end;

function TKFServerTool.CreateBlankACFFile(): Boolean;
var
  wksp: TKFWorkshop;

begin
  result := False;
  wksp := TKFWorkshop.Create(kfApplicationPath);
  try
    result := wksp.CreateBlankACFFile;
  finally
    wksp.Free
  end;
end;

function TKFServerTool.GetMapName(ID: string): string;
var
  wksp: TKFWorkshop;
begin
  result := '';
  wksp := TKFWorkshop.Create(kfApplicationPath);
  try
    result := wksp.GetMapName(kfApplicationPath + wksp.CServeCacheFolder + ID,
      False);
  finally
    wksp.Free
  end;
end;

function TKFServerTool.AddMapCycle(name: String): Boolean;
var
  gmIni: TKFGameIni;
begin
  result := False;
  gmIni := TKFGameIni.Create;
  try
    if gmIni.LoadFile(kfApplicationPath + kfGameIniSubPath) then
    begin
      if gmIni.AddMapCycle(Name) then
        gmIni.SaveFile(kfApplicationPath + kfGameIniSubPath);
    end;
  finally
    gmIni.Free;
  end;
end;

function TKFServerTool.AddMapEntry(name: String): Boolean;
var
  gmIni: TKFGameIni;
begin
  result := False;
  gmIni := TKFGameIni.Create;
  try
    if gmIni.LoadFile(kfApplicationPath + kfGameIniSubPath) then
    begin
      if gmIni.AddMapEntry(name) then
        gmIni.SaveFile(kfApplicationPath + kfGameIniSubPath);
    end;
  finally
    gmIni.Free;
  end;
end;

function TKFServerTool.ImportItemsList(inputPath: string): Integer;
var
  I: Integer;
  inputList: TStringList;
  itemID, itemName: string;
  separatorPoint: Integer;
  separator: String;
begin
  separator := '\\';
  result := 0;
  inputList := TStringList.Create;
  try
    try
      inputList.LoadFromFile(inputPath);
      for I := 0 to inputList.Count - 1 do
      begin
        separatorPoint := Pos(separator, inputList[I]);
        itemID := Copy(inputList[I], 0, separatorPoint - 1);
        itemName := Copy(inputList[I], separatorPoint + 2,
          Length(inputList[I]) - separatorPoint - 2);
        if (itemID <> '') and (itemName <> '') then
        begin
          InstallWorkshopItem(itemID, itemName, True, False, False, False);
          Inc(result);
        end;
      end;

    except
      on E: Exception do
      begin
        raise Exception.Create('Falied to import list: ' + E.Message);
      end;
    end;
  finally
    inputList.Free;
  end;
end;

function TKFServerTool.InstallWorkshopItem(ID: String; Name: String;
  WorkshopSubscribe: Boolean; DownloadNow: Boolean; MapCycle: Boolean;
  MapEntry: Boolean): Boolean;
var
  ItemDownloaded: Boolean;
  AddedMapEntry: Boolean;
  AddedMapCycle: Boolean;
  AddedWkspSub: Boolean;
begin

  result := False;
  AddedMapEntry := False;
  AddedMapCycle := False;
  AddedWkspSub := False;

  try

    if (ID <> '') or (Name <> '') then
    begin
      try
        // AddWorkshopSubcribe
        if WorkshopSubscribe then
        begin
          LogEvent('Install workshop item', 'Adding workshop subcribe...');
          AddedWkspSub := AddWorkshopSubcribe(ID);
          LogEvent('Install workshop item',
            'Workshop subscribe added = ' + BoolToWord(AddedWkspSub));
        end;

        // Download workshop Item
        if DownloadNow and (ID <> '') then
        begin
          LogEvent('Install workshop item', 'Downloading workshop item ' + ID);
          ItemDownloaded := DownloadWorkshopItem(ID);
          if ItemDownloaded then
          begin
            Name := GetMapName(ID);
            LogEvent('Install workshop item',
              'Item ' + ID + ' downloaded' + 'with name ' + Name);
          end;
        end;

        // MapCycle and Map Entry
        if (Name <> '') then
        begin
          if MapEntry then
          begin
            LogEvent('Install workshop item', 'Adding map entry for ' + Name);
            AddedMapEntry := AddMapEntry(Name);
            LogEvent('Install workshop item',
              'Map entry added = ' + BoolToWord(AddedMapEntry));
          end;
          if MapCycle then
          begin
            LogEvent('Install workshop item', 'Adding map cycle for ' + Name);
            AddedMapCycle := AddMapCycle(Name);
            LogEvent('Install workshop item',
              'Map cycle added = ' + BoolToWord(AddedMapEntry));
          end;
        end;
        LogEvent('Install workshop item', 'Finished job for item ' + ID);
        result := True;

      except
        on E: Exception do
        begin
          LogEvent('Install workshop item', 'Exception ' + E.Message);
          raise Exception.Create('Error adding item: ' + E.Message);

          result := False;

        end;
      end;

    end
    else
    begin
      // No id passed
      LogEvent('Install workshop item', 'Error no id or name');
      raise Exception.Create('No id or name passed');
      result := False;
    end;

  finally

  end;

end;

constructor TKFServerTool.Create;
begin
  SetLength(Items, 0);
  appLanguage := KFL_ENGLISH;

end;

destructor TKFServerTool.Destroy;
var
  I: Integer;
begin
  try
    for I := 0 to High(Items) do
      FreeAndNil(Items[I]);

  except

  end;
  inherited;
end;

function TKFServerTool.LoadItems: Boolean;
var
  directorys: TStringList;
  files: TStringList;
  fileExt: string;
  ItemFolder: string;
  I, y: Integer;
  aItem: TKFItem;
  itemName: String;
  egIniLoaded, gmIniLoaded: Boolean;
  egIni: TKFEngineIni;
  gmIni: TKFGameIni;
  wkspID: string;
  FileType: TKFItemType;
begin
  if kfApplicationPath = '' then
    raise Exception.Create('KF Application path is not set');
  if kfEngineIniSubPath = '' then
    raise Exception.Create('KF EngineIniSubPath path is not set');
  if kfGameIniSubPath = '' then
    raise Exception.Create('KF GameIniSubPath path is not set');

  // Directoy
  result := False;
  directorys := ListDir(kfApplicationPath + TKFWorkshop.CServeCacheFolder);
  egIni := TKFEngineIni.Create;
  gmIni := TKFGameIni.Create;

  try
    egIniLoaded := egIni.LoadFile(kfApplicationPath + kfEngineIniSubPath);
    gmIniLoaded := gmIni.LoadFile(kfApplicationPath + kfGameIniSubPath);
    for I := 0 to High(Items) do
      Items[I].Free;
    SetLength(Items, 0);
    if (gmIniLoaded = False) or (egIniLoaded = False) then
    begin
      raise Exception.Create(
        'Falied to load PCServer-KFGame and PCServer-KFEngine. ' + #13 +
          'Check if the app is in the server folder and if you ran the server at least once');

    end;

    for I := 0 to directorys.Count - 1 do
    begin
      try
        ItemFolder := kfApplicationPath + TKFWorkshop.CServeCacheFolder +
          directorys[I] + '\';
        files := GetAllFilesSubDirectory(ItemFolder, '*.*');

        try
          FileType := KFUnknowed;
          if (files.Count > 0) then
          begin
            // Check folder type
            for y := 0 to files.Count - 1 do
            begin
              itemName := ExtractFileName(files[y]);
              fileExt := UpperCase(ExtractFileExt(itemName));
              if (Pos('KF', UpperCase(itemName)) = 1) and (fileExt = '.KFM')
                then
              begin
                FileType := KFMap;
                Break;
              end;
              if (fileExt = '.U') or (fileExt = '.UC') then
              begin
                FileType := KFmod;
              end;
            end;

            if FileType <> KFUnknowed then
            begin

              aItem := TKFItem.Create;
              aItem.ItemType := FileType;
              if FileType = KFmod then
                aItem.FileName := GetModName(files)
              else
                aItem.FileName := TPath.GetFileNameWithoutExtension(itemName);

              aItem.ID := directorys[I];
              aItem.ServerSubscribe := egIni.GetWorkshopItemIndex
                (directorys[I]) >= 0;
              aItem.MapCycleEntry := gmIni.GetMapCycleIndex
                (TPath.GetFileNameWithoutExtension(itemName)) >= 0;
              aItem.MapEntry := gmIni.GetMapEntryIndex
                (TPath.GetFileNameWithoutExtension(itemName)) > 0;
              aItem.ServerCache := True;
              aItem.SourceFrom := KFSteamWorkshop;

              SetLength(Items, Length(Items) + 1);
              Items[ High(Items)] := aItem;

              directorys.Objects[I] := files;
            end;
          end;
        finally
          files.Free;
        end;
      except
        LogEvent('Error loading folder ',
          directorys[I] + ' of number ' + IntToStr(I) +
            '. Check this folder or delete.');
      end;
    end;

    // Workshop subscribe
    for I := 0 to egIni.GetWorkshopSubcribeCount - 1 do
    begin
      wkspID := egIni.GetWorkshopSubcribeID(I);
      if (GetIDIndex(wkspID) < 0) and (wkspID <> '') then
      begin
        aItem := TKFItem.Create;
        aItem.ID := wkspID;
        aItem.ServerSubscribe := True;
        aItem.MapEntry := False;
        aItem.ServerCache := False;
        aItem.MapCycleEntry := False;
        aItem.ItemType := KFUnknowed;
        aItem.FileName := '???';
        aItem.SourceFrom := KFSteamWorkshop;
        SetLength(Items, Length(Items) + 1);
        Items[ High(Items)] := aItem;
      end;
      result := True;
    end;

    // Local and redirect maps
    try
      ItemFolder := kfApplicationPath + CLocalMapsSubFolder;
      files := GetAllFilesSubDirectory(ItemFolder, '*.*');

      try
        if (files.Count > 0) then
        begin
          for y := 0 to files.Count - 1 do
          begin
            itemName := ExtractFileName(files[y]);
            fileExt := UpperCase(ExtractFileExt(itemName));
            if (Pos('KF-', UpperCase(itemName)) = 1) and (fileExt = '.KFM') then
            begin
              aItem := TKFItem.Create;
              aItem.ItemType := KFMap;
              aItem.FileName := TPath.GetFileNameWithoutExtension(itemName);
              aItem.ID := '';
              aItem.ServerSubscribe := False;
              aItem.MapCycleEntry := gmIni.GetMapCycleIndex
                (TPath.GetFileNameWithoutExtension(itemName)) >= 0;
              aItem.MapEntry := gmIni.GetMapEntryIndex
                (TPath.GetFileNameWithoutExtension(itemName)) > 0;
              aItem.ServerCache := True;
              // Conditional Redirect or Oficial
              if IsOfficialMap(ExtractFileName(files[y])) then

                aItem.SourceFrom := KFOfficial
              else
                aItem.SourceFrom := KFRedirectOrLocal;

              SetLength(Items, Length(Items) + 1);
              Items[ High(Items)] := aItem;

            end;

          end;

        end;
      finally
        files.Free;
      end;
    except
      raise Exception.Create('Error loading local maps folder.');
    end;

  finally
    egIni.Free;
    gmIni.Free;
    directorys.Free;
  end;

end;

procedure TKFServerTool.LogEvent(eventName, eventDescription: String);
var
  logFile: TStringList;
  logPath: String;
begin
  if GenerateLog = False then
    Exit;

  logFile := TStringList.Create;
  logPath := kfApplicationPath + 'KFServerTool.log';
  try
    if FileExists(logPath) then
      logFile.LoadFromFile(logPath);
    logFile.Add(DateToStr(Now) + ' ' + TimeToStr(Now)
        + eventName + ' : ' + eventDescription);
    logFile.SaveToFile(logPath);
  finally
    logFile.Free;
  end;

end;

function TKFServerTool.GetModName(files: TStringList): string;
var
  I: Integer;
begin
  for I := 0 to files.Count do
  begin
    if LowerCase(ExtractFileExt(files[I])) = '.u' then
    begin
      result := TPath.GetFileNameWithoutExtension(files[I]);
      Exit;
    end
    else
    begin
      result := TPath.GetFileNameWithoutExtension(files[I]);
    end;
  end;
end;

function TKFServerTool.GetWebPass: string;
var
  KFGameIni: TKFGameIni;
begin
  if FileExists(kfApplicationPath + kfGameIniSubPath) then
  begin

    KFGameIni := TKFGameIni.Create;
    try
      KFGameIni.LoadFile(kfApplicationPath + kfGameIniSubPath);
      result := KFGameIni.GetAdminPass();
    finally
      KFGameIni.Free;
    end;

  end
  else
  begin
    raise Exception.Create('Invalid KFGameIni Path (Not found in ' +
        kfApplicationPath + kfGameIniSubPath + ')');
  end;

end;

function TKFServerTool.GetWebPort: Integer;
var
  KFWeb: TKFWebIni;
begin
  if FileExists(kfApplicationPath + kfWebIniSubPath) then
  begin

    KFWeb := TKFWebIni.Create;

    KFWeb.LoadFile(kfApplicationPath + kfWebIniSubPath);
    result := KFWeb.GetWebPort();
    KFWeb.Free;

  end
  else
  begin
    raise Exception.Create('Invalid KFWeb Path (Not found in ' +
        kfApplicationPath + kfWebIniSubPath + ')');
  end;

end;

function TKFServerTool.GetWebStatus: Boolean;
var
  KFWeb: TKFWebIni;
begin
  if FileExists(kfApplicationPath + kfWebIniSubPath) then
  begin

    KFWeb := TKFWebIni.Create;

    KFWeb.LoadFile(kfApplicationPath + kfWebIniSubPath);
    result := KFWeb.GetWebStatus();
    KFWeb.Free;

  end
  else
  begin
    raise Exception.Create('Invalid KFWeb Path (Not found in ' +
        kfApplicationPath + kfWebIniSubPath + ')');
  end;

end;

function TKFServerTool.GetIDIndex(ID: string): Integer;
var
  I: Integer;
begin
  result := -1;
  for I := 0 to High(Items) do
  begin
    if Items[I].ID = ID then
    begin
      result := I;
      Exit;
    end;
  end;
end;

function TKFServerTool.ForceUpdate(itemID: String; IsMod: Boolean): Boolean;
var
  wksp: TKFWorkshop;
begin

  try
    wksp := TKFWorkshop.Create(kfApplicationPath);
    LogEvent('Force update',
      'Forcing update item for item id ' + itemID + ', is mod = ' + BoolToWord
        (IsMod));
    try
      LogEvent('Force update', 'Removing old references...');
      wksp.RemoveAcfReference(itemID, True);
      LogEvent('Force update', 'Downloading Item...');
      wksp.DownloadWorkshopItem(itemID);
      LogEvent('Force update', 'Copying the files to server cache...');
      result := wksp.CopyItemToCache(itemID);
      LogEvent('Force update', 'Finished.');
    finally
      wksp.Free;
    end;

  finally

  end;

end;

function TKFServerTool.GetGameCycle: TStringList;
var
  gmIni: TKFGameIni;
begin
  gmIni := TKFGameIni.Create;
  try
    if gmIni.LoadFile(kfApplicationPath + kfGameIniSubPath) then
    begin
      result := gmIni.GetMapCycleList;
    end
    else
    begin
      result := TStringList.Create;
    end;

  finally
    gmIni.Free;
  end;

end;

Function TKFServerTool.IsServerRunning(): Boolean;
begin
  result := ProcessExists(ExtractFileName(KFServerPathEXE));
end;

function TKFServerTool.RemoveItem(itemName: string; itemID: string;
  rmvMapEntry, rmvMapCycle, rmvSubcribe, rmvLocalFile: Boolean;
  ItemSource: TKFSource): Boolean;
var
  egIni: TKFEngineIni;
  gmIni: TKFGameIni;
  wksp: TKFWorkshop;
  redirect: TKFRedirect;
  egIniLoaded, gmIniLoaded: Boolean;

begin
  result := False;
  LogEvent('Remove item', 'Item name ' + itemName + ' item id ' + itemID);
  case ItemSource of
    KFSteamWorkshop:
      LogEvent('Remove item', 'Source type is SteamWorkshop');
    KFOfficial:
      LogEvent('Remove item', 'Source type is Official map');
    KFRedirectOrLocal:
      LogEvent('Remove item', 'Source type is Redirect');
  end;

  if rmvSubcribe then
  begin
    if itemID = '' then
    begin
      LogEvent('Remove item', 'Exception: no id, unable to remove');
      raise Exception.Create('No ID, unable to remove subscription');

    end
    else
    begin

      egIni := TKFEngineIni.Create;
      try
        egIniLoaded := egIni.LoadFile(kfApplicationPath + kfEngineIniSubPath);
        LogEvent('Remove item',
          'Removing Server Subcribe for item id ' + itemID);
        if egIniLoaded then
        begin
          egIni.RemoveWorkshopItem(itemID, True);
          egIni.SaveFile(kfApplicationPath + kfEngineIniSubPath);
        end;
      finally
        egIni.Free;
      end;
    end;
  end;

  if rmvMapEntry or rmvMapCycle then
  begin
    if itemName = '' then
    begin
      raise Exception.Create('No Map name, unable to remove');

    end
    else
    begin

      gmIni := TKFGameIni.Create;
      try
        gmIniLoaded := gmIni.LoadFile(kfApplicationPath + kfGameIniSubPath);
        if rmvMapEntry and gmIniLoaded then
        begin
          LogEvent('Remove item', 'Removing Map Entry for item ' + itemName);
          gmIni.RemoveMapEntry(itemName, True);
        end;
        if rmvMapCycle and gmIniLoaded then
        begin
          LogEvent('Remove item', 'Removing Map Cycle for item ' + itemName);
          gmIni.RemoveMapCycle(itemName, True);
        end;
        gmIni.SaveFile(kfApplicationPath + kfGameIniSubPath);

      finally
        gmIni.Free
      end;

    end;
  end;

  if rmvLocalFile then
  begin
    if ItemSource = KFSteamWorkshop then
    begin

      if itemID = '' then
      begin
        raise Exception.Create('No ID, unable to remove cache');

      end
      else
      begin
        wksp := TKFWorkshop.Create(kfApplicationPath);

        try
          LogEvent('Remove item', 'Removing ACF reference');
          wksp.RemoveAcfReference(itemID, True);
          LogEvent('Remove item', 'Deleting server cache');
          wksp.RemoveServeItemCache(itemID);
          LogEvent('Remove item', 'Deleting workshop cache');
          wksp.RemoveWorkshoItemCache(itemID);

        finally
          wksp.Free;
        end;

      end;

    end;
    if ItemSource = KFRedirectOrLocal then
    begin

      if itemName = '' then
      begin
        LogEvent('Remove item', 'Exception: no id, unable to remove file');
        raise Exception.Create('No name, unable to remove file');

      end
      else
      begin
        redirect := TKFRedirect.Create();
        try
          LogEvent('Remove item', 'Deleting redirect file cache');
          redirect.removeFile(itemName + '.kfm',
            kfApplicationPath + CLocalMapsSubFolder, True);
        finally
          redirect.Free;
        end;

      end;

    end;

  end;

  result := True;

end;

function TKFServerTool.IsOfficialMap(mapName: String): Boolean;
var
  I: Integer;
begin
  result := False;
  for I := 1 to High(KFOfficialMaps) do
  begin
    if UpperCase(mapName) = UpperCase(KFOfficialMaps[I]) then
    begin
      result := True;
      Break;
    end;
  end;
end;

function TKFServerTool.IsWorkshopManagerInstalled(): Boolean;
var
  egIni: TKFEngineIni;
begin
  result := True;
  egIni := TKFEngineIni.Create;
  try
    if egIni.LoadFile(kfApplicationPath + kfEngineIniSubPath) then
    begin
      result := egIni.GetWorkshopStatus;
    end;

  finally
    egIni.Free;
  end;

end;

procedure TKFServerTool.KillKFServer;
begin
  KillProcessByName(ExtractFileName(KFServerPathEXE));
end;

function TKFServerTool.InstallWorkshopManager(): Boolean;
var
  egIni: TKFEngineIni;
begin
  result := False;
  egIni := TKFEngineIni.Create;
  try
    if egIni.LoadFile(kfApplicationPath + kfEngineIniSubPath) then
    begin
      egIni.AddWorkshopRedirect;
      result := egIni.SaveFile(kfApplicationPath + kfEngineIniSubPath);
    end;

  finally
    egIni.Free;
  end;

end;

function TKFServerTool.RemoveWorkshopManager(): Boolean;
var
  egIni: TKFEngineIni;
begin
  result := False;
  egIni := TKFEngineIni.Create;
  try
    if egIni.LoadFile(kfApplicationPath + kfEngineIniSubPath) then
    begin
      egIni.RemoveWorkshopRedirect;
      result := egIni.SaveFile(kfApplicationPath + kfEngineIniSubPath);
    end;

  finally
    egIni.Free;
  end;

end;

procedure TKFServerTool.SetKFAppLanguage(language: TKFAppLanguage);
begin
  appLanguage := language;
end;

procedure TKFServerTool.SetKFApplicationPath(path: string);
begin
  kfApplicationPath := path;
end;

function TKFServerTool.GetKFAppLanguage: TKFAppLanguage;
begin
  result := appLanguage;
end;

function TKFServerTool.GetKFApplicationPath(): String;
begin
  result := kfApplicationPath;
end;

procedure TKFServerTool.SetKFGameIniSubPath(path: string);
begin

  kfGameIniSubPath := path;
end;

procedure TKFServerTool.SetKFngineIniSubPath(path: string);
begin
  kfEngineIniSubPath := path;
end;

procedure TKFServerTool.SetWebPass(pass: String);
var
  KFGameIni: TKFGameIni;
begin
  if FileExists(kfApplicationPath + kfGameIniSubPath) then
  begin

    KFGameIni := TKFGameIni.Create;
    try
      KFGameIni.LoadFile(kfApplicationPath + kfGameIniSubPath);
      KFGameIni.SetAdminPass(pass);
      KFGameIni.SaveFile(kfApplicationPath + kfGameIniSubPath);
    finally
      KFGameIni.Free;
    end;

  end
  else
  begin
    raise Exception.Create(' Invalid KFGame Path (Not found in ' +
        kfApplicationPath + kfGameIniSubPath + ')');
  end;

end;

procedure TKFServerTool.SetWebPort(Port: Integer);
var
  KFWeb: TKFWebIni;
begin
  if FileExists(kfApplicationPath + kfWebIniSubPath) then
  begin

    KFWeb := TKFWebIni.Create;

    KFWeb.LoadFile(kfApplicationPath + kfWebIniSubPath);
    KFWeb.SetWebPort(Port);
    KFWeb.SaveFile(kfApplicationPath + kfWebIniSubPath);
    KFWeb.Free;

  end
  else
  begin
    raise Exception.Create(' Invalid KFWeb Path (Not found in ' +
        kfApplicationPath + kfWebIniSubPath + ')');
  end;

end;

procedure TKFServerTool.SetWebStatus(Status: Boolean);
var
  KFWeb: TKFWebIni;
begin
  if FileExists(kfApplicationPath + kfWebIniSubPath) then
  begin

    KFWeb := TKFWebIni.Create;

    KFWeb.LoadFile(kfApplicationPath + kfWebIniSubPath);
    KFWeb.SetWebStatus(Status);
    KFWeb.SaveFile(kfApplicationPath + kfWebIniSubPath);
    KFWeb.Free;

  end
  else
  begin
    raise Exception.Create(' Invalid KFWeb Path (Not found in ' +
        kfApplicationPath + kfWebIniSubPath + ')');
  end;

end;

procedure TKFServerTool.SetKFServerPathEXE(path: string);
begin
  KFServerPathEXE := path;
end;

procedure TKFServerTool.SetKFWebIniSubPath(path: string);
begin
  kfWebIniSubPath := path;
end;

procedure TKFServerTool.GetKFServerPathEXE(path: string);
begin
  KFServerPathEXE := path;
end;

{ TKFServerProfile }

constructor TKFServerProfile.Create;
begin

end;

destructor TKFServerProfile.Destroy;
begin

  inherited;
end;

end.
