unit MiscFunc;

interface

uses
{$IFDEF MSWINDOWS}
  WinProcs,
  TlHelp32,
  ShellAPI,
  JclSysUtils,
  Forms,
  Graphics,
{$ELSE}
  LinuxUtils,
  Posix.Unistd,
  Posix.Stdio,
{$ENDIF MSWINDOWS}
  SysUtils,
  Classes,
  IOUtils,
  Types;

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

function ExecuteFile(hWnd: Cardinal; filename: string; Parameters: string;
  ShowWindows: Integer): Boolean;
procedure ResizeBitmap(Bitmap: TBitmap; const NewWidth, NewHeight: Integer);
{$ENDIF MSWINDOWS}
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
function GetAllFilesInsideDirectory(path: string; filter: string): TStringList;
function WorkshopURLtoID(URL: string): string;
function TextForXchar(Text: String; numberOfChars: Integer): string;
function CreateNewFolderInto(path, FolderName: String): String;
function ExecuteFileAndWait(hWnd: Cardinal; filename: string;
  Parameters: string; ShowWindows: Integer): Boolean;
function FileOperation(Source: TStringList; Destination: String;
  Operation: Cardinal): Boolean;
function ProcessExists(ProcessName: string): Boolean;
Function KillProcessByName(ExeName: String): Boolean;
function ListDir(path: string): TStringList;
function OccurrencesOfChar(const ContentString: string;
  const CharToCount: char): Integer;
function ExecuteTerminalProcess(Acmd: String; AParam: string;
  var abortExe: Boolean; Return: TProc<String>): TStringList;
function PosOfOccurrence(p_SubStr, p_Source: string;
  p_NthOccurrence: Integer): Integer;

implementation

function OccurrencesOfChar(const ContentString: string;
  const CharToCount: char): Integer;
var
  C: char;
begin
  result := 0;
  for C in ContentString do
    if C = CharToCount then
      Inc(result);
end;

function GetAllFilesSubDirectory(path: string; filter: string): TStringList;
var
  Files: TStringDynArray;
  i: Integer;
begin
  result := TStringList.Create;
  if DirectoryExists(path) then
  begin

    Files := TDirectory.GetFiles(path, filter, TSearchOption.soAllDirectories);
    for i := 0 to High(Files) do
    begin
      result.Add(Files[i]);

    end;
  end;
end;

function GetAllFilesInsideDirectory(path: string; filter: string): TStringList;
var
  Files: TStringDynArray;
  i: Integer;
begin
  result := TStringList.Create;
  if DirectoryExists(path) then
  begin

    Files := TDirectory.GetFiles(path, filter,
      TSearchOption.soTopDirectoryOnly);
    for i := 0 to High(Files) do
    begin
      result.Add(Files[i]);

    end;
  end;
end;

{$IFDEF MSWINDOWS}

procedure ResizeBitmap(Bitmap: TBitmap; const NewWidth, NewHeight: Integer);
var
  buffer: TBitmap;
begin
  buffer := TBitmap.Create;
  try
    buffer.SetSize(NewWidth, NewHeight);
    buffer.Canvas.StretchDraw(Rect(0, 0, NewWidth, NewHeight), Bitmap);
    Bitmap.SetSize(NewWidth, NewHeight);
    Bitmap.Canvas.Draw(0, 0, buffer);
  finally
    buffer.Free;
  end;
end;
{$ENDIF MSWINDOWS}

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
  result := TStringList.Create;
  if DirectoryExists(path) then
  begin

    Folders := TDirectory.GetDirectories(path);
    for i := 0 to High(Folders) do
    begin
      result.Add(ExtractFileName(Folders[i]));

    end;
  end;

end;

function WordToBool(Word: String): Boolean;
begin
  result := (UpperCase(Trim(Word)) = 'SIM') or (UpperCase(Trim(Word)) = 'YES')
    or (UpperCase(Trim(Word)) = 'S') or (UpperCase(Trim(Word)) = 'Y') or
    (UpperCase(Trim(Word)) = 'true');

end;

function BoolToWord(Bool: Boolean): String;
begin
  if Bool then
    result := 'True'
  else
    result := 'False';

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
    result := ItemID;
  end
  else
  begin
    result := '';
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
    result := FormatFloat('#.## GB', bytes / GB)
  else if bytes > MB then
    result := FormatFloat('#.## MB', bytes / MB)
  else if bytes > KB then
    result := FormatFloat('#.## KB', bytes / KB)
  else if bytes > 0 then
    result := FormatFloat('#.## bytes', bytes)
  else
    result := '0 bytes';
end;

function GetParam(Text, Param: String): String;
var
  POS1, POS2: Integer;
begin
  POS1 := Pos(Param, Text) + length(Param) + 2;
  POS2 := Pos('"', Copy(Text, POS1, length(Text) - POS1)) - 1;
  result := Copy(Text, POS1, POS2);
end;

function StrEmAspas(Texto: String): string;
begin
  result := '"' + Texto + '"';
end;

function GetParentDirectory(path: string): string;
begin
  result := ExpandFileName(path + '\..');
end;

function TextForXchar(Text: String; numberOfChars: Integer): string;
var
  i: Integer;
begin
  result := '';
  for i := 0 to numberOfChars do
  begin
    if (i <= length(Text)) and (length(Text) > 0) then
      result := result + Text[i]
    else
      result := result + ' ';
  end;

end;

function CreateNewFolderInto(path, FolderName: String): String;

var
  i: Integer;
  FullPath: String;
begin
  result := '';
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
            result := FullPath;
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
        result := FullPath;
    except
      Exit;
    End;
  end;

end;

function CleanText(Text: string): string;
var
  i: Integer;
begin
  result := '';
  for i := 1 to length(Text) do
    if CharInSet(Text[i], ['a' .. 'z', 'A' .. 'Z', '0' .. '9', '-', ' ', '_'])
    then
      result := result + Text[i];
end;

function CleanInt(Text: string): string;
var
  i: Integer;
begin
  result := '';
  for i := 1 to length(Text) do

    if CharInSet(Text[i], ['0' .. '9']) then
      result := result + Text[i];
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
    result := StrToInt64(ResultText)
  else
    result := -0;
end;

// ------------------------- FILE EXECUTION -----------------------------------
function ExecuteFileAndWait(hWnd: Cardinal; filename: string;
  Parameters: string; ShowWindows: Integer): Boolean;

{$IFDEF MSWINDOWS}
// Windows API
var
  sei: TShellExecuteInfo;
  ExitCode: DWORD;
begin
  result := False;
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
    result := True;
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
{$ENDIF DEBUG}
    linuxUt.RunCommandLine(filename + ' ' + Parameters, (
      procedure(rStr: String)
      begin
{$IFDEF DEBUG}
        writeln('DBG: ' + rStr)
{$ENDIF DEBUG}
      end));
  finally
    FreeAndNil(linuxUt);
  end;
  result := True;

{$IFDEF DEBUG}
  writeln('DBG: ' + 'Linux execute file finshed');
{$ENDIF DEBUG}
end;

{$ENDIF MSWINDOWS}
{$IFDEF MSWINDOWS}

function ExecuteFile(hWnd: Cardinal; filename: string; Parameters: string;
ShowWindows: Integer): Boolean;
begin
  try
    result := ShellExecute(hWnd, 'runas', PWideChar(filename),
      PWideChar(Parameters), nil, ShowWindows) > 32;
  except
    on E: Exception do
    begin
      raise Exception.Create('Falied to execute file ' + filename + ' ' +
        E.Message);
    end;
  end;
end;
{$ENDIF MSWINDOWS}

function ExecuteTerminalProcess(Acmd: String; AParam: string;
var abortExe: Boolean; Return: TProc<String>): TStringList;

{$IFDEF MSWINDOWS}
// var
// outlineCallBack: TExecuteCmdCallBack;
begin
  result := TStringList.Create;

  if ExecuteFileAndWait(0, Acmd, AParam, 0) then
    result.Add('True by ExecutefileAndWait')
  else
    result.Add('False by ExecutefileAndWait');
  {

    outlineCallBack := TExecuteCmdCallBack.Create;
    outlineCallBack.ProcCallBack := Return;
    outlineCallBack.executeResult := Result;
    try
    JclSysUtils.Execute(Acmd + ' ' + AParam, outlineCallBack.executeCallBack,
    False, @abortExe, ppNormal);

    finally
    FreeAndNil(outlineCallBack);
    end;

  }
end;
{$ELSE}

// Linux
var
  linuxUt: TLinuxUtils;
  cmdResult: TStringList;
begin

  linuxUt := TLinuxUtils.Create;
  result := TStringList.Create;
  cmdResult := result;
  try
    linuxUt.RunCommandLine(Acmd + ' ' + AParam, (
      procedure(rStr: String)
      begin
        try
          if Assigned(Return) then
            Return(rStr);
          cmdResult.Add(rStr);

        except
          writeln('Exception calling line return');
        end;
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
  result := False;
  case Operation of
    1: // FO_MOVE
      begin
        for i := 0 to Source.Count - 1 do
        begin

          if FileExists(Source[i]) then
          begin
            IOUtils.TFile.Move(Source[i], Destination);
            Sleep(500);
            result := FileExists(Destination);
          end
          else
          begin
            if DirectoryExists(Source[i]) then
            begin
              IOUtils.TDirectory.Move(Source[i], Destination);
              Sleep(500);
              result := DirectoryExists(Destination);
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
            result := FileExists(Destination);
          end
          else
          begin
            if DirectoryExists(Source[i]) then
            begin
              IOUtils.TDirectory.Copy(Source[i], Destination);
              Sleep(500);
              result := DirectoryExists(Destination);
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
            result := DeleteFile(Source[i]);
          end
          else
          begin
            if DirectoryExists(Source[i]) then
            begin
              TDirectory.Delete(Source[i], True);
              Sleep(100);
              result := DirectoryExists(Source[i]) = False;
            end;
          end;
        end;

      end;
    4: // FO_RENAME:
      begin
        for i := 0 to Source.Count - 1 do
        begin
          result := RenameFile(Source[i], Destination);

        end;
      end
  else
    raise Exception.Create('No implemented operation');
  end;

end;

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
  result := False;
  while (Integer(ContinueLoop) <> 0) and (LC <= 1000) do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile))
      = UpperCase(ProcessName)) or (UpperCase(FProcessEntry32.szExeFile)
      = UpperCase(ProcessName))) then
    begin
      result := True;
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
  exeResult: String;
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
  exeResult := processText.Text;
  result := Pos(ProcessName, processText.Text) > 0;
end;
{$ENDIF MSWINDOWS}

function PosOfOccurrence(p_SubStr, p_Source: string;
p_NthOccurrence: Integer): Integer;
var
  Occurrences, SubStrPos, NumDeletedChars, SubStrLength: Integer;
begin
  result := 0;
  if (length(p_SubStr) = 0) or (length(p_Source) = 0) or (p_NthOccurrence < 1)
  then
    Exit;
  SubStrLength := length(p_SubStr);
  NumDeletedChars := 0;
  for Occurrences := 1 to p_NthOccurrence do
  begin
    SubStrPos := AnsiPos(p_SubStr, p_Source);
    if SubStrPos = 0 then
      Exit;
    System.Delete(p_Source, 1, (SubStrPos + SubStrLength) - 1);
    NumDeletedChars := NumDeletedChars + (SubStrPos + SubStrLength) - 1;
  end;
  result := (NumDeletedChars - SubStrLength) + 1;
end;

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
  result := ProcessExists(ExeName) = False;

end;
{$ELSE}

var
  resultCmd: TStringList;
  abortCmd: Boolean;
begin
  result := False;
  abortCmd := False;
  resultCmd := ExecuteTerminalProcess('killall', '-v ' + ExeName,
    abortCmd, nil);
  if Assigned(resultCmd) then
  begin
    FreeAndNil(resultCmd);
    result := True;
  end;
  // options: killall /v exename ,kill $(pgrep irssi), kill `ps -ef | grep irssi | grep -v grep | awk ‘{print $2}’`

end;
{$ENDIF MSWINDOWS}
{ TExecuteCmdCallBack }

end.

