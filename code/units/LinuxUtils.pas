unit LinuxUtils;

interface

uses
  System.SysUtils,
  System.Classes,
  Posix.Base,
  Posix.Fcntl;

type
  TStreamHandle = pointer;

  TLinuxUtils = class
  public
    class function RunCommandLine(ACommand: string): TStringList; overload;
    class function RunCommandLine(ACommand: string; Return: TProc<String>)
      : boolean; overload;
    class function findParameter(AParameter: string): boolean;
  end;

function popen(const command: MarshaledAString; const _type: MarshaledAString)
  : TStreamHandle; cdecl; external libc name _PU + 'popen';
function pclose(filehandle: TStreamHandle): int32; cdecl;
  external libc name _PU + 'pclose';
function fgets(buffer: pointer; size: int32; Stream: TStreamHandle): pointer;
  cdecl; external libc name _PU + 'fgets';

implementation

class function TLinuxUtils.RunCommandLine(ACommand: string): TStringList;
var
  Handle: TStreamHandle;
  Data: array [0 .. 511] of uint8;
  M: TMarshaller;

begin
  Result := TStringList.Create;
  try
    Handle := popen(M.AsAnsi(PWideChar(ACommand)).ToPointer, 'r');
    try
      while fgets(@Data[0], Sizeof(Data), Handle) <> nil do
      begin
        Result.Add(Copy(UTF8ToString(@Data[0]), 1, UTF8ToString(@Data[0])
          .Length - 1));
        // ,sizeof(Data)));
      end;
    finally
      pclose(Handle);
    end;
  except
    on E: Exception do
      Result.Add(E.ClassName + ': ' + E.Message);
  end;
end;

class function TLinuxUtils.RunCommandLine(ACommand: string;
  Return: TProc<string>): boolean;
var
  Handle: TStreamHandle;
  Data: array [0 .. 511] of uint8;
  M: TMarshaller;

begin
  Result := false;
  try
    Handle := popen(M.AsAnsi(PWideChar(ACommand)).ToPointer, 'r');
    try
      while fgets(@Data[0], Sizeof(Data), Handle) <> nil do
      begin
        Return(Copy(UTF8ToString(@Data[0]), 1, UTF8ToString(@Data[0])
          .Length - 1));
        // ,sizeof(Data)));
      end;
    finally
      pclose(Handle);
    end;
  except
    on E: Exception do
      Return(E.ClassName + ': ' + E.Message);
  end;
end;

class function TLinuxUtils.findParameter(AParameter: string): boolean;
var
  I: Integer;
begin
  Result := false;
  for I := 0 to Pred(ParamCount) do
  begin
    Result := AParameter.ToUpper = ParamStr(I).ToUpper;
    if Result then
      Break;
  end;
end;

end.
