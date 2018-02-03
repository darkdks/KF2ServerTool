unit UFuncoes;

interface

uses
  SysUtils, WinProcs, Classes,
  TlHelp32, ShellAPI,
  Forms, IOUtils, Types;

type
  TWordTriple = Array [0 .. 2] of Word;

function WordToBool(Word: String): Boolean;
function FormatByteSize(const bytes: Int64): string;
function BoolToWord(Bool: Boolean): string;
function GetParam(Text, Param: String): String;
function StrEmAspas(Texto: String): string;
function GetParentDirectory(path: string): string;
procedure ExecuteFile(path: string; Arguments: String);
function ExecuteFileAndWait(hWnd: hWnd; filename: string; Parameters: string;
  ShowWindows: Integer): Boolean;
function CreateNewFolderInto(path, FolderName: String): String;
function ExplorerFileOp(Source: TStringList; Destination: String;
  Operation: UINT; Silent: Boolean; Handle: THandle): Boolean;
function CleanText(Text: string): string;
Function TextToInt(Text: String): Int64;
function ProcessExists(ProcessName: string): Boolean;
Function KillProcessByName(ExeName: String): Boolean;
function CleanInt(Text: string): string;
function GetAllFilesSubDirectory(path: string; filter: string): TStringList;
function WorkshopURLtoID(URL: string): string;
function TextForXchar(text: String; numberOfChars: Integer): string;

function ListDir(path: string): TStringList;
implementation

// -------------------------- STRING FUNCTIONS ---------------------------------
function GetAllFilesSubDirectory(path: string; filter: string): TStringList;
var
  Files: TStringDynArray;
  i: Integer;
begin
  Result := TStringList.Create;
  if DirectoryExists(path) then
  begin

    Files := TDirectory.GetFiles(path, filter, TSearchOption.soAllDirectories);
    for i := 0 to High(Files) do
    begin
      Result.Add(Files[i]);

    end;
  end;
end;

function WordToBool(Word: String): Boolean;
begin
  Result := (UpperCase(Trim(Word)) = 'SIM') or (UpperCase(Trim(Word)) = 'YES')
    or (UpperCase(Trim(Word)) = 'S') or (UpperCase(Trim(Word)) = 'Y') or
    (UpperCase(Trim(Word)) = 'true');

end;
function BoolToWord(Bool: Boolean): String;
begin
  if Bool then Result := 'True' else Result := 'False';

end;

function WorkshopURLtoID(URL: string): string;
var
  ItemID: string;
  UrlTemp: string;
  i: Integer;
begin
  if Pos('?id=', URL) > 0 then
  begin
    UrlTemp := Copy(URL, Pos('?id=', URL) + 4, length(URL) - Pos('?id=', URL) + 4);
    for i := 1 to length(UrlTemp) do
    begin
      if CharInSet(UrlTemp[i], ['0' .. '9']) then
      begin
        ItemID := ItemID + UrlTemp[i];
        end else begin
        Break;
      end;

    end;
   Result := ItemID;
  end
  else
  begin
    Result := '';
  end;

end;

function FormatByteSize(const bytes: Int64): string;
const
  B = 1; // byte
  KB = 1024 * B; // kilobyte
  MB = 1024 * KB; // megabyte
  GB = 1024 * MB; // gigabyte
begin
  if bytes > GB then
    Result := FormatFloat('#.## GB', bytes / GB)
  else if bytes > MB then
    Result := FormatFloat('#.## MB', bytes / MB)
  else if bytes > KB then
    Result := FormatFloat('#.## KB', bytes / KB)
  else if bytes > 0 then
    Result := FormatFloat('#.## bytes', bytes)
  else
    Result := '0 bytes';
end;


function GetParam(Text, Param: String): String;
var
  POS1, POS2: Integer;
begin
  POS1 := Pos(Param, Text) + Length(Param) + 2;
  POS2 := Pos('"', Copy(Text, POS1, Length(Text) - POS1)) - 1;
  Result := Copy(Text, POS1, POS2);
end;

function StrEmAspas(Texto: String): string;
begin
  Result := '"' + Texto + '"';
end;

function GetParentDirectory(path: string): string;
begin
  Result := ExpandFileName(path + '\..');
end;


// ------------------------- FILE EXECUTATION -----------------------------------

procedure ExecuteFile(path: string; Arguments: String);
Var
  filename, FilePath: string;
  WState: Integer;
  WHandle: hWnd;
begin

  filename := ExtractFileName(path);
  FilePath := ExtractFilePath(path);
  WHandle := HWND_MESSAGE; // verify
  WState := SW_SHOWMAXIMIZED;
  if FileExists(path) then
  begin
    if Arguments <> '' then
    begin
      ShellExecute(WHandle, PChar('Open'), PChar(filename), nil,
        PChar(FilePath), WState);
    end
    else
    begin
      ShellExecute(WHandle, PChar('Open'), PChar(filename), PChar(Arguments),
        PChar(FilePath), WState);
    end;
  end
  else
  begin

  end;

end;
function TextForXchar(text: String; numberOfChars: Integer): string;
var I: integer;
begin
  Result := '';
  for i := 0 to numberOfChars do begin
   if  i <= Length(Text) then
   Result := Result + text[i] else Result := Result + ' ';
  end;

end;

function ExecuteFileAndWait(hWnd: hWnd; filename: string; Parameters: string;
  ShowWindows: Integer): Boolean;
var
  sei: TShellExecuteInfo;
  ExitCode: DWORD;
begin
  Result := False;
  try
    try
      ZeroMemory(@sei, SizeOf(sei));
      sei.cbSize := SizeOf(TShellExecuteInfo);
      sei.Wnd := hWnd;
      sei.fMask :=
        SEE_MASK_FLAG_DDEWAIT or SEE_MASK_FLAG_NO_UI or
        SEE_MASK_NOCLOSEPROCESS;
      sei.lpVerb := PChar('runas');
      sei.lpFile := PChar(filename); // PAnsiChar;
      if Parameters <> '' then
        sei.lpParameters := PChar(Parameters); // PAnsiChar;
      sei.nShow := ShowWindows; // Integer;

      Application.ProcessMessages;
      if ShellExecuteEx(@sei) then
      begin
        repeat
          Sleep(1000);

          Application.ProcessMessages;
          GetExitCodeProcess(sei.hProcess, ExitCode);
        until (ExitCode <> STILL_ACTIVE) or Application.Terminated;
      end;
    finally
    end;
    Result := True;
  except

  end;
end;


function ListDir(path: string): TStringList;
var
  SR: TSearchRec;
begin
  Result := TStringList.Create;

  if SysUtils.FindFirst(path + '*.*', faAnyFile, SR) = 0 then
  begin
    repeat

      If ((SR.Attr and faDirectory) <> 0) and (SR.Name <> '.')and (SR.Name <> '..') then
      begin
        Result.Add(SR.Name);
      end;

    until FindNext(SR) <> 0;
    SysUtils.FindClose(SR);
  end;

end;

function CreateNewFolderInto(path, FolderName: String): String;

var
  i: Integer;
  FullPath: String;
begin
  Result := '';
  path := IncludeTrailingBackslash(path);
  FolderName := ExcludeTrailingBackslash(FolderName);
  FullPath := IncludeTrailingBackslash(path) + FolderName;

  if DirectoryExists(FullPath) then
  begin
    for i := 1 to 100 do
    begin
      FullPath := path + FolderName + ' (' + IntToStr(i) + ')';
      if DirectoryExists(FullPath) = False then
      begin
        Try
          if CreateDir(PWideChar(FullPath)) then
            Result := FullPath;
        except
          Exit;
        End;
        Exit;
      end;
    end;
  end
  else
  begin
    Try
      if CreateDir(PWideChar(FullPath)) then
        Result := FullPath;
    except
      Exit;
    End;
  end;

end;

function ExplorerFileOp(Source: TStringList; Destination: String;
  Operation: UINT; Silent: Boolean; Handle: THandle): Boolean;
var
  FileOP: TSHFileOpStruct;
  i: Integer;
  StrFrom, StrTo: string;
begin
  ZeroMemory(@FileOP, SizeOf(FileOP));
  StrTo := '';
  StrFrom := '';
  FileOP.Wnd := Handle;
  if Silent then
    FileOP.fFlags := FOF_SILENT + FOF_NOCONFIRMATION;
  for i := 0 to Source.Count - 1 do
    StrFrom := StrFrom + Source[i] + #0;
  StrFrom := StrFrom + #0;
  StrTo := Destination;

  case Operation of
    FO_MOVE:
      begin
        FileOP.wFunc := FO_MOVE;
        FileOP.pFrom := PWideChar(StrFrom);
        FileOP.pTo := PWideChar(StrTo);
      end;
    FO_COPY:
      begin
        FileOP.wFunc := FO_COPY;
        FileOP.pFrom := PWideChar(StrFrom);
        FileOP.pTo := PWideChar(StrTo);
      end;
    FO_DELETE:
      begin
        FileOP.wFunc := FO_DELETE;
        FileOP.pFrom := PWideChar(StrFrom);
      end;
    FO_RENAME:
      begin
        FileOP.wFunc := FO_RENAME;
        FileOP.pFrom := PWideChar(StrFrom);
        FileOP.pTo := PWideChar(StrTo);
      end;
  end;

  Result := (0 = ShFileOperation(FileOP));

end;

function CleanText(Text: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(Text) do
    if  CharInSet(Text[i], ['a' .. 'z', 'A' .. 'Z', '0' .. '9', '-', ' ', '_']) then
      Result := Result + Text[i];
end;

function CleanInt(Text: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(Text) do
    if CharInSet(Text[i], ['0' .. '9']) then
      Result := Result + Text[i];
end;

Function TextToInt(Text: String): Int64;
var
  i: Integer;
  ResultText: String;
begin
  for i := 0 to Length(Text) do
    if CharInSet(Text[i], ['0' .. '9']) then
      ResultText := ResultText + Text[i];
  if ResultText <> '' then
    Result := StrToInt64(ResultText)
  else
    Result := -0;
end;

function ProcessExists(ProcessName: string): Boolean;
var
  ContinueLoop: Bool;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
  LC: Integer;
begin
  LC := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  Result := False;
  while (Integer(ContinueLoop) <> 0) and (LC <= 1000) do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = UpperCase
          (ProcessName)) or (UpperCase(FProcessEntry32.szExeFile) = UpperCase
          (ProcessName))) then
    begin
      Result := True;
      ContinueLoop := False;
    end
    else
    begin
      ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
    end;
    Inc(LC);
  end;
  CloseHandle(FSnapshotHandle);

end;

Function KillProcessByName(ExeName: String): Boolean;
var
  ContinueLoop: Bool;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
  LC: Integer;
begin
  LC := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);

  while (Integer(ContinueLoop) <> 0) and (LC <= 1000) do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = UpperCase
          (ExeName)) or (UpperCase(FProcessEntry32.szExeFile) = UpperCase
          (ExeName))) then
    begin
      TerminateProcess(OpenProcess(PROCESS_TERMINATE, Bool(0),
          FProcessEntry32.th32ProcessID), 0);
    end;
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
    Inc(LC);
  end;
  CloseHandle(FSnapshotHandle);
  Result := ProcessExists(ExeName) = False;

end;

end.
