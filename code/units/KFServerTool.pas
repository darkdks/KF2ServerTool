unit KFServerTool;

interface

uses
  Classes,
  SysUtils,
  KFFile,
  KFWksp,
  MiscFunc,
  IOUtils,
  KFRedirect,
  System.StrUtils,
  DownloaderTool,
  KFTypes;

type

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
    SteamCmdPath: string;
    GenerateLog: Boolean;
    FverboseMod: Boolean;
    CycleSortType: TKFCycleSort;
    CycleSortSeparators: Boolean;
    appLanguage: TKFAppLanguage;
    function GetIDIndex(ID: string): Integer;
    function GetModName(files: TStringList): string;
    function IsIgnoredMap(mapName: String): Boolean;
    function IsIgnoredFile(FileName: String): Boolean;


{$IFDEF MSWINDOWS}
    function DownloadWorkshopItemImage(ID: String): Boolean;
{$ENDIF}
  public
  var
    Items: array of TKFItem;
    constructor Create;
    destructor Destroy; override;
    function AddMapCycle(name: String; sortType: TKFCycleSort;
      separators: Boolean): Boolean;
    function AddMapEntry(name: String): Boolean;
    function AddWorkshopSubscription(ID: String): Boolean;
    function CreateBlankACFFile: Boolean;
    function DownloadWorkshopItem(ID: String): Boolean;
    function ExportItemsList(itemsList: Array of TKFItem;
      outputPath: String): Integer;
    function ImportItemsList(inputPath: string): Integer;
    function ForceUpdate(itemID: String; IsMod: Boolean): Boolean;
    function GetCustomRedirect: string;
    function GetGameCycle(): TStringList;
    function GetKFApplicationPath(): string;
    function GetSteamCmdPath(): String;
    function getKFGameIniPath(): String;
    function getKFEngineIniPath(): String;
    function getKFWebIniPath(): String;

    function GetMapName(ID: string): string;
    function GetWebPort(): Integer;
    function GetWebPass(): string;
    function GetItemIndexByName(ItemName: String; ignoreCase: Boolean): Integer;
    procedure SetWebPass(pass: String);
    function GetWebStatus(): Boolean;
    function GetKFServerPathEXE: string;
    function InstallWorkshopManager: Boolean;
    function IsWorkshopManagerInstalled: Boolean;
    function LoadItems(): Boolean;
    function InstallWorkshopItem(ID, name: String;
      WorkshopSubscribed, DownloadNow, DownloadImg, MapCycle,
      MapEntry: Boolean): Boolean;
    function NewRedirectItem(downURL, ItemName: String;
      DownloadNow, MapCycle, MapEntry: Boolean; var dlManager: TDownloadManager;
      ItemType: TKFRedirectItemType): Boolean;
    Procedure InstallLocalItem(FilePath: String; MapCycle, MapEntry: Boolean);
    function RemoveItem(ItemName: string; itemID: string;
      rmvMapEntry, rmvMapCycle, rmvSubscription, rmvLocalFile: Boolean;
      ItemSource: TKFSource; ItemType: TKFItemType): Boolean;
    function RemoveWorkshopManager: Boolean;
    function SetCustomRedirect(URL: String): Boolean;
    procedure SetKFApplicationPath(Path: string);
    procedure SetKFGameIniSubPath(Path: string);
    procedure SetKFServerPathEXE(Path: string);
    procedure SetSteamCmdPath(Path: String);
    procedure SetKFWebIniSubPath(Path: string);
    procedure SetWebPort(Port: Integer);
    procedure SetWebStatus(Status: Boolean);
    procedure SetMapCycleOptions(groupMapsByType: Boolean;
      includeSeparators: Boolean);
    procedure SetKFngineIniSubPath(Path: string);
    procedure SetKFAppLanguage(language: TKFAppLanguage);
    function GetKFAppLanguage(): TKFAppLanguage;
    procedure KillKFServer();
    procedure LogEvent(eventName: String; eventDescription: String);
    function IsServerRunning: Boolean;
    property verbose: Boolean read FverboseMod write FverboseMod;
    procedure ResortMapCycle;
    procedure SetCycleSortType(CSType: String);
        procedure SetIncludeSeparators(aValue: Boolean);
  const

    SERVERTOOLVERSION = '1.3.5';

    {

      CHANGE LOG VERSION 1.3.5
      - Updated English (Lots of grammar correction and spelling mistakes)
      - Localization system improvements
      - Deutsch Language added (thanks for wookiefriseur)
      - Bug fixes in automatic detection of official maps and minor improvements
      - Dual-screen-setup fix
      - Localization file improved

      * Special thanks for wookiefriseur in this update

      CMD VERSION
      - CMD Versions (linux/Windows) using KFserverTool module in version 1.3.5
      - Bugs fixes with cmd version
      - Added server install to cmd version



      CHANGE LOG VERSION 1.3.4
      - Added manual item installation (Local kfm files)
      - Spanish language updated


      CHANGE LOG VERSION 1.3.3
      - New help tip for fields
      - Small corrections in text formation of translated strings
      - Strings Encoding changed to UTF8

      CHANGE LOG VERSION 1.3.2
      - New translation system, now the tool is easy translatable for any language
      - Some spelling errors fixed

      CHANGE LOG VERSION 1.3.1 For Gui
      - Automatic detection of new official maps(Now new maps will be added as official automatically as soon the webadmin is updated by tripwire)
      - Image cache for Official maps removed from executable (reduced the size of executable)
      - Some spelling errors fixed

      CHANGE LOG VERSION 1.3.0 For Gui
      Fixed duplicate item in map cycle when an item is reinstalled

      CHANGE LOG VERSION 1.2.9 For Gui and cmd
      Added new map from update as official
      Added map cycle group and separator option
      Beta Server Update command updated

      CHANGE LOG VERSION 1.2.8 For Gui

      - Some user interface improvements


      CHANGE LOG VERSION 1.2.7 For Gui and CMD version

      - Process to identify the improved map file to avoid errors with workshop
      items that have more than one .kfm

      -------------------------------------------------------------------------------


      CHANGE LOG VERSION 1.2.6 For Gui and CMD version



      # Redirect

      - Added support to multiple items install from redirect

      - Added support to install mods from redirect



      # Sever maintenance

      - Added option to validate server for current version and beta

      # Map list management



      - Added support to Airship map as official one

      - Added support to LockDown map as official one



      #Gui

      - New map visualization system, with more two map list visualizations: Icon and Thumbnail, the classic still too

      - Img Thumbnail cache

      - Auto download of Thumbnail for Workshop maps page

      - All official maps Thumbnail supported



      #Bug fix

      - Some bugs fixed when the application language is Portuguese

      - Translation to portuguese updated

      - Some small bugs and code improvement





      # Marked as BETA

      - As this version added a lot of new functions and made a lot of code changes, it's marked as BETA

    }
  end;

implementation

constructor TKFItem.Create;
begin

end;

destructor TKFItem.Destroy;
begin

  inherited;
end;

function TKFServerTool.AddWorkshopSubscription(ID: String): Boolean;
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

function TKFServerTool.NewRedirectItem(downURL: String; ItemName: String;
  DownloadNow: Boolean; MapCycle: Boolean; MapEntry: Boolean;
  var dlManager: TDownloadManager; ItemType: TKFRedirectItemType): Boolean;
var
  ItemDownloaded: Boolean;
  AddedMapEntry: Boolean;
  AddedMapCycle: Boolean;
  KFRedirect: TKFRedirect;
  dlTool: TDownloaderTool;
  dlDestPath: String;
begin

  if IsIgnoredFile(ItemName) then
    raise Exception.Create
      ('This file replace an original server file. Not safe to replace.');

  try

    if (downURL <> '') or (ItemName <> '') then
    begin

      // Download redirect Item
      if DownloadNow and (downURL <> '') then
      begin
        KFRedirect := TKFRedirect.Create;
        dlTool := TDownloaderTool.Create;
        try
          case ItemType of
            KFRmap:
              dlDestPath := kfApplicationPath + KF_LOCALMAPSSUBFOLDER +
                ItemName;
            KFRmod:
              dlDestPath := kfApplicationPath + KF_BREWEDPCSSUBFOLDER +
                ItemName;
          end;

          ItemDownloaded := dlTool.downloadFile(downURL, dlDestPath, dlManager);
          if not ItemDownloaded then
          begin
            if dlManager.FileDAbort^ = true then
              raise Exception.Create('Download aborted')
            else
              raise Exception.Create('Falied to download file from url: '
                + downURL);

          end;
        finally
          FreeAndNil(KFRedirect);
          FreeAndNil(dlTool);
        end;
      end;

      // MapCycle and Map Entry
      if (ItemName <> '') then
      begin
        ItemName := IOUtils.TPath.GetFileNameWithoutExtension(ItemName);
        if MapEntry then
        begin
          AddedMapEntry := AddMapEntry(ItemName);
          LogEvent('Add item', 'Map entry added ' + BoolToWord(AddedMapEntry));
        end;
        if MapCycle then
        begin
          AddedMapCycle := AddMapCycle(ItemName, CycleSortType,
            CycleSortSeparators);
          LogEvent('Add item', 'Map Cycle added ' + BoolToWord(AddedMapCycle));
        end;
      end;

      result := true;

    end
    else
    begin
      // No id passed
      raise Exception.Create('No DownURL or itemname passed');
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
  wksp := TKFWorkshop.Create(kfApplicationPath);
  wksp.steamCmdTool := SteamCmdPath;
  try
    wksp.RemoveAcfReference(ID, true);
    ItemDownloaded := wksp.DownloadWorkshopItem(ID, verbose);
    ItemInCache := wksp.CopyItemToCache(ID);
    result := ItemDownloaded and ItemInCache;
  finally
    wksp.Free
  end;
end;
{$IFDEF MSWINDOWS}

function TKFServerTool.DownloadWorkshopItemImage(ID: String): Boolean;
var
  wksp: TKFWorkshop;
begin
  wksp := TKFWorkshop.Create(kfApplicationPath);
  try
    result := wksp.DownloadWorkshopImage(ID, nil);
  finally
    wksp.Free
  end;
end;
{$ENDIF}

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
        raise Exception.Create('Falied to export list: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(outputList);
  end;

end;

function TKFServerTool.CreateBlankACFFile(): Boolean;
var
  wksp: TKFWorkshop;

begin
  wksp := TKFWorkshop.Create(kfApplicationPath);
  wksp.steamCmdTool := SteamCmdPath;
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
  wksp.steamCmdTool := SteamCmdPath;
  try
    result := wksp.GetMapName(kfApplicationPath + KF_SERVERCACHEFOLDER +
      ID, False);
  finally
    wksp.Free
  end;
end;

function TKFServerTool.AddMapCycle(name: String; sortType: TKFCycleSort;
  separators: Boolean): Boolean;
var
  gmIni: TKFGameIni;
begin
  result := False;
  gmIni := TKFGameIni.Create;
  try
    if gmIni.LoadFile(kfApplicationPath + kfGameIniSubPath) then
    begin
      if gmIni.AddMapCycle(Name, sortType, separators) then
      begin
        gmIni.SaveFile(kfApplicationPath + kfGameIniSubPath);
        result := true;
      end;
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
      begin
        gmIni.SaveFile(kfApplicationPath + kfGameIniSubPath);
        result := true;
      end;
    end;
  finally
    gmIni.Free;
  end;
end;

function TKFServerTool.ImportItemsList(inputPath: string): Integer;
var
  I: Integer;
  inputList: TStringList;
  itemID, ItemName: string;
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
        ItemName := Copy(inputList[I], separatorPoint + 2,
          Length(inputList[I]) - separatorPoint - 2);
        if (itemID <> '') and (ItemName <> '') then
        begin
          InstallWorkshopItem(itemID, ItemName, true, False, False { dlimg } ,
            False, False);
          Inc(result);
        end;
      end;

    except
      on E: Exception do
      begin
        raise Exception.Create('Failed to import list: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(inputList);
  end;
end;

Procedure TKFServerTool.InstallLocalItem(FilePath: String;
  MapCycle, MapEntry: Boolean);
var
  FileName: string;
  ItemName: string;
  filesL: TStringList;
  dstFilePath: String;
begin

  FileName := ExtractFileName(FilePath);
  ItemName := TPath.GetFileNameWithoutExtension(FilePath);
  if (FileName = '') or (FilePath = '') then
    raise Exception.Create('Invalid File');
  filesL := TStringList.Create;
  try
    dstFilePath := IncludeTrailingPathDelimiter(kfApplicationPath) +
      KF_LOCALMAPSSUBFOLDER + FileName;
    if FileExists(dstFilePath) then
    begin
      filesL.Add(dstFilePath);
      FileOperation(filesL, '', 3 { FO_DELETE } );
    end;
    filesL.Clear;
    filesL.Add(FilePath);
    FileOperation(filesL, dstFilePath, 2 { FO_COPY } );
    if MapCycle then
      AddMapCycle(ItemName, CycleSortType, CycleSortSeparators);
    if MapEntry then
      AddMapEntry(ItemName);
  finally
    FreeAndNil(filesL);
  end;

end;

function TKFServerTool.InstallWorkshopItem(ID, name: String;
  WorkshopSubscribed, DownloadNow, DownloadImg, MapCycle,
  MapEntry: Boolean): Boolean;
var
  ItemDownloaded: Boolean;
  ItemImgDownloaded: Boolean;
  AddedMapEntry: Boolean;
  AddedMapCycle: Boolean;
  AddedWkspSub: Boolean;

begin
  try

    if (ID <> '') or (Name <> '') then
    begin
      try
        // AddWorkshopSubscription
        if WorkshopSubscribed then
        begin
          LogEvent('Install workshop item', 'Adding workshop subscription...');
          AddedWkspSub := AddWorkshopSubscription(ID);
          LogEvent('Install workshop item', 'Workshop subscription added = ' +
            BoolToWord(AddedWkspSub));
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
              'Item ' + ID + ' downloaded with name ' + Name);
          end;
{$IFDEF MSWINDOWS}
          ItemImgDownloaded := DownloadWorkshopItemImage(ID);
          try
            if ItemImgDownloaded then

              LogEvent('Install workshop item', 'Image Item ' + ID +
                ' downloaded')
            else
              LogEvent('Install workshop item', 'Image Item ' + ID +
                ' NOT downloaded');

          except
            on E: Exception do
              LogEvent('Install workshop item',
                'EXCEPTION downloading item img ' + ID + ' / ERROR : ' +
                E.Message);

          end;
{$ENDIF}
        end;

        // MapCycle and Map Entry
        if (Name <> '') then
        begin
          if MapEntry then
          begin
            LogEvent('Install workshop item', 'Adding map entry for ' + Name);
            AddedMapEntry := AddMapEntry(Name);
            LogEvent('Install workshop item', 'Map entry added = ' +
              BoolToWord(AddedMapEntry));
          end;
          if MapCycle then
          begin
            LogEvent('Install workshop item', 'Adding map cycle for ' + Name);
            AddedMapCycle := AddMapCycle(Name, CycleSortType,
              CycleSortSeparators);
            LogEvent('Install workshop item', 'Map cycle added = ' +
              BoolToWord(AddedMapCycle));
          end;
        end;
        LogEvent('Install workshop item', 'Finished job for item ' + ID);
        result := true;

      except
        on E: Exception do
        begin
          LogEvent('Install workshop item', 'Exception ' + E.Message);
          raise Exception.Create('Error adding item: ' + E.Message);
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
  directories: TStringList;
  files: TStringList;
  fileExt: string;
  ItemFolder: string;
  I, y: Integer;
  aItem: TKFItem;
  ItemName: String;
  egIniLoaded, gmIniLoaded: Boolean;
  egIni: TKFEngineIni;
  gmIni: TKFGameIni;
  wkspID: string;
  FileType: TKFItemType;
  cycleList: TStringList;
  mapEntriesList: TStringList;
begin
  result := False;
  if kfApplicationPath = '' then
    raise Exception.Create('KF Application path is not set');
  if kfEngineIniSubPath = '' then
    raise Exception.Create('KF EngineIniSubPath path is not set');
  if kfGameIniSubPath = '' then
    raise Exception.Create('KF GameIniSubPath path is not set');
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
      raise Exception.Create
        ('Failed to load PCServer-KFGame and PCServer-KFEngine. ' + #13 +
        'Check if the app is in the server folder and if you ran the server at least once');

    end;

    // ----------------------------------------------------- Cache folder load
    directories := ListDir(kfApplicationPath + KF_SERVERCACHEFOLDER);
    for I := 0 to directories.Count - 1 do
    begin
      try
        ItemFolder := kfApplicationPath + KF_SERVERCACHEFOLDER + directories[I]
          + PathDelim;
        files := GetAllFilesSubDirectory(ItemFolder, '*.*');

        try
          FileType := KFUnknown;
          if (files.Count > 0) then
          begin
            // Check folder type
            for y := 0 to files.Count - 1 do
            begin

              ItemName := ExtractFileName(files[y]);
              fileExt := UpperCase(ExtractFileExt(ItemName));
              if (Pos('KF', UpperCase(ItemName)) = 1) and (fileExt = '.KFM')
              then
              begin
                FileType := KFMap;
                Break;
              end;

              if MatchStr(fileExt, KF_MODPREFIX) then
              begin
                FileType := KFmod;
              end;
            end;

            if FileType <> KFUnknown then
            begin

              aItem := TKFItem.Create;
              aItem.ItemType := FileType;
              if FileType = KFmod then
                aItem.FileName := GetModName(files)
              else
                aItem.FileName := TPath.GetFileNameWithoutExtension(ItemName);

              aItem.ID := directories[I];
              aItem.ServerSubscribe := egIni.GetWorkshopItemIndex
                (directories[I]) >= 0;
              aItem.MapCycleEntry := gmIni.GetMapCycleIndex
                (TPath.GetFileNameWithoutExtension(ItemName)) >= 0;
              aItem.MapEntry := gmIni.GetMapEntryIndex
                (TPath.GetFileNameWithoutExtension(ItemName)) > 0;
              aItem.ServerCache := true;
              aItem.SourceFrom := KFSteamWorkshop;

              SetLength(Items, Length(Items) + 1);
              Items[High(Items)] := aItem;

              directories.Objects[I] := files;
            end;
          end;
        finally
          FreeAndNil(files);
        end;
      except
        LogEvent('Error loading folder ', directories[I] + ' of number ' +
          IntToStr(I) + '. Check this folder or delete.');
      end;
    end;

    // -------------------------------------------  Local and redirect mods
    try
      ItemFolder := kfApplicationPath + KF_BREWEDPCSSUBFOLDER;
      files := GetAllFilesInsideDirectory(ItemFolder, '*.*');
      try
        if (files.Count > 0) then
        begin
          for y := 0 to files.Count - 1 do
          begin
            ItemName := ExtractFileName(files[y]);
            fileExt := UpperCase(ExtractFileExt(ItemName));

            // Don't return ignored files
            if (MatchStr(fileExt, KF_MODPREFIX)) and
              (IsIgnoredFile(ItemName) = False) then
            begin
              aItem := TKFItem.Create;
              aItem.ItemType := KFmod;
              aItem.FileName := TPath.GetFileNameWithoutExtension(ItemName);
              aItem.ID := '';
              aItem.ServerSubscribe := False;
              aItem.MapCycleEntry := False;
              aItem.MapEntry := False;
              aItem.ServerCache := true;
              aItem.SourceFrom := KFRedirectOrLocal;
              SetLength(Items, Length(Items) + 1);
              Items[High(Items)] := aItem;
            end;
          end;
        end;
      finally
        FreeAndNil(files);
      end;
    except
      raise Exception.Create('Error loading local brewed pc folder.');
    end;
    // -------------------------------------------  Local and redirect maps load
    try
      ItemFolder := kfApplicationPath + KF_LOCALMAPSSUBFOLDER;
      files := GetAllFilesSubDirectory(ItemFolder, '*.*');

      try
        if (files.Count > 0) then
        begin
          for y := 0 to files.Count - 1 do
          begin
            ItemName := ExtractFileName(files[y]);
            fileExt := UpperCase(ExtractFileExt(ItemName));
            if (Pos('KF-', UpperCase(ItemName)) = 1) and (fileExt = '.KFM') then
            begin
              aItem := TKFItem.Create;
              aItem.ItemType := KFMap;
              aItem.FileName := TPath.GetFileNameWithoutExtension(ItemName);
              aItem.ID := '';
              aItem.ServerSubscribe := False;
              aItem.MapCycleEntry := gmIni.GetMapCycleIndex
                (TPath.GetFileNameWithoutExtension(ItemName)) >= 0;
              aItem.MapEntry := gmIni.GetMapEntryIndex
                (TPath.GetFileNameWithoutExtension(ItemName)) > 0;
              aItem.ServerCache := true;
              // Conditional Redirect or Oficial
              if IsOfficialMap(ExtractFileName(files[y])) then

                aItem.SourceFrom := KFOfficial
              else
                aItem.SourceFrom := KFRedirectOrLocal;

              SetLength(Items, Length(Items) + 1);
              Items[High(Items)] := aItem;

            end;

          end;

        end;
      finally
        FreeAndNil(files);
      end;
    except
      raise Exception.Create('Error loading local maps folder.');
    end;

    // -------------------------------------------  Workshop subscribe load
    for I := 0 to egIni.GetWorkshopSubscribeCount - 1 do
    begin
      wkspID := egIni.GetWorkshopSubscribeID(I);
      if (GetIDIndex(wkspID) < 0) and (wkspID <> '') then
      begin
        aItem := TKFItem.Create;
        aItem.ID := wkspID;
        aItem.ServerSubscribe := true;
        aItem.MapEntry := False;
        aItem.ServerCache := False;
        aItem.MapCycleEntry := False;
        aItem.ItemType := KFUnknown;
        aItem.FileName := '???';
        aItem.SourceFrom := KFSteamWorkshop;
        SetLength(Items, Length(Items) + 1);
        Items[High(Items)] := aItem;
      end;
      result := true;
    end;

    // -------------------------------------------  Cycle list load
    cycleList := gmIni.GetMapCycleList();
    try
      for I := 0 to cycleList.Count - 1 do
      begin
        ItemName := cycleList[I];
        //
        if (GetItemIndexByName(ItemName, true) = -1) and
          (IsIgnoredMap(ItemName) = False) and
          (ItemName <> KF_CYCLE_OFFICIAL_SEPARATOR) and
          (ItemName <> KF_CYCLE_CUSTOM_SEPARATOR) then
        begin
          aItem := TKFItem.Create;
          aItem.ID := '';
          aItem.ServerSubscribe := False;
          aItem.MapEntry := gmIni.GetMapEntryIndex(ItemName) <> -1;
          aItem.ServerCache := False;
          aItem.MapCycleEntry := true;
          aItem.ItemType := KFMap;
          aItem.FileName := ItemName;
          aItem.SourceFrom := KFUnknownSource;
          SetLength(Items, Length(Items) + 1);
          Items[High(Items)] := aItem;
        end;
        result := true;
      end;
    finally
      if assigned(cycleList) then
        FreeAndNil(cycleList);
    end;

    // -------------------------------------------  MapEntry list load
    mapEntriesList := gmIni.GetMapEntriesList;
    try
      for I := 0 to mapEntriesList.Count - 1 do
      begin
        ItemName := mapEntriesList[I];
        //
        if (GetItemIndexByName(ItemName, true) = -1) and
          (IsIgnoredMap(ItemName) = False) then
        begin
          aItem := TKFItem.Create;
          aItem.ID := '';
          aItem.ServerSubscribe := False;
          aItem.MapEntry := true;
          aItem.ServerCache := False;
          aItem.MapCycleEntry := False;
          // Since it's no already in list there is no cycle entry
          aItem.ItemType := KFMap;
          aItem.FileName := ItemName;
          aItem.SourceFrom := KFUnknownSource;
          SetLength(Items, Length(Items) + 1);
          Items[High(Items)] := aItem;
        end;
        result := true;
      end;
    finally
      if assigned(mapEntriesList) then
        FreeAndNil(mapEntriesList);
    end;

  finally
    FreeAndNil(egIni);
    FreeAndNil(gmIni);
    FreeAndNil(directories);
  end;

end;

procedure TKFServerTool.LogEvent(eventName, eventDescription: String);
var
  logFile: TStringList;
  logPath: String;
begin
  if verbose then
    Writeln(eventName + ': ' + eventDescription);

  if GenerateLog = False then
    Exit;

  logFile := TStringList.Create;
  logPath := kfApplicationPath + 'KFServerTool.log';
  try
    if FileExists(logPath) then
      logFile.LoadFromFile(logPath);
    logFile.Add(DateToStr(Now) + ' ' + TimeToStr(Now) + eventName + ' : ' +
      eventDescription);
    logFile.SaveToFile(logPath);
  finally
    FreeAndNil(logFile);
  end;

end;

function TKFServerTool.GetModName(files: TStringList): string;
var
  I: Integer;
begin

  for I := 0 to files.Count - 1 do
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

function TKFServerTool.GetSteamCmdPath: String;
begin
  result := SteamCmdPath;
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

function TKFServerTool.GetItemIndexByName(ItemName: String;
  ignoreCase: Boolean): Integer;
var
  I: Integer;
begin
  result := -1;
  for I := 0 to High(Items) do
  begin
    if ignoreCase then
    begin
      if UpperCase(Items[I].FileName) = UpperCase(ItemName) then
      begin
        result := I;
        Break
      end;
    end
    else
    begin
      if Items[I].FileName = ItemName then
      begin
        result := I;
        Break
      end;

    end;
  end;
end;

function TKFServerTool.ForceUpdate(itemID: String; IsMod: Boolean): Boolean;
var
  wksp: TKFWorkshop;
begin

  try
    wksp := TKFWorkshop.Create(kfApplicationPath);
    wksp.steamCmdTool := SteamCmdPath;
    LogEvent('Force update', 'Forcing update item for item id ' + itemID);
    // , is mod = ' + BoolToWord(IsMod));
    try
      LogEvent('Force update', 'Removing old references...');
      wksp.RemoveAcfReference(itemID, true);
      LogEvent('Force update', 'Downloading Item...');
      wksp.DownloadWorkshopItem(itemID, verbose);
      LogEvent('Force update', 'Copying the files to server cache...');
      result := wksp.CopyItemToCache(itemID);
      LogEvent('Force update', 'Downloading item image...');
{$IFDEF MSWINDOWS}
      wksp.DownloadWorkshopImage(itemID, nil);
      LogEvent('Force update', 'Finished');
{$ENDIF}
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
      result := gmIni.GetMapCycleList();
    end
    else
    begin
      result := TStringList.Create;
    end;

  finally
    gmIni.Free;
  end;

end;

procedure TKFServerTool.ResortMapCycle();
var
  gmIni: TKFGameIni;
begin
  gmIni := TKFGameIni.Create;
  try
    if gmIni.LoadFile(kfApplicationPath + kfGameIniSubPath) then
    begin
      gmIni.SortMapCycle(CycleSortType, CycleSortSeparators);
      gmIni.SaveFile(kfApplicationPath + kfGameIniSubPath);
    end
    else
    begin
      raise Exception.Create('Falied to load KF-Game file.');
    end;

  finally
    gmIni.Free;
  end;

end;

Function TKFServerTool.IsServerRunning(): Boolean;
begin
  result := ProcessExists(ExtractFileName(KFServerPathEXE));
end;

function TKFServerTool.RemoveItem(ItemName: string; itemID: string;
  rmvMapEntry, rmvMapCycle, rmvSubscription, rmvLocalFile: Boolean;
  ItemSource: TKFSource; ItemType: TKFItemType): Boolean;
var
  egIni: TKFEngineIni;
  gmIni: TKFGameIni;
  wksp: TKFWorkshop;
  redirect: TKFRedirect;
  egIniLoaded, gmIniLoaded: Boolean;
  I: Integer;
begin
  LogEvent('Remove item', 'Item name ' + ItemName + ' item id ' + itemID);
  case ItemSource of
    KFSteamWorkshop:
      LogEvent('Remove item', 'Source type is SteamWorkshop');
    KFOfficial:
      LogEvent('Remove item', 'Source type is Official map');
    KFRedirectOrLocal:
      LogEvent('Remove item', 'Source type is Redirect');
  end;
  case ItemType of
    KFMap:
      LogEvent('Remove item', 'Item type is KFMap');
    KFmod:
      LogEvent('Remove item', 'Item type is KFmod');
    KFUnknown:
      LogEvent('Remove item', 'Item type is KFUnknown');
  end;

  if rmvSubscription then
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
        LogEvent('Remove item', 'Removing Server subscription for item id '
          + itemID);
        if egIniLoaded then
        begin
          egIni.RemoveWorkshopItem(itemID, true);
          egIni.SaveFile(kfApplicationPath + kfEngineIniSubPath);
        end;
      finally
        egIni.Free;
      end;
    end;
  end;

  if rmvMapEntry or rmvMapCycle then
  begin
    if ItemName = '' then
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
          LogEvent('Remove item', 'Removing Map Entry for item ' + ItemName);
          gmIni.RemoveMapEntry(ItemName, true);
        end;
        if rmvMapCycle and gmIniLoaded then
        begin
          LogEvent('Remove item', 'Removing Map Cycle for item ' + ItemName);
          gmIni.RemoveMapCycle(ItemName, true, CycleSortType,
            CycleSortSeparators);
        end;
        gmIni.SaveFile(kfApplicationPath + kfGameIniSubPath);

      finally
        gmIni.Free
      end;

    end;
  end;

  if rmvLocalFile then
  begin
    if (ItemSource = KFSteamWorkshop) then
    begin

      if itemID = '' then
      begin
        raise Exception.Create('No ID, unable to remove cache');

      end
      else
      begin
        wksp := TKFWorkshop.Create(kfApplicationPath);
        wksp.steamCmdTool := SteamCmdPath;
        try
          LogEvent('Remove item', 'Removing ACF reference');
          wksp.RemoveAcfReference(itemID, true);
          LogEvent('Remove item', 'Deleting server cache');
          wksp.RemoveServeItemCache(itemID);
          LogEvent('Remove item', 'Deleting workshop cache');
          wksp.RemoveWorkshoItemCache(itemID);

        finally
          wksp.Free;
        end;

      end;

    end
    else
    begin
      if ItemSource = KFRedirectOrLocal then
      begin

        if ItemName = '' then
        begin
          LogEvent('Remove item', 'Exception: no id, unable to remove file');
          raise Exception.Create('No name, unable to remove file');

        end
        else
        begin
          redirect := TKFRedirect.Create();
          try
            LogEvent('Remove item', 'Deleting redirect file cache');
            case ItemType of
              KFMap:
                redirect.removeFile(ItemName + '.kfm',
                  kfApplicationPath + KF_LOCALMAPSSUBFOLDER, true);
              KFmod:
                begin
                  for I := 0 to High(KF_MODPREFIX) do
                    redirect.removeFile(ItemName + KF_MODPREFIX[I],
                      kfApplicationPath + KF_BREWEDPCSSUBFOLDER, False);
                end;
              KFUnknown:
                raise Exception.Create('Invalid item type for redirect');
            end;

          finally
            redirect.Free;
          end;

        end;

      end;
    end;

  end;

  result := true;

end;

// ToDo: Move to KFTypes?
function TKFServerTool.IsIgnoredMap(mapName: String): Boolean;
var
  I: Integer;
begin
  result := False;
  for I := 1 to High(KF_IGNOREMAPSENTRIES) do
  begin
    if UpperCase(mapName) = UpperCase(KF_IGNOREMAPSENTRIES[I]) then
    begin
      result := true;
      Break;
    end;
  end;
end;

// ToDo: Move to KFTypes?
function TKFServerTool.IsIgnoredFile(FileName: String): Boolean;
var
  I: Integer;
begin
  result := False;
  for I := 0 to High(KF_IGNOREDBREWEDPCFILES) do
  begin
    if UpperCase(FileName) = UpperCase(KF_IGNOREDBREWEDPCFILES[I]) then
    begin
      result := true;
      Break;
    end;
  end;
end;

function TKFServerTool.IsWorkshopManagerInstalled(): Boolean;
var
  egIni: TKFEngineIni;
begin
  result := true;
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

procedure TKFServerTool.SetKFApplicationPath(Path: string);
begin
  kfApplicationPath := Path;
  LogEvent('KFApplicationPath', Path);
end;

function TKFServerTool.GetKFAppLanguage: TKFAppLanguage;
begin
  result := appLanguage;
end;

function TKFServerTool.GetKFApplicationPath(): String;
begin
  result := kfApplicationPath;
end;

function TKFServerTool.getKFEngineIniPath: String;
begin
  result := kfEngineIniSubPath;
end;

function TKFServerTool.getKFGameIniPath: String;
begin
  result := kfGameIniSubPath;
end;

procedure TKFServerTool.SetKFGameIniSubPath(Path: string);
begin
  if FileExists(kfApplicationPath + Path) then
  begin
    kfGameIniSubPath := Path;
    LogEvent('KFGameIniSubPath', Path);
  end
  else
  begin
    raise Exception.Create('Invalid KFGame path: ' + kfApplicationPath + Path +
      #10#13 + 'Make sure you configured the path correcly.' + #10#13 +
      'If it''s a new server, before use the tool you need' + #10#13 +
      'to start the server one time to create the configs files.');
    LogEvent('KFGameIniSubPath', 'Exception : ' + kfApplicationPath + Path +
      ' not found');
  end;

end;

procedure TKFServerTool.SetKFngineIniSubPath(Path: string);
begin
  if FileExists(kfApplicationPath + Path) then
  begin
    kfEngineIniSubPath := Path;
    LogEvent('KFEngineIniSubPath', Path);
  end
  else
  begin
    raise Exception.Create('Invalid KFEngine path: ' + kfApplicationPath + Path
      + #10#13 + 'Make sure you configured the path correcly.' + #10#13 +
      'If it''s a new server, before use the tool you need' + #10#13 +
      'to start the server one time to create the configs files.');
    LogEvent('KFEngineIniSubPath', 'Exception : ' + kfApplicationPath + Path +
      ' not found');
  end;

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

procedure TKFServerTool.SetKFServerPathEXE(Path: string);
begin
  if FileExists(kfApplicationPath + Path) then
  begin
    KFServerPathEXE := Path;
    LogEvent('SetKFServerPathEXE', Path);
  end
  else
  begin
    raise Exception.Create('Invalid server exe path: ' + kfApplicationPath +
      Path + #13 +
      'Make sure you installed the tool correctly in the server folder or' + #13
      + 'Configured the path correcly.');
    LogEvent('SetKFServerPathEXE', 'Exception : ' + kfApplicationPath + Path +
      ' not found');
  end;
end;

procedure TKFServerTool.SetKFWebIniSubPath(Path: string);
begin
  kfWebIniSubPath := Path;
end;

procedure TKFServerTool.SetMapCycleOptions(groupMapsByType, includeSeparators
  : Boolean);
begin
  if groupMapsByType then
    CycleSortType := KFCSortByType
  else
    CycleSortType := KFCSortByName;
  CycleSortSeparators := includeSeparators;
end;

procedure TKFServerTool.SetCycleSortType(CSType: String);
begin
  if LowerCase(CSType) = 'bytype' then
    CycleSortType := KFCSortByType
  else if LowerCase(CSType) = 'byname' then
    CycleSortType := KFCSortByName
  else
    CycleSortType := KFCKeepSame;

end;

procedure TKFServerTool.SetIncludeSeparators(aValue: Boolean);
begin
 CycleSortSeparators :=  aValue;

end;

procedure TKFServerTool.SetSteamCmdPath(Path: String);
begin

  if FileExists(Path) then
  begin
    SteamCmdPath := Path;
    LogEvent('SteamCmdPath', Path);
  end
  else
  begin
    raise Exception.Create('Invalid steamcmd path: ' + Path + #13 +
      'Make sure you installed the tool correctly with steamcmd tool. ' + #13 +
      'You are unable to download from steam without steamcmd tool.');
    LogEvent('SteamCmdPath', 'Exception : ' + Path + ' not found');
  end;

end;

function TKFServerTool.GetKFServerPathEXE: string;
begin
  result := KFServerPathEXE;
end;

function TKFServerTool.getKFWebIniPath: String;
begin
  result := kfWebIniSubPath;
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
