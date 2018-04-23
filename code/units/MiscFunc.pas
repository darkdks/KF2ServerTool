unit MiscFunc;

interface

uses
{$IFDEF MSWINDOWS}
  WinProcs,
  TlHelp32, ShellAPI,
  JclSysUtils,
  Forms,
{$ELSE}
  LinuxUtils,
{$ENDIF}
  SysUtils, Classes,
  IOUtils, Types;

type
  TWordTriple = Array [0 .. 2] of Word;
{$IFDEF MSWINDOWS}

  TExecuteCmdCallBack = class
  public
    procedure executeCallBack(const Text: string);

  var
    ProcCallBack: TProc<String>;
    executeResult: TStringList;
    constructor Create;
    destructor Destroy; override;
  end;
{$ENDIF}

function WordToBool(Word: String): Boolean;
function FormatByteSize(const bytes: Int64): string;
function BoolToWord(Bool: Boolean): string;
function GetParam(Text, Param: String): String;
function StrEmAspas(Texto: String): string;
function GetParentDirectory(path: string): string;
function CleanText(Text: string): string;
Function TextToInt(Text: String): Int64;
function CleanInt(Text: string): string;
function GetAllFilesSubDirectory(path: string; filter: string): TStringList;
function WorkshopURLtoID(URL: string): string;
function TextForXchar(Text: String; numberOfChars: Integer): string;
function CreateNewFolderInto(path, FolderName: String): String;

// Functions to work with linux compability
function ExecuteFileAndWait(hWnd: Cardinal; filename: string;
  Parameters: string; ShowWindows: Integer): Boolean;
function FileOperation(Source: TStringList; Destination: String;
  Operation: Cardinal): Boolean;
function ProcessExists(ProcessName: string): Boolean;
Function KillProcessByName(ExeName: String): Boolean;
function ListDir(path: string): TStringList;
function ExecuteTerminalProcess(Acmd: String; AParam: string;
  var abortExe: Boolean; Return: TProc<String>): TStringList;

implementation

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

function ListDir(path: string): TStringList;
{ var
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

}
var
  Folders: TStringDynArray;
  i: Integer;
begin
  Result := TStringList.Create;
  if DirectoryExists(path) then
  begin

    Folders := TDirectory.GetDirectories(path);
    for i := 0 to High(Folders) do
    begin
      Result.Add(ExtractFileName(Folders[i]));

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
  if Bool then
    Result := 'True'
  else
    Result := 'False';

end;

function WorkshopURLtoID(URL: string): string;
var
  ItemID: string;
  UrlTemp: string;
  i: Integer;
begin
  if Pos('?id=', URL) > 0 then
  begin
    UrlTemp := Copy(URL, Pos('?id=', URL) + 4, length(URL) - Pos('?id=',
      URL) + 4);
    for i := 1 to length(UrlTemp) do
    begin
      if CharInSet(UrlTemp[i], ['0' .. '9']) then
      begin
        ItemID := ItemID + UrlTemp[i];
      end
      else
      begin
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
  POS1 := Pos(Param, Text) + length(Param) + 2;
  POS2 := Pos('"', Copy(Text, POS1, length(Text) - POS1)) - 1;
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

function TextForXchar(Text: String; numberOfChars: Integer): string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to numberOfChars do
  begin
    if (i <= length(Text)) and (length(Text) > 0) then
      Result := Result + Text[i]
    else
      Result := Result + ' ';
  end;

end;

function CreateNewFolderInto(path, FolderName: String): String;

var
  i: Integer;
  FullPath: String;
begin
  Result := '';
  path := IncludeTrailingPathDelimiter(path);
  FolderName := ExcludeTrailingPathDelimiter(FolderName);
  FullPath := IncludeTrailingPathDelimiter(path) + FolderName;

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

function CleanText(Text: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to length(Text) do
    if CharInSet(Text[i], ['a' .. 'z', 'A' .. 'Z', '0' .. '9', '-', ' ', '_'])
    then
      Result := Result + Text[i];
end;

function CleanInt(Text: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to length(Text) do
    if CharInSet(Text[i], ['0' .. '9']) then
      Result := Result + Text[i];
end;

Function TextToInt(Text: String): Int64;
var
  i: Integer;
  ResultText: String;
begin
  for i := 0 to length(Text) do
    if CharInSet(Text[i], ['0' .. '9']) then
      ResultText := ResultText + Text[i];
  if ResultText <> '' then
    Result := StrToInt64(ResultText)
  else
    Result := -0;
end;

// ------------------------- FILE EXECUTATION -----------------------------------

function ExecuteFileAndWait(hWnd: Cardinal; filename: string;
  Parameters: string; ShowWindows: Integer): Boolean;
{$IFDEF MSWINDOWS}
// Windows API
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
      sei.fMask := SEE_MASK_FLAG_DDEWAIT or SEE_MASK_FLAG_NO_UI or
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

{$ELSE}

// Linux
var
  linuxUt: TLinuxUtils;
begin

  linuxUt := TLinuxUtils.Create;
  try

{$IFDEF DEBUG}
    writeln('DBG: ' + 'Linux execute file started');
{$ENDIF}
    linuxUt.RunCommandLine(filename + ' ' + Parameters, (
      procedure(rStr: String)
      begin
{$IFDEF DEBUG}
        writeln('DBG: ' + rStr)
{$ENDIF}
      end));
  finally
    FreeAndNil(linuxUt);
  end;
  Result := True;
{$IFDEF DEBUG}
  writeln('DBG: ' + 'Linux execute file finshed');
{$ENDIF}
end;
{$ENDIF}

function ExecuteTerminalProcess(Acmd: String; AParam: string;
var abortExe: Boolean; Return: TProc<String>): TStringList;
{$IFDEF MSWINDOWS}
var
  outlineCallBack: TExecuteCmdCallBack;
begin
  Result := TStringList.Create;
  outlineCallBack := TExecuteCmdCallBack.Create;
  outlineCallBack.ProcCallBack := Return;
  outlineCallBack.executeResult := Result;
  try
    JclSysUtils.Execute(Acmd + ' ' + AParam, outlineCallBack.executeCallBack,
      False, @abortExe, ppNormal);

  finally
    FreeAndNil(outlineCallBack);
  end;

end;
{$ELSE}
// Linux
var
  linuxUt: TLinuxUtils;
begin

  linuxUt := TLinuxUtils.Create;
  Result := TStringList.Create;
  try
    linuxUt.RunCommandLine(filename + ' ' + Parameters, (
      procedure(rStr: String)
      begin
       result.add(rStr);
       return(rStr);
       if abortExe then abort;

      end));
  finally
    FreeAndNil(linuxUt);
  end;
end;
{$ENDIF}


{$IFDEF MSWINDOWS}

constructor TExecuteCmdCallBack.Create;
begin

end;

destructor TExecuteCmdCallBack.Destroy;
begin

  inherited;
end;

procedure TExecuteCmdCallBack.executeCallBack(const Text: string);
begin
  if Assigned(ProcCallBack) then
    ProcCallBack(Text);
  if Assigned(executeResult) then
    executeResult.Add(Text);
end;
{$ENDIF}

function FileOperation(Source: TStringList; Destination: String;
Operation: Cardinal): Boolean;
var
  i: Integer;
begin
  Result := False;
  case Operation of
    1: // FO_MOVE
      begin
        for i := 0 to Source.Count - 1 do
        begin

          if FileExists(Source[i]) then
          begin
            IOUtils.TFile.Move(Source[i], Destination);
            Sleep(500);
            Result := FileExists(Destination);
          end
          else
          begin
            if DirectoryExists(Source[i]) then
            begin
              IOUtils.TDirectory.Move(Source[i], Destination);
              Sleep(500);
              Result := DirectoryExists(Destination);
            end;
          end;
        end;
      end;
    2: // FO_COPY:
      begin
        for i := 0 to Source.Count - 1 do
        begin
          if FileExists(Source[i]) then
          begin
            IOUtils.TFile.Copy(Source[i], Destination);
            Sleep(500);
            Result := FileExists(Destination);
          end
          else
          begin
            if DirectoryExists(Source[i]) then
            begin
              IOUtils.TDirectory.Copy(Source[i], Destination);
              Sleep(500);
              Result := DirectoryExists(Destination);
            end;
          end;
        end;

      end;
    3: // FO_DELETE:
      begin

        for i := 0 to Source.Count - 1 do
        begin
          if FileExists(Source[i]) then
          begin
            Result := DeleteFile(Source[i]);
          end
          else
          begin
            if DirectoryExists(Source[i]) then
            begin
              TDirectory.Delete(Source[i], True);
              Sleep(100);
              Result := DirectoryExists(Source[i]) = False;
            end;
          end;
        end;

      end;
    4: // FO_RENAME:
      begin
        for i := 0 to Source.Count - 1 do
        begin
          Result := RenameFile(Source[i], Destination);

        end;
      end
  else
    raise Exception.Create('No implemented operation');
  end;

end;
{ function ExplorerFileOp(Source: TStringList; Destination: String;
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

  end; }

function ProcessExists(ProcessName: string): Boolean;
{$IFDEF MSWINDOWS}
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
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile))
      = UpperCase(ProcessName)) or (UpperCase(FProcessEntry32.szExeFile)
      = UpperCase(ProcessName))) then
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
{$ELSE}

var
  processText: TStringList;
  linuxUt: TLinuxUtils;
begin

  processText := TStringList.Create;
  linuxUt := TLinuxUtils.Create;
  try
    linuxUt.RunCommandLine('ps -aux | less', (
      procedure(rStr: String)
      begin
        processText.Add(rStr);
      end));

  finally
    FreeAndNil(linuxUt);
  end;
  Result := Pos(ProcessName, processText.Text) > 0;
end;

{$ENDIF}

Function KillProcessByName(ExeName: String): Boolean;
{$IFDEF MSWINDOWS}
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
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile))
      = UpperCase(ExeName)) or (UpperCase(FProcessEntry32.szExeFile)
      = UpperCase(ExeName))) then
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
{$ELSE}

begin
  ExecuteFileAndWait(0, 'pkill', ExeName, 0);
  // options: killall /v exename ,kill $(pgrep irssi), kill `ps -ef | grep irssi | grep -v grep | awk �{print $2}�`
  Result := True;
end;
{$ENDIF}
{ TExecuteCmdCallBack }

end.