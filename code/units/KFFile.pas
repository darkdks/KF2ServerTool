unit KFFile;

interface

uses
  Classes,
  SysUtils, MiscFunc;

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
  //  function RemoveItemAt(EntryIndex, itemIndex: Integer): Boolean;
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
    Entrys: array of TKFEntry;
    constructor Create;
    destructor Destroy; override;
    function LoadFile(path: String): Boolean;
    function SaveFile(path: String): Boolean;

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

  public
    constructor Create;
    destructor Destroy; override;
    function GetMapNameAt(index: Integer): string;
    function GetAdminPass(): String;
    function SetAdminPass(password: String): Boolean;
    function AddMapEntry(name: String): Boolean;
    function RemoveMapEntry(name: String; removeAll: Boolean): Boolean;
    function AddMapCycle(name: String): Boolean;
    function RemoveMapCycle(name: String; removeAll: Boolean): Boolean;
    function GMCTextToStrings(GMCText: string): TStringList;
    function GMCStringsToText(GMCStrings: TStringList): string;
    function GetMapEntryIndex(name: String): Integer;
    function GetMapCycleIndex(name: String): Integer;
    function GetMapCycleList: TStringList;
    function GetMapEntrysList: TStringList;

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
    function GetWorkshopSubcribeCount: Integer;
    function GetWorkshopSubcribeID(itemIndex: Integer): String;

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
  SetLength(Entrys, 0);

end;

destructor TKFConfigFile.Destroy;
var
  i: Integer;
begin
  for i := 0 to Length(Entrys) - 1 do
    FreeAndNil(Entrys[i]);
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
      for i := 0 to High(Entrys) do
        Entrys[i].Free;
      SetLength(Entrys, 0);
      currentEntry := 0;
      configFile.LoadFromFile(path);
      if configFile.Count > 1 then
      begin

        for i := 0 to configFile.Count - 1 do
        begin

          if IsCategory(configFile.Strings[i]) then
          begin
            SetLength(Entrys, Length(Entrys) + 1);
            currentEntry := High(Entrys);
            Entrys[currentEntry] := TKFEntry.Create;
            Entrys[currentEntry].title := configFile.Strings[i];
          end
          else
          begin
            Entrys[currentEntry].items.Add(configFile.Strings[i]);
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
      raise Exception.Create('Falied to load ' + path + ': ' + e.Message);
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

      if High(Entrys) >= 1 then
      begin

        for i := 0 to High(Entrys) do
        begin
          configFile.Add(Entrys[i].title);
          configFile.AddStrings(Entrys[i].items);
        end;

        configFile.SaveToFile(path);
        Result := true;
      end;

    finally
      configFile.Free;
    end;
  except
    on e: Exception do
      raise Exception.Create('Falied to save ' + path + ': ' + e.Message);
  end;
end;

function TKFConfigFile.GetCategoryIndex(category: String;
  getLast: Boolean): Integer;
var
  i: Integer;
  currentCategory: string;
begin
  Result := -1;
  for i := 0 to High(Entrys) do
  begin
    currentCategory := GetCategoryName(Entrys[i].title);
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
  if (index > High(Entrys)) or (index < 0) then
    Exit;

  for i := 0 to Entrys[index].items.Count - 1 do
  begin
    line := Entrys[index].items[i];
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
  for i := 0 to High(Entrys) do
  begin
    // ShowMessage(Copy(Entrys[i].title, 2, Length(Entrys[i].title) - 2));
    if Copy(Entrys[i].title, 2, Length(Entrys[i].title) - 2) = name then
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
  if Pos('=', Entrys[EntryIndex].items[ItemIdex]) < 0 then
    Exit;
  try
    try
      line := Entrys[EntryIndex].items[ItemIdex];

      param1 := Copy(line, 0, Pos('=', line) - 1);
      param2 := newValue;
      Entrys[EntryIndex].items[ItemIdex] := param1 + '=' + param2;
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
  if Pos('=', Entrys[EntryIndex].items[ItemIdex]) < 0 then
    Exit;
  try
    try
      line := Entrys[EntryIndex].items[ItemIdex];
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
  EntrysCopy: array of TKFEntry;
begin

  try
    try
      // Coping entrys
      SetLength(EntrysCopy, Length(Entrys));
      for i := 0 to High(Entrys) do
      begin
        EntrysCopy[i] := TKFEntry.Create;
        EntrysCopy[i].title := Entrys[i].title;
        EntrysCopy[i].items.text := Entrys[i].items.text;
      end;
      // Adding new entry
      SetLength(Entrys, Length(Entrys) + 1);
      Entrys[High(Entrys)] := TKFEntry.Create;
      Entrys[index].title := entry.title;
      Entrys[index].items.text := entry.items.text;
      // Remounting Entrys
      for i := index + 1 to High(Entrys) do
      begin
        Entrys[i].title := EntrysCopy[i - 1].title;
        Entrys[i].items.text := EntrysCopy[i - 1].items.text;
      end;
      Result := true;
    finally
      for i := 0 to High(EntrysCopy) do
        EntrysCopy[i].Free;
      SetLength(EntrysCopy, 0);
    end;
  except
    on e: Exception do
    begin
      raise Exception.Create('Falied add map entry: ' + e.Message);
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
    // Coping entrys
    StrListCopy := TStringList.Create;
    try

      for i := 0 to Entrys[EntryIndex].items.Count - 1 do
      begin
        StrListCopy.Add(Entrys[EntryIndex].items[i]);
      end;

      Entrys[EntryIndex].items.Clear;

      for i := 0 to StrListCopy.Count - 1 do
      begin
        if i = at then
        begin
          Entrys[EntryIndex].items.Add(NewItem);
          Result := true;
        end;
        Entrys[EntryIndex].items.Add(StrListCopy.Strings[i]);

      end;

    finally
      StrListCopy.Free;
    end;
  except
    on e: Exception do
      raise Exception.Create('Falied to add new item: ' + e.Message);
  end;
end;

function TKFConfigFile.RemoveSectionAt(index: Integer): Boolean;
var
  i: Integer;
  EntrysCopy: array of TKFEntry;
begin

  try
    try
      // Coping entrys
      SetLength(EntrysCopy, Length(Entrys));
      for i := 0 to High(Entrys) do
      begin
        EntrysCopy[i] := TKFEntry.Create;
        EntrysCopy[i].title := Entrys[i].title;
        EntrysCopy[i].items.text := Entrys[i].items.text;
      end;
      // removing one item
      Entrys[High(Entrys)].Free;
      SetLength(Entrys, Length(Entrys) - 1);
      // Remounting Entrys
      for i := 0 to High(EntrysCopy) do
      begin
        if i < index then
        begin
          Entrys[i].title := EntrysCopy[i].title;
          Entrys[i].items.text := EntrysCopy[i].items.text;
        end
        else
        begin
          if i > index then
          begin
            Entrys[i - 1].title := EntrysCopy[i].title;
            Entrys[i - 1].items.text := EntrysCopy[i].items.text;
          end;
        end;
      end;
      Result := true;
    finally
      for i := 0 to High(EntrysCopy) do
        EntrysCopy[i].Free;
      SetLength(EntrysCopy, 0);
    end;
  except
    on e: Exception do
    begin
      raise Exception.Create('Falied to remove item: ' + e.Message);

    end;
  end;
end;
 {
function TKFConfigFile.RemoveItemAt(EntryIndex, itemIndex: Integer): Boolean;
begin
  Result := true;
  try
    if (EntryIndex > High(Entrys)) or
      (itemIndex > Entrys[EntryIndex].items.Count - 1) then
      raise Exception.Create('Invalid entry index or item index');

    Entrys[EntryIndex].items.Delete(itemIndex);

  except
    on e: Exception do
    begin
      raise Exception.Create('Falied to remove item: ' + e.Message);
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
  Titleline := Entrys[index].title;
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
  GMCStrings.Sort;
  Result := '(Maps=(';
  for i := 0 to GMCStrings.Count - 1 do
  begin
    Result := Result + '"' + GMCStrings.Strings[i] + '"';
    if i < GMCStrings.Count - 1 then
      Result := Result + ','
  end;
  Result := Result + '))';
end;

function TKFGameIni.RemoveMapCycle(name: String; removeAll: Boolean): Boolean;
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
        raise Exception.Create('Falied to remove. GameMapCycles not found.');
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
      Result := true;
    finally
      FreeAndNil(mapList);
    end;
  except
    Result := false;
  end;
end;

function TKFGameIni.AddMapCycle(name: String): Boolean;
var
  newMapCycle, oldMapCycle: string;
  GI_index, GMC_index: Integer;
  mapList: TStringList;
begin

  try

    GI_index := GetSectionIndex(CGAMEINFO, false);
    GMC_index := GetItemIndex(CGAMEMAPCYCLES, GI_index);

    if (GI_index < 0) or (GMC_index < 0) then
    begin
      raise Exception.Create('Falied to add. GameMapCycles not found.');
      Exit;
    end;
    if Pos('"' + name + '"', GetValue(GI_index, GMC_index)) > 0 then
    begin
      RemoveMapCycle(name, true);
    end;
    oldMapCycle := GetValue(GI_index, GMC_index);
    try
      mapList := GMCTextToStrings(oldMapCycle);
      mapList.Add(name);
      newMapCycle := GMCStringsToText(mapList);
      ModifyValue(newMapCycle, GI_index, GMC_index);
      Result := true;
    finally
      FreeAndNil(mapList);
    end;
  except
    on e: Exception do
    begin
      raise Exception.Create('Falied to edit: ' + e.Message);

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
          ('Falied get map cycle. GameMapCycles not found.');
        Exit;
      end;
      mapCycle := GetValue(GI_index, GMC_index);
      Result := GMCTextToStrings(mapCycle);
      Result.Sort;

    finally

    end;
  except
    on e: Exception do
      raise Exception.Create('Falied to get map cycle: ' + e.Message);
  end;

end;

function TKFGameIni.RemoveMapEntry(name: String; removeAll: Boolean): Boolean;
var
  i: Integer;
begin
  Result := false;
  i := 0;
  while i <= High(Entrys) do
  begin
    if (GetCategoryName(Entrys[i].title) = CMAPTYPE) and (GetMapNameAt(i) = name)
    then
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
      raise Exception.Create('Falied to find ' + CENGINEACESSCONTROL + ' / ' +
        CADMINPASSWORD + ' fields.');

    end;

  except
    on e: Exception do
      raise Exception.Create('Error setting admin password: ' + e.Message);
  end;

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

function TKFGameIni.GetMapEntrysList: TStringList;
var
  i: Integer;
  mapName: String;
begin
  Result := TStringList.Create;
  try
    for i := 0 to High(Entrys) do
    begin
    mapName := GetMapNameAt(i);
      if mapName <> '' then begin
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
      raise Exception.Create('Falied to find ' + CENGINEACESSCONTROL + ' / ' +
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
    mapList := GetMapCycleList;
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
      raise Exception.Create('Falied to get gameMapCycle: ' + e.Message);
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
      raise Exception.Create('Falied to find section ' + CHTTPDOWNLOAD);

    end;

  except
    on e: Exception do
      raise Exception.Create('Falied add custom redirect: ' + e.Message);
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
        ('Falied to find redirect values. Option is not set.');

    end;

  except
    on e: Exception do
      raise Exception.Create('Falied get custom redirect: ' + e.Message);
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
          ('Falied to add workshop section. Item not added.');
        Result := false;
        Exit;
      end;
      // remove old

      if GetWorkshopItemIndex(ID) >= 0 then
      begin
        RemoveWorkshopItem(ID, true);
      end;
      AddNewItemAt(CWORKSHOPSUBITEM + '=' + ID, WS_index,
        Entrys[WS_index].items.Count - 1);
      Result := true;
    finally

    end;
  except
    on e: Exception do
      raise Exception.Create('Falied to download: ' + e.Message);

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
      raise Exception.Create('Falied to remove workshop item. Item not found.');
      Exit;
    end;
    i := 0;
    while i < Entrys[WS_index].items.Count do
    begin
      if Entrys[WS_index].items.Strings[i] = CWORKSHOPSUBITEM + '=' + ID then
      begin
        Entrys[WS_index].items.Delete(i);
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
      raise Exception.Create('Falied to remove workshop item: ' + e.Message);
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

      for i := 0 to Entrys[WS_index].items.Count - 1 do
      begin
        if GetWorkshopSubcribeID(i) = ID then
        begin
          Result := i;
        end;
      end;

      Exit;
    end;

  except
    on e: Exception do
      raise Exception.Create('Falied to get workshop item: ' + e.Message);
  end;
end;

function TKFEngineIni.GetWorkshopSubcribeID(itemIndex: Integer): String;
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
      if itemIndex <= Entrys[WS_index].items.Count - 1 then
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
      raise Exception.Create('Falied to get workshop item: ' + e.Message);
  end;
end;

function TKFEngineIni.GetWorkshopSubcribeCount(): Integer;
var
  WS_index: Integer;
begin
  Result := -1;
  try
    WS_index := GetSectionIndex(CWORKSHOPSUBTITLE, false);
    if (WS_index >= 0) then
    begin

      Result := Entrys[WS_index].items.Count;
    end;

  except
    on e: Exception do
      raise Exception.Create('Falied to get workshop item count: ' + e.Message);
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
      raise Exception.Create('Falied to find ' + CTCPNETDRIVER + '/' +
        CDOWNLOADMANAGERS + ' entry.');

    Result := AddNewItemAt(CDOWNLOADMANAGERS + '=' + CDMWORKSHOP, TND_index,
      DM_index);

  except
    on e: Exception do
      raise Exception.Create('Falied add workshop redirect: ' + e.Message);

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
      raise Exception.Create('Falied to remove workshop redirect, ' +
        CTCPNETDRIVER + ' section not found.');
    for i := 0 to Entrys[WS_index].items.Count - 1 do
    begin
      if StringReplace(Entrys[WS_index].items.Strings[i], ' ', '',
        [rfReplaceAll]) = CDOWNLOADMANAGERS + '=' + CDMWORKSHOP then
      begin
        Entrys[WS_index].items.Delete(i);
        Result := true;
        Break;
      end;
    end;
  except
    on e: Exception do
      raise Exception.Create('Falied to remove workshop redirect: ' +
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
      Exception.Create('Falied get workshop redirect, ' + CTCPNETDRIVER +
        ' section not found.');
    for i := 0 to Entrys[WS_index].items.Count - 1 do
    begin
      if StringReplace(Entrys[WS_index].items.Strings[i], ' ', '',
        [rfReplaceAll]) = CDOWNLOADMANAGERS + '=' + CDMWORKSHOP then
      begin
        Result := true;
        Exit;
      end;
    end;
  except
    on e: Exception do
      raise Exception.Create('Falied get workshop redirect status: ' +
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
      Result := AddNewSectionAt(WorkshopSection, High(Entrys));
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
  if High(Entrys) > 0 then
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
        raise Exception.Create('Falied to get web port number. ' + #13 +
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
  if High(Entrys) > 0 then
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
        raise Exception.Create('Falied get web status. ' + #13 + 'File: ' +
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
  if High(Entrys) > 0 then
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
        raise Exception.Create('Falied to get web status. ' + #13 + 'File: ' +
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
  if High(Entrys) > 0 then
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
        raise Exception.Create('Falied get web status. ' + #13 + 'File: ' +
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
    AddNewSectionAt(newEntry, High(Entrys))
  end;

  if (statusTagIdx < 0) then
  begin

    begin
      sectionIndex := GetSectionIndex(CCategoryWeb, false);
      if sectionIndex >= 0 then
        Entrys[sectionIndex].items.Add(CWebStatusTag + '=true');
    end;
  end;

  if (portTagIdx < 0) then
  begin

    begin
      sectionIndex := GetSectionIndex(CCategoryWeb, false);
      if sectionIndex >= 0 then
        Entrys[sectionIndex].items.Add(CWebPortTag + '=8080');
    end;
  end;

end;

end.
