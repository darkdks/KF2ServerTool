unit KFItemEntity;

interface

uses
  Windows, Classes, Dialogs, Forms, Controls,
  SysUtils, KFFile, KFWksp, UFuncoes, IOUtils, ItemProgress;

type

  TApplicationType = (atCmd, atGUI);

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

  TAppProgress = class(TObject)
  private
  var
    frmPB: TformPB;

  public
  var

    constructor Create(appProgressType: TApplicationType);
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

    constructor Create;
    destructor Destroy; override;

  end;

  TKFItems = class(TObject)
  private
  var
    kfWebIniSubPath: string;
    kfGameIniSubPath: string;
    kfEngineIniSubPath: string;
    kfApplicationPath: string;
    KFServerPathEXE: string;
    procedure CheckIfTheServerIsRunning;
    function GetIDIndex(ID: string): Integer;
    function GetModName(files: TStringList): string;


  public
  var
    Items: array of TKFItem;
    appType: TApplicationType;
    constructor Create;
    destructor Destroy; override;
    function NewItem(ID: String; Name: String; WorkshopSubscribe: Boolean;
      DownloadNow: Boolean; MapCycle: Boolean; MapEntry: Boolean): Boolean;
    function RemoveItem(ItemName: string; itemID: string;
      rmvMapEntry, rmvMapCycle, rmvSubcribe, rmvCache: Boolean): Boolean;
    function LoadItems(): Boolean;
    function GetGameCycle(): TStringList;
    function CreateBlankACFFile: Boolean;
    procedure SetKFWebIniSubPath(path: string);
    procedure SetKFGameIniSubPath(path: string);
    procedure SetkKFngineIniSubPath(path: string);
    procedure SetKFApplicationPath(path: string);
    function GetKFApplicationPath(): string;
    function ForceUpdate(itemID: String; IsMod: Boolean): Boolean;
    function InstallWorkshopManager: Boolean;
    function IsWorkshopManagerInstalled: Boolean;
    function RemoveWorkshopManager: Boolean;
    function AddWorkshopSubcribe(ID: String): Boolean;
    function DownloadWorkshopItem(ID: String): Boolean;
    function GetMapName(ID: string): string;
    function AddMapCycle(name: String): Boolean;
    function AddMapEntry(name: String): Boolean;
    procedure SetWebStatus(Status: Boolean);
    function GetWebStatus(): Boolean;
    procedure SetWebPort(Port: Integer);
    function GetWebPort(): Integer;

    procedure GetKFServerPathEXE(path: string);
    procedure SetKFServerPathEXE(path: string);

  end;

implementation

uses
  Main;
{ KFMap }

constructor TKFItem.Create;
begin

end;

destructor TKFItem.Destroy;
begin

  inherited;
end;

{ KFMaps }
function TKFItems.AddWorkshopSubcribe(ID: String): Boolean;
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

function TKFItems.DownloadWorkshopItem(ID: String): Boolean;
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


function TKFItems.CreateBlankACFFile(): Boolean;
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

function TKFItems.GetMapName(ID: string): string;
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

function TKFItems.AddMapCycle(name: String): Boolean;
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

function TKFItems.AddMapEntry(name: String): Boolean;
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

function TKFItems.NewItem(ID: String; Name: String; WorkshopSubscribe: Boolean;
  DownloadNow: Boolean; MapCycle: Boolean; MapEntry: Boolean): Boolean;
var
  ItemDownloaded: Boolean;
  AddedMapEntry: Boolean;
  AddedMapCycle: Boolean;
  AddedWkspSub: Boolean;
  progress: TformPB;
begin
  CheckIfTheServerIsRunning;
  result := False;
  AddedMapEntry := False;
  AddedMapCycle := False;
  AddedWkspSub := False;
  progress := TformPB.Create(FormMain);

  try

    progress.SetPBMax(4);
    progress.SetPBValue(0);
    progress.Show;

    if (ID <> '') or (Name <> '') then
    begin
      try
        // AddWorkshopSubcribe
        if WorkshopSubscribe then
        begin
          progress.NextPBValue('Adding workshop subcribe...');
          AddedWkspSub := AddWorkshopSubcribe(ID);

        end;

        // Download workshop Item
        if DownloadNow and (ID <> '') then
        begin
          progress.NextPBValue('Downloading workshop item, please wait...');
          ItemDownloaded := DownloadWorkshopItem(ID);
          if ItemDownloaded then
            Name := GetMapName(ID);
        end;

        // MapCycle and Map Entry
        if (Name <> '') then
        begin
          if MapEntry then
          begin
            progress.NextPBValue('Adding map entry..');
            AddedMapEntry := AddMapEntry(Name);
          end;
          if MapCycle then
          begin
            AddedMapCycle := AddMapCycle(Name);
            progress.NextPBValue('Adding map cycle..');
          end;
        end;

        progress.SetPBValue(0);
        progress.UpdateStatus('Done');
        progress.SetPBValue(0);
        result := True;
        Application.ProcessMessages;
        Sleep(100);
        progress.Close;

      except
        on E: Exception do
        begin
          raise Exception.Create('Exception Adding item: ' + E.Message);
          result := False;

        end;
      end;

    end
    else
    begin
      // No id passed
      raise Exception.Create('No id or name passed');
      result := False;
    end;

  finally
    progress.Free;
  end;

end;

constructor TKFItems.Create;
begin
  SetLength(Items, 0);

end;

destructor TKFItems.Destroy;
var i: Integer;
begin
try
  for i := 0 to High(Items) do FreeAndNil(Items[i]);

except

end;
  inherited;
end;

function TKFItems.LoadItems: Boolean;
var
  directorys: TStringList;
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
begin
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
              ItemName := ExtractFileName(files[y]);
              fileExt := UpperCase(ExtractFileExt(ItemName));
              if (Pos('KF', UpperCase(ItemName)) = 1) and (fileExt = '.KFM')
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
                aItem.FileName := TPath.GetFileNameWithoutExtension(ItemName);

              aItem.ID := directorys[I];
              aItem.ServerSubscribe := egIni.GetWorkshopItemIndex
                (directorys[I]) >= 0;
              aItem.MapCycleEntry := gmIni.GetMapCycleIndex
                (TPath.GetFileNameWithoutExtension(ItemName)) >= 0;
              aItem.MapEntry := gmIni.GetMapEntryIndex
                (TPath.GetFileNameWithoutExtension(ItemName)) > 0;
              aItem.ServerCache := True;

              SetLength(Items, Length(Items) + 1);
              Items[ High(Items)] := aItem;

              directorys.Objects[I] := files;
            end;
          end;
        finally
          files.Free;
        end;
      except
        ShowMessage('Error loading folder: ' + directorys[I]
            + ' of number ' + IntToStr(I) + '. Check this folder or delete.');
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
        SetLength(Items, Length(Items) + 1);
        Items[ High(Items)] := aItem;
      end;
      result := True;
    end;

  finally
    egIni.Free;
    gmIni.Free;
    directorys.Free;
  end;

end;

function TKFItems.GetModName(files: TStringList): string;
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

function TKFItems.GetWebPort: Integer;
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

function TKFItems.GetWebStatus: Boolean;
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

function TKFItems.GetIDIndex(ID: string): Integer;
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

function TKFItems.ForceUpdate(itemID: String; IsMod: Boolean): Boolean;
var
  wksp: TKFWorkshop;
  progress: TformPB;
begin
  CheckIfTheServerIsRunning;
  progress := TformPB.Create(FormMain);
  try
    progress.SetPBMax(2);
    progress.Show;

    wksp := TKFWorkshop.Create(kfApplicationPath);
    try
      progress.NextPBValue('Removing old references...');
      wksp.RemoveAcfReference(itemID, True);
      progress.NextPBValue('Downloading Item...');
      wksp.DownloadWorkshopItem(itemID);
      progress.NextPBValue('Copying the files to server cache...');
      result := wksp.CopyItemToCache(itemID);
    finally
      wksp.Free;
    end;
    progress.Close;
  finally
    progress.Free;
  end;

end;

function TKFItems.GetGameCycle: TStringList;
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

procedure TKFItems.CheckIfTheServerIsRunning;
var
  warningText, serverRunning: string;
  cmdOp: String;
begin

  warningText := 'You should close the server before make changes. ' + #13#10 +
    'Do you wanna close it now?';
  serverRunning := 'Server is running';

  if ProcessExists(ExtractFileName(KFServerPathEXE)) then
  begin

    if appType = atCmd then
    begin
      Writeln(warningText);
      Writeln(' YES/NO');
      Readln(cmdOp);
      if (LowerCase(cmdOp) = 'yes') or (LowerCase(cmdOp) = 'y') then
        KillProcessByName(ExtractFileName(FormMain.pathServerEXE));

    end
    else
    begin

      if FormMain.appLanguage = 'BR' then
      begin
        warningText :=
          'Você precisa fechar o server antes de fazer alterações. ' + #13#10 +
          'Fecha-lo agora??';
        serverRunning := 'Server em execução';
      end;

      if Application.MessageBox(PWideChar(warningText),
        PWideChar(serverRunning), MB_YESNO + MB_ICONWARNING) = IDYES then
      begin
        KillProcessByName(ExtractFileName(FormMain.pathServerEXE));
      end;

    end;
  end;
end;

function TKFItems.RemoveItem(ItemName: string; itemID: string;
  rmvMapEntry, rmvMapCycle, rmvSubcribe, rmvCache: Boolean): Boolean;
var
  egIni: TKFEngineIni;
  gmIni: TKFGameIni;
  wksp: TKFWorkshop;
  egIniLoaded, gmIniLoaded: Boolean;
  progress: TformPB;
begin
  CheckIfTheServerIsRunning;
  progress := TformPB.Create(FormMain);
  Result := False;
  try

    progress.SetPBMax(1);
    progress.btncancel.Visible := False;
    if rmvMapEntry then
      progress.SetPBMax(progress.GetPBMax + 1);
    if rmvMapCycle then
      progress.SetPBMax(progress.GetPBMax + 1);
    if rmvSubcribe then
      progress.SetPBMax(progress.GetPBMax + 1);
    if rmvCache then
      progress.SetPBMax(progress.GetPBMax + 3);

    progress.SetPBValue(0);
    progress.Show;

    if rmvSubcribe then
    begin
      if itemID = '' then
      begin
        raise Exception.Create('No ID, unable to remove subscription');

      end
      else
      begin

        egIni := TKFEngineIni.Create;
        try
          egIniLoaded := egIni.LoadFile(kfApplicationPath + kfEngineIniSubPath);
          progress.NextPBValue('Removing Server Subcribe');
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
            progress.NextPBValue('Removing Map Entry');
            gmIni.RemoveMapEntry(ItemName, True);
          end;
          if rmvMapCycle and gmIniLoaded then
          begin
            progress.NextPBValue('Removing Map Cycle');
            gmIni.RemoveMapCycle(ItemName, True);
          end;
          gmIni.SaveFile(kfApplicationPath + kfGameIniSubPath);

        finally
          gmIni.Free
        end;

      end;
    end;

    if rmvCache then
    begin
      if itemID = '' then
      begin
        raise Exception.Create('No ID, unable to remove cache');

      end
      else
      begin
        wksp := TKFWorkshop.Create(kfApplicationPath);

        try
          progress.NextPBValue('Removing ACF reference');
          wksp.RemoveAcfReference(itemID, True);
          progress.NextPBValue('Deleting server cache');
          wksp.RemoveServeItemCache(itemID);
          progress.NextPBValue('Deleting workshop cache');
          wksp.RemoveWorkshoItemCache(itemID);

        finally
          wksp.Free;
        end;
      end;
    end;
    Sleep(100);
    progress.NextPBValue('Done');
    Sleep(100);
    progress.Close;
    result := True;

  finally
    progress.Free;
  end;
end;

function TKFItems.IsWorkshopManagerInstalled(): Boolean;
var
  egIni: TKFEngineIni;
begin
  result := True;
  egIni := TKFEngineIni.Create;
  try
    if egIni.LoadFile(kfApplicationPath + kfEngineIniSubPath) then
    begin
      result := egIni.WorkshopRedirectInstalled;
    end;

  finally
    egIni.Free;
  end;

end;

function TKFItems.InstallWorkshopManager(): Boolean;
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

function TKFItems.RemoveWorkshopManager(): Boolean;
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

procedure TKFItems.SetKFApplicationPath(path: string);
begin
  kfApplicationPath := path;
end;

function TKFItems.GetKFApplicationPath(): String;
begin
  result := kfApplicationPath;
end;

procedure TKFItems.SetKFGameIniSubPath(path: string);
begin

  kfGameIniSubPath := path;
end;

procedure TKFItems.SetkKFngineIniSubPath(path: string);
begin
  kfEngineIniSubPath := path;
end;

procedure TKFItems.SetWebPort(Port: Integer);
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

procedure TKFItems.SetWebStatus(Status: Boolean);
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

procedure TKFItems.SetKFServerPathEXE(path: string);
begin
  KFServerPathEXE := path;
end;

procedure TKFItems.SetKFWebIniSubPath(path: string);
begin
  kfWebIniSubPath := path;
end;

procedure TKFItems.GetKFServerPathEXE(path: string);
begin
  KFServerPathEXE := path;
end;

{ TAppProgress }

constructor TAppProgress.Create(appProgressType: TApplicationType);
begin
  if appProgressType = atCmd then
  begin

  end
  else
  begin

  end;
end;

destructor TAppProgress.Destroy;
begin

  inherited;
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
