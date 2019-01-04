unit toolLanguage;

interface

uses
  Classes, SysUtils, System.StrUtils, MiscFunc;

type

  TKFCustomLanguage = class(TObject)
  public
    name: String;
    initial: string;
    tlsource: TStringList;
    constructor Create();
    destructor Destroy; override;
  end;

  TKFLanguages = array of TKFCustomLanguage;

  TKFTranslation = class(TObject)

  private
  var
    currentLanguage: TKFCustomLanguage;
    srcFile: TStringList;
    missingStrings: TStringList;
    workingPath: string;
    appLaguages: TKFLanguages;
    function indexOfLanguageByInitial(initial: String): Integer;
    function indexOfLanguageByName(name: String): Integer;

  const
    MISSINGSTRINGSFILENAME = 'KF2ServerTool_MissingLocalization.txt';
  public
    procedure setLanguage(initial: String);
    function getCurrentLanguage(): TKFCustomLanguage;
    function getLanguageByInitial(initial: string): TKFCustomLanguage;
    function getLanguageByName(name: string): TKFCustomLanguage;
    function tlStr(text: String): string;
    function getLanguages(): TKFLanguages;
    procedure loadSource(filename: String);
    constructor Create(workingDir: String);
    destructor Destroy; override;
  end;

function KFL_IsHeader(src: String): Boolean;
procedure KFL_GetHeaderSetting(src: String; var text1: string;
  var text2: string);

implementation

{ TKFTranslation }

constructor TKFTranslation.Create(workingDir: String);
begin
  srcFile := TStringList.Create;
  workingPath := IncludeTrailingPathDelimiter(workingDir);
  missingStrings := TStringList.Create;
end;

destructor TKFTranslation.Destroy;
var
  i: Integer;
begin
  FreeAndNil(srcFile);
  FreeAndNil(missingStrings);
  for i := 0 to High(appLaguages) do
    if Assigned(appLaguages[i]) then
    begin
      FreeAndNil(appLaguages[i]);
    end;
  SetLength(appLaguages, 0);

  inherited;
end;

function TKFTranslation.getCurrentLanguage: TKFCustomLanguage;
begin
  Result := currentLanguage;
end;

function TKFTranslation.getLanguageByInitial(initial: string)
  : TKFCustomLanguage;
var
  lgIndex: Integer;
begin
  lgIndex := indexOfLanguageByInitial(initial);
  if lgIndex <> -1 then
    Result := appLaguages[lgIndex]
  else
    raise Exception.Create('Failed to set language. Language with initial "' +
      initial + '" not found.');
end;

function TKFTranslation.getLanguageByName(name: string): TKFCustomLanguage;
var
  lgIndex: Integer;
begin
  lgIndex := indexOfLanguageByName(name);
  if lgIndex <> -1 then
    Result := appLaguages[lgIndex]
  else
    raise Exception.Create('Failed to get language. Language with name "' + name
      + '" not found.');
end;

function TKFTranslation.getLanguages: TKFLanguages;
begin
  Result := appLaguages;
end;

function TKFTranslation.indexOfLanguageByName(name: String): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to High(appLaguages) do
    if appLaguages[i].name = name then
      Result := i;
end;

function TKFTranslation.indexOfLanguageByInitial(initial: String): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to High(appLaguages) do
    if appLaguages[i].initial = initial then
      Result := i;
end;

procedure TKFTranslation.loadSource(filename: String);
var
  i, y: Integer;
  aLanguage: TKFCustomLanguage;
  crLine: String;
  LName, LInitial, tlLine: String;
begin
  if FileExists(workingPath + filename) = false then
    raise Exception.Create('Failed to open language file ' + filename + '.' +
      #10#13 + 'Download the files again and put the ' + filename +
      ' in the same folder of the tool executable');

  srcFile.LoadFromFile(workingPath + filename);
  if srcFile.Count > 0 then
  begin
    i := 0;
    while i <= srcFile.Count - 1 do
    begin
      crLine := srcFile.Strings[i];

      if KFL_IsHeader(crLine) then
      begin
        LName := '';
        LInitial := '';
        KFL_GetHeaderSetting(crLine, LName, LInitial);
        if (LName <> '') and (LInitial <> '') then
        begin
          aLanguage := TKFCustomLanguage.Create;
          aLanguage.name := LName;
          aLanguage.initial := LInitial;
          SetLength(appLaguages, length(appLaguages) + 1);
          for y := i + 1 to srcFile.Count - 1 do
          begin
            tlLine := srcFile.Strings[y];
            if (tlLine <> '') and (length(tlLine) > 1) and (tlLine[1] <> '#')
            then
            begin
              aLanguage.tlsource.Add(tlLine);
            end;
            if KFL_IsHeader(srcFile.Strings[y]) then
            begin
              i := y - 1;
              break
            end;
          end;
          appLaguages[High(appLaguages)] := aLanguage;
        end;
      end;
      i := i + 1;
    end
  end
  else
  begin
    raise Exception.Create('Failed to open localization file '+ filename + '.'+
      #10#13 + 'Download the files again and put the ' + filename +
      ' in the same folder of the tool executable');
  end;
end;

procedure TKFTranslation.setLanguage(initial: String);
var
  lgIndex: Integer;

begin
  lgIndex := indexOfLanguageByInitial(initial);
  if lgIndex <> -1 then
    currentLanguage := appLaguages[lgIndex]
  else
    raise Exception.Create('Failed to set language. Language with initial "' +
      initial + '" not found.');
end;

function TKFTranslation.tlStr(text: String): string;
var
  srcKey: String;
begin

  if text = '' then
    Exit;
  try
    srcKey := StringReplace(StringReplace(text, #10, '', [rfReplaceAll]), #13,
      '\n', [rfReplaceAll]);
    srcKey := '"' + srcKey + '"';
        if Assigned(currentLanguage) then

    Result := currentLanguage.tlsource.Values[srcKey];
    Result := StringReplace(Result, '"', '', [rfReplaceAll]);
    Result := StringReplace(Result, '\n', #10 + #13, [rfReplaceAll]);
    if Result = '' then
    begin
      Result := StringReplace(text, '\n', #10 + #13, [rfReplaceAll]);
      // Generate missing string in file
      if missingStrings.IndexOfName(srcKey) = -1 then
        missingStrings.AddPair(srcKey, srcKey);
      missingStrings.SaveToFile(workingPath + MISSINGSTRINGSFILENAME);
    end;
  except
    on E: Exception do
      raise Exception.Create('Failed to translate string');
  end;
end;

procedure KFL_GetHeaderSetting(src: String; var text1: string;
  var text2: string);
begin
  try
    if KFL_IsHeader(src) then
    begin
      text1 := Copy(src, PosOfOccurrence('"', src, 1) + 1,
        PosOfOccurrence('"', src, 2) - PosOfOccurrence('"', src, 1) - 1);
      text2 := Copy(src, PosOfOccurrence('"', src, 3) + 1,
        PosOfOccurrence('"', src, 4) - PosOfOccurrence('"', src, 3) - 1);
    end;
  except
    text1 := '';
    text2 := '';
  end;

end;

function KFL_IsHeader(src: String): Boolean;
begin
  if High(src) >= 1 then
    Result := (src[1] = '[') and (src[length(src)] = ']') and
      (OccurrencesOfChar(src, '"') = 4)
  else
    Result := false;
end;

{ TKFCustomLanguage }

constructor TKFCustomLanguage.Create;
begin
  tlsource := TStringList.Create;
end;

destructor TKFCustomLanguage.Destroy;
begin
  if Assigned(tlsource) then
    FreeAndNil(tlsource);
  inherited;
end;

end.
