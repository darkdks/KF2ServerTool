unit KFFile;

interface

uses
  Classes,
  SysUtils,
  MiscFunc,
  Character,
  KFTypes;

type

  TKFEntry = class(TObject)
  private
  public
    title: String;
    items: TStringList;
    constructor Create;
    destructor Destroy; override;
  end;

  TKFConfigFile = class(TObject)
  private
    function ModifyValue(newValue: String;
      EntryIndex, ItemIdex: Integer): Boolean;
    function RemoveSectionAt(index: Integer): Boolean;
    // function RemoveItemAt(EntryIndex, itemIndex: Integer): Boolean;
    Function AddNewSectionAt(entry: TKFEntry; index: Integer): Boolean;
    function GetCategoryIndex(category: String; getLast: Boolean): Integer;
    function GetItemIndex(name: String; index: Integer): Integer;
    function GetSectionIndex(name: string; getLast: Boolean): Integer;
    function GetValue(EntryIndex, ItemIdex: Integer): String;
    function AddNewItemAt(NewItem: string; EntryIndex: Integer;
      at: Integer): Boolean;
  public
    Filename: String;
    FilePath: string;
    Entries: array of TKFEntry;
    constructor Create;
    destructor Destroy; override;
    function LoadFile(path: String): Boolean;
    function SaveFile(path: String): Boolean;

  const
    CMAPNAME = 'MapName';
    CMAPASSOCIATION = 'MapAssociation';
    CSCREENSHOTPATHNAME = 'ScreenshotPathName';
    CDEFAULTSCREENSHOT = 'UI_MapPreview_TEX.UI_MapPreview_Placeholder';
    CMAPTYPE = 'KFMapSummary';
    CGAMEINFO = 'KFGame.KFGameInfo';
    CGAMEMAPCYCLES = 'GameMapCycles';
    CENGINEACESSCONTROL = 'Engine.AccessControl';
    CADMINPASSWORD = 'AdminPassword';

  end;

  TKFWebIni = class(TKFConfigFile)
  private
    procedure CreateServerTags;

  public
    constructor Create;
    destructor Destroy; override;
    function GetWebStatus(): Boolean;
    procedure SetWebStatus(Status: Boolean);
    function GetWebPort(): Integer;
    procedure SetWebPort(Port: Integer);

  const
    CCategoryWeb = 'IpDrv.WebServer';
    CWebPortTag = 'ListenPort';
    CWebStatusTag = 'bEnabled';
  end;

  TKFGameIni = class(TKFConfigFile)
  private
    procedure removeMapCycleSeparators(var mapCycle: TStringList);
    function GetCycleTextArray: String;
    procedure SetCycleTextArray(textArray: string);

  public
    constructor Create;
    destructor Destroy; override;
    function GetMapNameAt(index: Integer): string;
    function GetAdminPass(): String;
    function SetAdminPass(password: String): Boolean;
    function AddMapEntry(name: String): Boolean;
    function RemoveMapEntry(name: String; removeAll: Boolean): Boolean;
    function AddMapCycle(name: String; sortType: TKFCycleSort;
      separators: Boolean): Boolean;
    procedure SortMapCycle(sortType: TKFCycleSort; addSeparator: Boolean);
    function RemoveMapCycle(name: String; removeAll: Boolean;
      sortType: TKFCycleSort; separators: Boolean): Boolean;
    function GMCTextToStrings(GMCText: string): TStringList;
    function GMCStringsToText(GMCStrings: TStringList): string;
    function GetMapEntryIndex(name: String): Integer;
    function GetMapCycleIndex(name: String): Integer;
    function GetMapCycleList(): TStringList;
    function GetMapEntriesList: TStringList;

  end;

  TKFEngineIni = class(TKFConfigFile)
  private
    function AddWorkshopSection(): Boolean;

  public
    constructor Create;
    destructor Destroy; override;
    function AddWorkshopItem(ID: string): Boolean;
    function RemoveWorkshopItem(ID: string; removeAll: Boolean): Boolean;
    function AddWorkshopRedirect(): Boolean;
    function RemoveWorkshopRedirect(): Boolean;
    function SetCustomRedirect(URL: String): Boolean;
    function GetCustomRedirect: string;
    function GetWorkshopItemIndex(ID: string): Integer;
    function GetWorkshopStatus: Boolean;
    function GetWorkshopSubscribeCount: Integer;
    function GetWorkshopSubscribeID(itemIndex: Integer): String;

  const
    CWORKSHOPSUBTITLE = 'OnlineSubsystemSteamworks.KFWorkshopSteamworks';
    CWORKSHOPSUBITEM = 'ServerSubscribedWorkshopItems';
    CTCPNETDRIVER = 'IpDrv.TcpNetDriver';
    CDOWNLOADMANAGERS = 'DownloadManagers';
    CDMWORKSHOP = 'OnlineSubsystemSteamworks.SteamWorkshopDownload';
    CURLREDIRECT = 'RedirectToURL';
    CHTTPDOWNLOAD = 'IpDrv.HTTPDownload';

  end;

implementation

function IsCategory(text: String): Boolean;
begin
  if (Length(text) > 1) and (text[1] = '[') and (text[StrLen(PChar(text))] = ']')
  then
    Result := true
  else
    Result := false;
end;

function GetCategoryName(text: String): String;
var
  markpos1, markpos2: Integer;
begin
  markpos1 := Pos(' ', text);
  markpos2 := Pos(']', text);
  Result := '';
  if (markpos1 > 0) and (markpos2 > 0) then
  begin
    Result := Copy(text, markpos1 + 1, markpos2 - markpos1 - 1);
  end;
end;

{ TKFEntry }

constructor TKFEntry.Create;
begin
  items := TStringList.Create;
  title := '';
end;

destructor TKFEntry.Destroy;
begin
  items.Free;
  inherited;
end;

{ TKFConfigFile }

constructor TKFConfigFile.Create;
begin
  SetLength(Entries, 0);

end;

destructor TKFConfigFile.Destroy;
var
  i: Integer;
begin
  for i := 0 to Length(Entries) - 1 do
    FreeAndNil(Entries[i]);
  inherited;
end;

function TKFConfigFile.LoadFile(path: String): Boolean;
var
  configFile: TStringList;
  i, currentEntry: Integer;
begin
  Result := false;
  try
    configFile := TStringList.Create;
    try
      for i := 0 to High(Entries) do
        Entries[i].Free;
      SetLength(Entries, 0);
      currentEntry := 0;
      configFile.LoadFromFile(path);
      if configFile.Count > 1 then
      begin

        for i := 0 to configFile.Count - 1 do
        begin

          if IsCategory(configFile.Strings[i]) then
          begin
            SetLength(Entries, Length(Entries) + 1);
            currentEntry := High(Entries);
            Entries[currentEntry] := TKFEntry.Create;
            Entries[currentEntry].title := configFile.Strings[i];
          end
          else
          begin
            Entries[currentEntry].items.Add(configFile.Strings[i]);
          end;

        end;
        Filename := ExtractFileName(path);
        FilePath := ExtractFilePath(path);
        Result := true;
      end;

    finally
      configFile.Free;
    end;
  except
    on e: Exception do
      raise Exception.Create('Failed to load ' + path + ': ' + e.Message);
  end;
end;

function TKFConfigFile.SaveFile(path: String): Boolean;
var
  configFile: TStringList;
  i: Integer;
begin
  Result := false;
  try
    configFile := TStringList.Create;
    try

      if High(Entries) >= 1 then
      begin

        for i := 0 to High(Entries) do
        begin
          configFile.Add(Entries[i].title);
          configFile.AddStrings(Entries[i].items);
        end;

        configFile.SaveToFile(path);
        Result := true;
      end;

    finally
      configFile.Free;
    end;
  except
    on e: Exception do
      raise Exception.Create('Failed to save ' + path + ': ' + e.Message);
  end;
end;

function TKFConfigFile.GetCategoryIndex(category: String;
  getLast: Boolean): Integer;
var
  i: Integer;
  currentCategory: string;
begin
  Result := -1;
  for i := 0 to High(Entries) do
  begin
    currentCategory := GetCategoryName(Entries[i].title);
    if currentCategory = category then
    begin
      Result := i;
      if getLast = false then
        Exit;

    end;
  end;

end;

function TKFConfigFile.GetItemIndex(name: String; index: Integer): Integer;
var
  i: Integer;
  line, param: string;
begin
  Result := -1;
  if (index > High(Entries)) or (index < 0) then
    Exit;

  for i := 0 to Entries[index].items.Count - 1 do
  begin
    line := Entries[index].items[i];
    param := Copy(line, 0, Pos('=', line) - 1);
    if param = name then
    begin
      Result := i;
      Exit;
    end;
  end;
end;

function TKFConfigFile.GetSectionIndex(name: string; getLast: Boolean): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to High(Entries) do
  begin
    // ShowMessage(Copy(Entrys[i].title, 2, Length(Entrys[i].title) - 2));
    if UpperCase(Copy(Entries[i].title, 2, Length(Entries[i].title) - 2))  = UpperCase(name) then
    begin
      Result := i;
      if getLast = false then
        Exit;
    end;
  end;
end;

function TKFConfigFile.ModifyValue(newValue: String; EntryIndex: Integer;
  ItemIdex: Integer): Boolean;
var
  line, param1, param2: string;
begin
  Result := false;
  if Pos('=', Entries[EntryIndex].items[ItemIdex]) < 0 then
    Exit;
  try
    try
      line := Entries[EntryIndex].items[ItemIdex];

      param1 := Copy(line, 0, Pos('=', line) - 1);
      param2 := newValue;
      Entries[EntryIndex].items[ItemIdex] := param1 + '=' + param2;
      Result := true;
    finally

    end;
  except
    Result := false
  end;
end;

function TKFConfigFile.GetValue(EntryIndex: Integer; ItemIdex: Integer): String;
var
  line: string;
begin
  Result := '';
  if Pos('=', Entries[EntryIndex].items[ItemIdex]) < 0 then
    Exit;
  try
    try
      line := Entries[EntryIndex].items[ItemIdex];
      Result := Copy(line, Pos('=', line) + 1, Length(line) - Pos('=', line));

    finally

    end;
  except
    Result := '';
  end;
end;

function TKFConfigFile.AddNewSectionAt(entry: TKFEntry; index: Integer)
  : Boolean;
var
  i: Integer;
  EntriesCopy: array of TKFEntry;
begin

  try
    try
      // Copying entries
      SetLength(EntriesCopy, Length(Entries));
      for i := 0 to High(Entries) do
      begin
        EntriesCopy[i] := TKFEntry.Create;
        EntriesCopy[i].title := Entries[i].title;
        EntriesCopy[i].items.text := Entries[i].items.text;
      end;
      // Adding new entry
      SetLength(Entries, Length(Entries) + 1);
      Entries[High(Entries)] := TKFEntry.Create;
      Entries[index].title := entry.title;
      Entries[index].items.text := entry.items.text;
      // Remounting entries
      for i := index + 1 to High(Entries) do
      begin
        Entries[i].title := EntriesCopy[i - 1].title;
        Entries[i].items.text := EntriesCopy[i - 1].items.text;
      end;
      Result := true;
    finally
      for i := 0 to High(EntriesCopy) do
        EntriesCopy[i].Free;
      SetLength(EntriesCopy, 0);
    end;
  except
    on e: Exception do
    begin
      raise Exception.Create('Failed to add map entry: ' + e.Message);
    end;
  end;
end;

function TKFConfigFile.AddNewItemAt(NewItem: string; EntryIndex: Integer;
  at: Integer): Boolean;
var
  i: Integer;
  StrListCopy: TStringList;
begin
  Result := false;
  try
    // copying Entries
    StrListCopy := TStringList.Create;
    try

      for i := 0 to Entries[EntryIndex].items.Count - 1 do
      begin
        StrListCopy.Add(Entries[EntryIndex].items[i]);
      end;

      Entries[EntryIndex].items.Clear;

      for i := 0 to StrListCopy.Count - 1 do
      begin
        if i = at then
        begin
          Entries[EntryIndex].items.Add(NewItem);
          Result := true;
        end;
        Entries[EntryIndex].items.Add(StrListCopy.Strings[i]);

      end;

    finally
      StrListCopy.Free;
    end;
  except
    on e: Exception do
      raise Exception.Create('Failed to add new item: ' + e.Message);
  end;
end;

function TKFConfigFile.RemoveSectionAt(index: Integer): Boolean;
var
  i: Integer;
  EntriesCopy: array of TKFEntry;
begin

  try
    try
      // copying Entries
      SetLength(EntriesCopy, Length(Entries));
      for i := 0 to High(Entries) do
      begin
        EntriesCopy[i] := TKFEntry.Create;
        EntriesCopy[i].title := Entries[i].title;
        EntriesCopy[i].items.text := Entries[i].items.text;
      end;
      // removing one item
      Entries[High(Entries)].Free;
      SetLength(Entries, Length(Entries) - 1);
      // Remounting Entries
      for i := 0 to High(EntriesCopy) do
      begin
        if i < index then
        begin
          Entries[i].title := EntriesCopy[i].title;
          Entries[i].items.text := EntriesCopy[i].items.text;
        end
        else
        begin
          if i > index then
          begin
            Entries[i - 1].title := EntriesCopy[i].title;
            Entries[i - 1].items.text := EntriesCopy[i].items.text;
          end;
        end;
      end;
      Result := true;
    finally
      for i := 0 to High(EntriesCopy) do
        EntriesCopy[i].Free;
      SetLength(EntriesCopy, 0);
    end;
  except
    on e: Exception do
    begin
      raise Exception.Create('Failed to remove item: ' + e.Message);

    end;
  end;
end;
{
  function TKFConfigFile.RemoveItemAt(EntryIndex, itemIndex: Integer): Boolean;
  begin
  Result := true;
  try
  if (EntryIndex > High(Entries)) or
  (itemIndex > Entries[EntryIndex].items.Count - 1) then
  raise Exception.Create('Invalid entry index or item index');

  Entries[EntryIndex].items.Delete(itemIndex);

  except
  on e: Exception do
  begin
  raise Exception.Create('Failed to remove item: ' + e.Message);
  end;
  end;

  end;
}
{ TKFGameIni }

constructor TKFGameIni.Create;
begin

end;

destructor TKFGameIni.Destroy;
begin

  inherited;
end;

function TKFGameIni.GetMapNameAt(index: Integer): string;
var
  Titleline: string;
begin
  Result := '';
  Titleline := Entries[index].title;
  if GetCategoryName(Titleline) = CMAPTYPE then
  begin
    Result := Copy(Titleline, Pos('[', Titleline) + 1, Pos(' ', Titleline) - 2);
  end;
end;

function TKFGameIni.GMCTextToStrings(GMCText: string): TStringList;
var
  chrInx: Integer;
  aMap: string;
begin
  chrInx := 0;
  aMap := '';
  Result := TStringList.Create;
  while chrInx < Length(GMCText) do
  begin

    if GMCText[chrInx] = '"' then
    begin

      while GMCText[chrInx + 1] <> '"' do
      begin
        aMap := aMap + GMCText[chrInx + 1];
        chrInx := chrInx + 1;
      end;
      Result.Add(aMap);
      aMap := '';
      chrInx := chrInx + 1;
    end;
    chrInx := chrInx + 1;

  end;

end;

function TKFGameIni.GMCStringsToText(GMCStrings: TStringList): string;
var
  i: Integer;
begin

  Result := '(Maps=(';
  for i := 0 to GMCStrings.Count - 1 do
  begin
    Result := Result + '"' + GMCStrings.Strings[i] + '"';
    if i < GMCStrings.Count - 1 then
      Result := Result + ','
  end;
  Result := Result + '))';

end;

function TKFGameIni.RemoveMapCycle(name: String; removeAll: Boolean;
  sortType: TKFCycleSort; separators: Boolean): Boolean;
var
  i, GI_index, GMC_index: Integer;
  newMapCycle, oldMapCycle: string;
  mapList: TStringList;
begin

  try

    GI_index := GetSectionIndex(CGAMEINFO, false);
    GMC_index := GetItemIndex(CGAMEMAPCYCLES, GI_index);
    if (GI_index < 0) or (GMC_index < 0) then
    begin
      raise Exception.Create('Failed to remove. GameMapCycles not found.');
      Exit;
    end;
    oldMapCycle := GetValue(GI_index, GMC_index);
    mapList := GMCTextToStrings(oldMapCycle);
    try
      i := 0;
      while i < mapList.Count do
      begin
        if UpperCase(mapList[i]) = UpperCase(name) then
        begin
          mapList.Delete(i);
        end
        else
        begin
          i := i + 1;
        end;

      end;
      newMapCycle := GMCStringsToText(mapList);
      ModifyValue(newMapCycle, GI_index, GMC_index);
      SortMapCycle(sortType, separators);
      Result := true;
    finally
      FreeAndNil(mapList);
    end;
  except
    Result := false;
  end;
end;

function TKFGameIni.GetCycleTextArray(): String;
var
  GI_index, GMC_index: Integer;
begin
  GI_index := GetSectionIndex(CGAMEINFO, false);
  GMC_index := GetItemIndex(CGAMEMAPCYCLES, GI_index);

  if (GI_index < 0) or (GMC_index < 0) then
  begin
    raise Exception.Create
      ('Failed to get mapcycle array. GameMapCycles not found.');
    Exit;
  end;
  Result := GetValue(GI_index, GMC_index);
end;

procedure TKFGameIni.SetCycleTextArray(textArray: String);
var
  GI_index, GMC_index: Integer;
begin
  GI_index := GetSectionIndex(CGAMEINFO, false);
  GMC_index := GetItemIndex(CGAMEMAPCYCLES, GI_index);
  if (GI_index < 0) or (GMC_index < 0) then
  begin
    raise Exception.Create
      ('Failed to get mapcycle array. GameMapCycles not found.');
    Exit;
  end;
  ModifyValue(textArray, GI_index, GMC_index);
end;

function TKFGameIni.AddMapCycle(name: String; sortType: TKFCycleSort;
  separators: Boolean): Boolean;
var
  newMapCycle: string;
  cycleTextArray: String;
  mapList: TStringList;
begin
  try
    cycleTextArray := GetCycleTextArray();

    if Pos('"' + name + '"', cycleTextArray) > 0 then
    begin
      RemoveMapCycle(name, true, sortType, separators);
      cycleTextArray := GetCycleTextArray();
    end;
    try

      mapList := GMCTextToStrings(cycleTextArray);
      mapList.Add(name);
      newMapCycle := GMCStringsToText(mapList);
      SetCycleTextArray(newMapCycle);
      SortMapCycle(sortType, separators);
      Result := true;
    finally
      FreeAndNil(mapList);
    end;
  except
    on e: Exception do
    begin
      raise Exception.Create('Failed to edit: ' + e.Message);

    end;
  end;
end;

function TKFGameIni.GetMapCycleList(): TStringList;
var
  mapCycle: string;
  GI_index, GMC_index: Integer;
begin

  try
    try
      GI_index := GetSectionIndex(CGAMEINFO, false);
      GMC_index := GetItemIndex(CGAMEMAPCYCLES, GI_index);

      if (GI_index < 0) or (GMC_index < 0) then
      begin
        raise Exception.Create
          ('Failed to get map cycle. GameMapCycles not found.');
        Exit;
      end;
      mapCycle := GetValue(GI_index, GMC_index);
      Result := GMCTextToStrings(mapCycle);
    finally

    end;
  except
    on e: Exception do
      raise Exception.Create('Failed to get map cycle: ' + e.Message);
  end;

end;

function TKFGameIni.RemoveMapEntry(name: String; removeAll: Boolean): Boolean;
var
  i: Integer;
begin
  Result := false;
  i := 0;
  while i <= High(Entries) do
  begin
    if (GetCategoryName(Entries[i].title) = CMAPTYPE) and
      (GetMapNameAt(i) = name) then
    begin
      Result := RemoveSectionAt(i);
      if removeAll = false then
        Exit;
    end
    else
    begin
      i := i + 1;
    end;

  end;
end;

function TKFGameIni.SetAdminPass(password: String): Boolean;
var
  TND_index, DM_index: Integer;
begin
  try
    TND_index := GetSectionIndex(CENGINEACESSCONTROL, false);
    DM_index := GetItemIndex(CADMINPASSWORD, TND_index);

    if (TND_index >= 0) and (DM_index >= 0) then
    begin
      Result := ModifyValue(password, TND_index, DM_index);
    end
    else
    begin
      raise Exception.Create('Failed to find ' + CENGINEACESSCONTROL + ' / ' +
        CADMINPASSWORD + ' fields.');

    end;

  except
    on e: Exception do
      raise Exception.Create('Error setting admin password: ' + e.Message);
  end;

end;

procedure TKFGameIni.SortMapCycle(sortType: TKFCycleSort;
  addSeparator: Boolean);
var
  i: Integer;
  OfficialMapsCycle, CustomMapsCycle: TStringList;
  mapCycle: TStringList;
  cycleText: String;
begin

  cycleText := GetCycleTextArray;
  mapCycle := GMCTextToStrings(cycleText);
  try
    if Assigned(mapCycle) = false then
      raise Exception.Create('Failed to get map cycle list');
    case sortType of
      KFCSortByType:
        begin
          OfficialMapsCycle := TStringList.Create;
          CustomMapsCycle := TStringList.Create;
          try
            removeMapCycleSeparators(mapCycle);
            for i := 0 to mapCycle.Count - 1 do
            begin
              if IsOfficialMap((mapCycle[i])) then
                OfficialMapsCycle.Add(mapCycle[i])
              else
                CustomMapsCycle.Add(mapCycle[i]);
            end;
            OfficialMapsCycle.Sort;
            CustomMapsCycle.Sort;
            mapCycle.Clear;
            if OfficialMapsCycle.Count > 0 then
            begin
              if addSeparator then
                mapCycle.Add(KF_CYCLE_OFFICIAL_SEPARATOR);
              mapCycle.AddStrings(OfficialMapsCycle);
            end;
            if CustomMapsCycle.Count > 0 then
            begin
              if addSeparator then
                mapCycle.Add(KF_CYCLE_CUSTOM_SEPARATOR);
              mapCycle.AddStrings(CustomMapsCycle);
            end;
          finally
            FreeAndNil(CustomMapsCycle);
            FreeAndNil(OfficialMapsCycle);
          end;
        end;
      KFCSortByName:
        begin
          removeMapCycleSeparators(mapCycle);
          mapCycle.Sort;
        end;
      KFCKeepSame:
        Exit;
    end;
    cycleText := GMCStringsToText(mapCycle);
    SetCycleTextArray(cycleText);
  finally
    FreeAndNil(mapCycle);
  end;
end;

procedure TKFGameIni.removeMapCycleSeparators(var mapCycle: TStringList);
begin
  if mapCycle.IndexOf(KF_CYCLE_OFFICIAL_SEPARATOR) >= 0 then
    mapCycle.Delete(mapCycle.IndexOf(KF_CYCLE_OFFICIAL_SEPARATOR));
  if mapCycle.IndexOf(KF_CYCLE_CUSTOM_SEPARATOR) >= 0 then
    mapCycle.Delete(mapCycle.IndexOf(KF_CYCLE_CUSTOM_SEPARATOR));
end;

function TKFGameIni.AddMapEntry(name: String): Boolean;
var
  newEntry: TKFEntry;
begin
  if GetSectionIndex(name + ' ' + CMAPTYPE, true) >= 0 then
  begin
    RemoveMapEntry(name, true);
  end;

  newEntry := TKFEntry.Create;
  try
    newEntry.title := '[' + name + ' ' + CMAPTYPE + ']';
    newEntry.items.Add(CMAPNAME + '=' + name);
    newEntry.items.Add(CMAPASSOCIATION + '=' + '0');
    newEntry.items.Add(CSCREENSHOTPATHNAME + '=' + CDEFAULTSCREENSHOT);
    newEntry.items.Add('');
    Result := AddNewSectionAt(newEntry, GetCategoryIndex('KFMapSummary',
      true) + 1);
  finally
    FreeAndNil(newEntry);
  end;
end;

function TKFGameIni.GetMapEntryIndex(name: String): Integer;
begin
  Result := GetSectionIndex(name + ' ' + CMAPTYPE, true);
end;

function TKFGameIni.GetMapEntriesList: TStringList;
var
  i: Integer;
  mapName: String;
begin
  Result := TStringList.Create;
  try
    for i := 0 to High(Entries) do
    begin
      mapName := GetMapNameAt(i);
      if mapName <> '' then
      begin
        Result.Add(mapName);
      end;
    end;
  finally

  end;

end;

function TKFGameIni.GetAdminPass: String;
var
  TND_index, DM_index: Integer;
begin
  Result := '';
  try
    TND_index := GetSectionIndex(CENGINEACESSCONTROL, false);
    DM_index := GetItemIndex(CADMINPASSWORD, TND_index);

    if (TND_index >= 0) and (DM_index >= 0) then
    begin
      Result := GetValue(TND_index, DM_index);
    end
    else
    begin
      raise Exception.Create('Failed to find ' + CENGINEACESSCONTROL + ' / ' +
        CADMINPASSWORD + ' fields.');

    end;

  except
    on e: Exception do
      raise Exception.Create('Error getting admin password: ' + e.Message);
  end;

end;

function TKFGameIni.GetMapCycleIndex(name: String): Integer;
var
  mapList: TStringList;
  i: Integer;
begin
  Result := -1;
  try
    mapList := GetMapCycleList();
    try
      for i := 0 to mapList.Count - 1 do
      begin
        if UpperCase(mapList[i]) = UpperCase(name) then
        begin
          Result := i;
          Exit;
        end;
      end;

    finally
      mapList.Free;
    end;
  except
    on e: Exception do
      raise Exception.Create('Failed to get gameMapCycle: ' + e.Message);
  end;

end;

{ TKFEngineIni }

function TKFEngineIni.SetCustomRedirect(URL: String): Boolean;
var
  TND_index, DM_index: Integer;
begin
  try
    TND_index := GetSectionIndex(CHTTPDOWNLOAD, false);
    DM_index := GetItemIndex(CURLREDIRECT, TND_index);

    if (TND_index >= 0) then
    begin
      if (DM_index < 0) then
        Result := AddNewItemAt(CURLREDIRECT + '=' + URL, TND_index, 0)
      else
        Result := ModifyValue(URL, TND_index, DM_index);
    end
    else
    begin
      raise Exception.Create('Failed to find section ' + CHTTPDOWNLOAD);

    end;

  except
    on e: Exception do
      raise Exception.Create('Failed to add custom redirect: ' + e.Message);
  end;
end;

function TKFEngineIni.GetCustomRedirect(): string;
var
  TND_index, DM_index: Integer;
begin
  Result := '';
  try
    TND_index := GetSectionIndex(CHTTPDOWNLOAD, false);
    DM_index := GetItemIndex(CURLREDIRECT, TND_index);

    if (TND_index >= 0) and (DM_index >= 0) then
    begin
      Result := GetValue(TND_index, DM_index);
    end
    else
    begin
      raise Exception.Create
        ('Failed to find redirect values. Option is not set.');

    end;

  except
    on e: Exception do
      raise Exception.Create('Failed to get custom redirect: ' + e.Message);
  end;
end;

function TKFEngineIni.AddWorkshopItem(ID: string): Boolean;
var
  WS_index: Integer;
begin
  try
    try
      if (GetSectionIndex(CWORKSHOPSUBTITLE, false) < 0) then
        AddWorkshopSection();
      WS_index := GetSectionIndex(CWORKSHOPSUBTITLE, false);
      if (WS_index <= 0) then
      begin
        raise Exception.Create
          ('Failed to add workshop section. Item not added.');
        Result := false;
        Exit;
      end;
      // remove old

      if GetWorkshopItemIndex(ID) >= 0 then
      begin
        RemoveWorkshopItem(ID, true);
      end;
      AddNewItemAt(CWORKSHOPSUBITEM + '=' + ID, WS_index,
        Entries[WS_index].items.Count - 1);
      Result := true;
    finally

    end;
  except
    on e: Exception do
      raise Exception.Create('Failed to download: ' + e.Message);

  end;
end;

function TKFEngineIni.RemoveWorkshopItem(ID: string;
  removeAll: Boolean): Boolean;
var
  i, WS_index: Integer;
begin
  Result := false;
  try
    WS_index := GetSectionIndex(CWORKSHOPSUBTITLE, false);
    if (WS_index < 0) then
    begin
      raise Exception.Create('Failed to remove workshop item. Item not found.');
      Exit;
    end;
    i := 0;
    while i < Entries[WS_index].items.Count do
    begin
      if Entries[WS_index].items.Strings[i] = CWORKSHOPSUBITEM + '=' + ID then
      begin
        Entries[WS_index].items.Delete(i);
        Result := true;
        if removeAll = false then
          Exit;
      end
      else
      begin
        i := i + 1;
      end;
    end;

  except
    on e: Exception do
      raise Exception.Create('Failed to remove workshop item: ' + e.Message);
  end;

end;

function TKFEngineIni.GetWorkshopItemIndex(ID: string): Integer;
var
  i, WS_index: Integer;
begin
  Result := -1;
  try
    WS_index := GetSectionIndex(CWORKSHOPSUBTITLE, false);
    if (WS_index >= 0) then
    begin

      for i := 0 to Entries[WS_index].items.Count - 1 do
      begin
        if GetWorkshopSubscribeID(i) = ID then
        begin
          Result := i;
        end;
      end;

      Exit;
    end;

  except
    on e: Exception do
      raise Exception.Create('Failed to get workshop item: ' + e.Message);
  end;
end;

function TKFEngineIni.GetWorkshopSubscribeID(itemIndex: Integer): String;
var
  WS_index: Integer;
  wks_value: string;
  i: Integer;
begin
  Result := '';

  try
    WS_index := GetSectionIndex(CWORKSHOPSUBTITLE, false);
    if (WS_index >= 0) then
    begin
      if itemIndex <= Entries[WS_index].items.Count - 1 then
      begin
        wks_value := GetValue(WS_index, itemIndex);
        for i := 1 to Length(wks_value) do
        begin

          if CharInSet(wks_value[i], ['0' .. '9']) then
          begin
            Result := Result + wks_value[i];
          end
          else
          begin
            Break;
          end;
        end;

      end;
    end;

  except
    on e: Exception do
      raise Exception.Create('Failed to get workshop item: ' + e.Message);
  end;
end;

function TKFEngineIni.GetWorkshopSubscribeCount(): Integer;
var
  WS_index: Integer;
begin
  Result := -1;
  try
    WS_index := GetSectionIndex(CWORKSHOPSUBTITLE, false);
    if (WS_index >= 0) then
    begin

      Result := Entries[WS_index].items.Count;
    end;

  except
    on e: Exception do
      raise Exception.Create('Failed to get workshop item count: ' + e.Message);
  end;
end;

function TKFEngineIni.AddWorkshopRedirect: Boolean;
var
  TND_index, DM_index: Integer;
begin
  try
    TND_index := GetSectionIndex(CTCPNETDRIVER, false);
    DM_index := GetItemIndex(CDOWNLOADMANAGERS, TND_index);

    if (TND_index < 0) or (DM_index < 0) then
      raise Exception.Create('Failed to find ' + CTCPNETDRIVER + '/' +
        CDOWNLOADMANAGERS + ' entry.');

    Result := AddNewItemAt(CDOWNLOADMANAGERS + '=' + CDMWORKSHOP, TND_index,
      DM_index);

  except
    on e: Exception do
      raise Exception.Create('Failed to add workshop redirect: ' + e.Message);

  end;

end;

function TKFEngineIni.RemoveWorkshopRedirect: Boolean;
var
  i, WS_index: Integer;
begin
  Result := false;
  try
    WS_index := GetSectionIndex(CTCPNETDRIVER, false);
    if (WS_index < 0) then
      raise Exception.Create('Failed to remove workshop redirect, ' +
        CTCPNETDRIVER + ' section not found.');
    for i := 0 to Entries[WS_index].items.Count - 1 do
    begin
      if StringReplace(Entries[WS_index].items.Strings[i], ' ', '',
        [rfReplaceAll]) = CDOWNLOADMANAGERS + '=' + CDMWORKSHOP then
      begin
        Entries[WS_index].items.Delete(i);
        Result := true;
        Break;
      end;
    end;
  except
    on e: Exception do
      raise Exception.Create('Failed to remove workshop redirect: ' +
        e.Message);
  end;

end;

function TKFEngineIni.GetWorkshopStatus: Boolean;
var
  i, WS_index: Integer;
begin
  Result := false;
  try
    WS_index := GetSectionIndex(CTCPNETDRIVER, false);
    if (WS_index < 0) then
      Exception.Create('Failed to get workshop redirect, ' + CTCPNETDRIVER +
        ' section not found.');
    for i := 0 to Entries[WS_index].items.Count - 1 do
    begin
      if StringReplace(Entries[WS_index].items.Strings[i], ' ', '',
        [rfReplaceAll]) = CDOWNLOADMANAGERS + '=' + CDMWORKSHOP then
      begin
        Result := true;
        Exit;
      end;
    end;
  except
    on e: Exception do
      raise Exception.Create('Failed to get workshop redirect status: ' +
        e.Message);
  end;

end;

function TKFEngineIni.AddWorkshopSection: Boolean;
var
  WorkshopSection: TKFEntry;
begin
  Result := false;
  try
    try
      WorkshopSection := TKFEntry.Create;
      WorkshopSection.title := '[' + CWORKSHOPSUBTITLE + ']';
      WorkshopSection.items.Add('');
      Result := AddNewSectionAt(WorkshopSection, High(Entries));
    finally

    end;
  except

  end;
end;

constructor TKFEngineIni.Create;
begin

end;

destructor TKFEngineIni.Destroy;
begin

  inherited;
end;

{ TKFWebIni }

constructor TKFWebIni.Create;
begin

end;

destructor TKFWebIni.Destroy;
begin

  inherited;
end;

function TKFWebIni.GetWebPort(): Integer;
var
  sectionIndex, ItemIdex: Integer;
  value: String;
begin
  Result := 0;
  if High(Entries) > 0 then
  begin
    try
      sectionIndex := GetSectionIndex(CCategoryWeb, false);
      ItemIdex := GetItemIndex(CWebPortTag, sectionIndex);

      if (sectionIndex >= 0) and (ItemIdex >= 0) then
      begin
        value := GetValue(sectionIndex, ItemIdex);
        if value <> '' then
          Result := TextToInt(value);
      end
      else
      begin

        raise Exception.Create(CWebPortTag + ' in [' + CCategoryWeb +
          '] not found.');
      end;
    except
      on e: Exception do
        raise Exception.Create('Failed to get web port number. ' + #13 +
          'File: ' + Filename + #13 + e.Message);
    end;
  end
  else
  begin

    raise Exception.Create('KFWeb.ini is not loaded');

  end;
end;

procedure TKFWebIni.SetWebPort(Port: Integer);
var
  sectionIndex, ItemIdex: Integer;
  value: String;
begin
  if High(Entries) > 0 then
  begin
    try
      value := IntToStr(Port);
      sectionIndex := GetSectionIndex(CCategoryWeb, false);
      ItemIdex := GetItemIndex(CWebPortTag, sectionIndex);
      if (sectionIndex < 0) or (ItemIdex < 0) then
      begin
        CreateServerTags;
        sectionIndex := GetSectionIndex(CCategoryWeb, false);
        ItemIdex := GetItemIndex(CWebPortTag, sectionIndex);
      end;
      if (sectionIndex >= 0) and (ItemIdex >= 0) then
      begin
        ModifyValue(value, sectionIndex, ItemIdex);

      end
      else
      begin

        raise Exception.Create(CWebPortTag + ' in ' + CWebStatusTag +
          ' not found.');
      end;
    except
      on e: Exception do
        raise Exception.Create('Failed to get web status. ' + #13 + 'File: ' +
          Filename + #13 + e.Message);
    end;
  end
  else
  begin

    raise Exception.Create('KFWeb.ini is not loaded');

  end;

end;

function TKFWebIni.GetWebStatus(): Boolean;
var
  sectionIndex, ItemIdex: Integer;
  value: String;
begin
  Result := false;
  if High(Entries) > 0 then
  begin
    try
      sectionIndex := GetSectionIndex(CCategoryWeb, false);
      ItemIdex := GetItemIndex(CWebStatusTag, sectionIndex);

      if (sectionIndex >= 0) and (ItemIdex >= 0) then
      begin
        value := GetValue(sectionIndex, ItemIdex);
        if UpperCase(CleanText(value)) = 'TRUE' then
          Result := true;
      end
      else
      begin

        raise Exception.Create(CWebStatusTag + ' in ' + CCategoryWeb +
          ' not found.');
      end;
    except
      on e: Exception do
        raise Exception.Create('Failed to get web status. ' + #13 + 'File: ' +
          Filename + #13 + e.Message);
    end;
  end
  else
  begin

    raise Exception.Create('KFWeb.ini is not loaded');

  end;

end;

procedure TKFWebIni.SetWebStatus(Status: Boolean);
var
  sectionIndex, ItemIdex: Integer;
  value: String;
begin
  if High(Entries) > 0 then
  begin
    try
      if Status then
        value := 'true'
      else
        value := 'false';

      sectionIndex := GetSectionIndex(CCategoryWeb, false);
      ItemIdex := GetItemIndex(CWebStatusTag, sectionIndex);
      if (sectionIndex < 0) or (ItemIdex < 0) then
      begin
        CreateServerTags;
        sectionIndex := GetSectionIndex(CCategoryWeb, false);
        ItemIdex := GetItemIndex(CWebStatusTag, sectionIndex);
      end;
      if (sectionIndex >= 0) and (ItemIdex >= 0) then
      begin

        ModifyValue(value, sectionIndex, ItemIdex);
      end
      else
      begin
        raise Exception.Create(CWebStatusTag + ' in ' + CCategoryWeb +
          ' not found.');

      end;
    except
      on e: Exception do
        raise Exception.Create('Failed to get web status. ' + #13 + 'File: ' +
          Filename + #13 + e.Message);
    end;
  end
  else
  begin

    raise Exception.Create('KFWeb.ini is not loaded');

  end;

end;

procedure TKFWebIni.CreateServerTags;
var
  sectionIndex, statusTagIdx, portTagIdx: Integer;
  newEntry: TKFEntry;
begin
  sectionIndex := GetSectionIndex(CCategoryWeb, false);
  statusTagIdx := GetItemIndex(CWebStatusTag, sectionIndex);
  portTagIdx := GetItemIndex(CWebPortTag, sectionIndex);

  if (sectionIndex < 0) then
  begin
    newEntry := TKFEntry.Create;
    newEntry.title := ('[' + CCategoryWeb + ']');
    AddNewSectionAt(newEntry, High(Entries))
  end;

  if (statusTagIdx < 0) then
  begin

    begin
      sectionIndex := GetSectionIndex(CCategoryWeb, false);
      if sectionIndex >= 0 then
        Entries[sectionIndex].items.Add(CWebStatusTag + '=true');
    end;
  end;

  if (portTagIdx < 0) then
  begin

    begin
      sectionIndex := GetSectionIndex(CCategoryWeb, false);
      if sectionIndex >= 0 then
        Entries[sectionIndex].items.Add(CWebPortTag + '=8080');
    end;
  end;

end;

end.
