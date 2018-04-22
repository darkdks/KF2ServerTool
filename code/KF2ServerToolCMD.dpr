program KF2ServerToolCMD;
{$APPTYPE CONSOLE}

uses
  SysUtils,
  IniFiles,
{$IFDEF LINUX64}
  LinuxUtils in 'units\LinuxUtils.pas',
{$ENDIF }
  KFFile in 'units\KFFile.pas',
  KFRedirect in 'units\KFRedirect.pas',
  KFServerTool in 'units\KFServerTool.pas',
  KFWksp in 'units\KFWksp.pas',
  MiscFunc in 'units\MiscFunc.pas';

var
  useCustomServerPath: Boolean;
  customServerPath, pathKFGameIni, pathKFEngineIni, pathAcfSubFolder, pathCmdTool, pathServerEXE: string;
  serverTool: TKFServerTool;
  serverPath: string;
  configName: String = 'KFServerToolCMD.ini';
  ApplicationPath: string;

function loadConfig: Boolean;
var
  IniConfig: TIniFile;
  iniPath: string;

begin
  Result := False;

  iniPath := ExtractFilePath(ApplicationPath) + configName;
  IniConfig := TIniFile.Create(iniPath);
  // Create if there's no config file

  if not FileExists(iniPath) then
  begin
    with IniConfig do
    begin
      writeln('Ini file not found, writing default config file in: ' + iniPath);
     {$IFDEF DEBUG}
      WriteBool('PATHS', 'UseCustomServerPath', True);
      WriteString('PATHS', 'CustomServerPath', '/home/darkdks/KF2Server');
     {$ELSE}
      WriteBool('PATHS', 'UseCustomServerPath', False);
      WriteString('PATHS', 'CustomServerPath', 'CHANGE_ME_FOR_CUSTOM_PATH');
     {$ENDIF}
{$IFDEF LINUX64}
      WriteString('PATHS', 'ServerEXE',
        '/Binaries/Win64/KFGameSteamServer.bin.x86_64');
      WriteString('PATHS', 'SteamCmdTool', 'steamcmd');
      WriteString('PATHS', 'KFGameIni', 'KFGame/Config/LinuxServer-KFGame.ini');
      WriteString('PATHS', 'KFEngineIni', 'KFGame/Config/LinuxServer-KFEngine.ini');
{$ELSE}
      WriteString('PATHS', 'KFGameIni', 'KFGame\Config\PCServer-KFGame.ini');
      WriteString('PATHS', 'KFEngineIni', 'KFGame\Config\PCServer-KFEngine.ini');
      WriteString('PATHS', 'ServerEXE', 'Binaries\win64\kfserver.exe');
      WriteString('PATHS', 'SteamCmdTool', 'STEAMCMD\SteamCmd.exe');
{$ENDIF}
    end;

  end;
  // Read config file
  try
    with IniConfig do
    begin
      // GAME
      useCustomServerPath := ReadBool('PATHS', 'UseCustomServerPath', False);
      customServerPath := ReadString('PATHS', 'CustomServerPath',
        'CHANGE_ME_FOR_CUSTOM_PATH');
{$IFDEF LINUX64}
      pathCmdTool := ReadString('PATHS', 'SteamCmdTool', 'steamcmd');
      pathServerEXE := ReadString('PATHS', 'ServerEXE',
        '/Binaries/Win64/KFGameSteamServer.bin.x86_64');
      pathKFGameIni := ReadString('PATHS', 'KFGameIni',
        'KFGame/Config/LinuxServer-KFGame.ini');
      pathKFEngineIni := ReadString('PATHS', 'KFEngineIni',
        'KFGame/Config/LinuxServer-KFEngine.ini');
{$ELSE}

      pathCmdTool := ReadString('PATHS', 'SteamCmdTool',
        'STEAMCMD\SteamCmd.exe');
      pathServerEXE := ReadString('PATHS', 'ServerEXE',
        'Binaries\win64\kfserver.exe');
      pathKFGameIni := ReadString('PATHS', 'KFGameIni',
        'KFGame' + PathDelim + 'Config' + PathDelim + 'PCServer-KFGame.ini');
      pathKFEngineIni := ReadString('PATHS', 'KFEngineIni',
        'KFGame' + PathDelim + 'Config' + PathDelim +
        'PCServer-KFEngine.ini');
{$ENDIF}
    end;
    Result := True;
  finally
    IniConfig.Free;
  end;

end;

procedure CheckServerPath;
begin

  if useCustomServerPath then
  begin
    if FileExists(customServerPath + pathServerEXE) then
    begin
      serverPath := IncludeTrailingPathDelimiter(customServerPath);
    end
    else
    begin

      raise Exception.Create('Killing Floor 2 server not found.' + #13#10 +
        'Check if the app is in server folder or the ' + configName +
        ' is configured correctly.');
    end;
  end
  else
  begin

    if FileExists(ExtractFilePath(ApplicationPath) + pathServerEXE) then
    begin
      serverPath := ExtractFilePath(ApplicationPath);
    end
    else
    begin
      raise Exception.Create('Killing Floor 2 server not found.' + #13#10 +
        'Check if the app is in server folder or the ' + configName +
        ' is configured correctly.');
    end;
  end;

end;

var
  i: Integer;
  itemID, itemName: string;

begin
  ApplicationPath := ParamStr(0);
  try
    if (ParamCount <= 0) or (LowerCase(ParamStr(0)) = '-help') then
    begin
      Writeln('KF2ServerToolCMD 2.0 Alpha');
{$IFDEF LINUX64}
      Writeln('Linux Version');
{$ENDIF }
      Writeln('  Usage:');
      Writeln('  KF2ServerToolCMD -option agurment=value');
      Writeln('  Example:');
      Writeln('  KF2ServerToolCMD -addmap id=1234567891');
      Writeln('');
      Writeln('');
      Writeln('Options:');
      Writeln('-list : list all installed itens');
      Writeln('');
      Writeln('-listdetalied : list all itens installed in a detalied view');
      Writeln('');
      Writeln('-remove id=<WorkshopID>   : Fully remove item');
      Writeln('');
      Writeln('-addmap id=<WorkshopID>   : Download and add entrys to map');
      Writeln('');
      Writeln('-addmod id=<WorkshopID>   : Download and add entrys to mod');
      Writeln('');
      Writeln('-custom <Agurments>  : Does one o more specied steps');
      Writeln('    Custom agurments:');
      Writeln('    aws=<WorkshopID>  : Add specified Workshop Subcribe');
      Writeln('    rws=<WorkshopID>  : Remove specified Workshop Subcribe');
      Writeln('    ame=<MapFileName> : Add specified Map Entry');
      Writeln('    rme=<MapFileName> : Remove specified Map Entry');
      Writeln('    amc=<MapFileName> : Add specified Map In Map Cycle');
      Writeln('    rmc=<MapFileName> : Remove specified Map In Map Cycle');
      Writeln('    adl=<WorkshopID>  : Download specified Workshop map or item to cache');
      Writeln('    rdl=<WorkshopID>  : Remove specified Workshop map or item to cache');
      Writeln('');
      Writeln('    Example: KF2ServerToolCMD -custom ame=KF-MyMap amc=KF-MyMap aws=1234567891');
      Writeln('   (This will add just the map entry, the map in server cycle and workshop subscription.)');
      Writeln('');
      Writeln('-help : Show this message');

    end
    else
    begin
      loadConfig;
      CheckServerPath;
      serverTool := TKFServerTool.Create;
      try
        serverTool.SetKFApplicationPath(serverPath);
        serverTool.SetKFngineIniSubPath(pathKFEngineIni);
        serverTool.SetKFGameIniSubPath(pathKFGameIni);
        serverTool.SetKFServerPathEXE(pathServerEXE);
        serverTool.SetSteamCmdPath(pathCmdTool);
      //  serverTool.GenerateLog := True;

        // ------------------------------------------------------------------- -AddMap
        if (LowerCase(ParamStr(1)) = '-addmap') then
        begin

          if ParamCount <> 2 then
            raise Exception.Create('Addmap: Invalid arguments');

          itemID := CleanInt(ParamStr(2));
          if Length(itemID) < 6 then
            raise Exception.Create('Addmap: Invalid ID');
          Writeln(' Starting...');
          Writeln(' Item ID: ' + itemID);
          serverTool.InstallWorkshopItem(itemID, itemName, True, True,
            True, True);

          Writeln(' Finished');
          Exit;
        end;
        // ------------------------------------------------------------------ -AddMod
        if (LowerCase(ParamStr(1)) = '-addmod') then
        begin

          if ParamCount <> 2 then
            raise Exception.Create('addmod: Invalid arguments');

          itemID := CleanInt(ParamStr(2));
          if Length(itemID) < 6 then
            raise Exception.Create('addmod: Invalid ID');

          Writeln(' Starting...');
          Writeln(' Item ID: ' + itemID);
          serverTool.InstallWorkshopItem(itemID, itemName, True, True,
            False, False);

          Writeln(' Finished');
          Exit;
        end;
        // ------------------------------------------------------------------ -Remove
        if (LowerCase(ParamStr(1)) = '-remove') then
        begin

          if ParamCount <> 2 then
            raise Exception.Create('remove: Invalid arguments');

          itemID := CleanInt(ParamStr(2));
          if Length(itemID) < 6 then
            raise Exception.Create('remove: Invalid ID');

          Writeln(' Starting...');
          Writeln(' Item ID: ' + itemID);
          serverTool.LoadItems;
          for i := 0 to High(serverTool.Items) do
          begin
            if serverTool.Items[i].ID = itemID then
            begin
              itemName := serverTool.Items[i].FileName;
              Writeln(' Item Name: ' + itemName);

              serverTool.RemoveItem(itemName, itemID, True, True, True, True,
                TKFSource.KFSteamWorkshop);
              Exit;
            end;

          end;

          Writeln(' Finished');
          Exit;
        end;
        // ------------------------------------------------------------------ -list
        if (LowerCase(ParamStr(1)) = '-list') then
        begin

          if ParamCount <> 1 then
            raise Exception.Create('addmod: Invalid arguments');
          serverTool.LoadItems;
          Writeln('----------------------------------------------------------------------------');
          Writeln('   NAME                     /    ID     / SUBS. / M.ENTRY / M.CYCLE / CACHE');
          Writeln('----------------------------------------------------------------------------');
          for i := 0 to High(serverTool.Items) do
          begin
            with serverTool.Items[i] do
            begin
              Writeln(TextForXchar(FileName, 26) + ' ' + TextForXchar(ID, 12) +
                TextForXchar(BoolToWord(ServerSubscribe), 8) +
                TextForXchar(BoolToWord(MapEntry), 8) +
                TextForXchar(BoolToWord(MapCycleEntry), 9) +
                TextForXchar(BoolToWord(ServerCache), 8));

            end;
          end;

          Writeln('----------------------------------------------------------------------------');
          Exit;
        end;
        // ------------------------------------------------------------------ -listdetalied

        if (LowerCase(ParamStr(1)) = '-listdetalied') then
        begin

          serverTool.LoadItems;

          for i := 0 to High(serverTool.Items) do
          begin

            with serverTool.Items[i] do
            begin

              {
                if servertool. IsMod then
                begin
                Writeln('');
                Writeln('Name:            ' + FileName);
                Writeln('ID:              ' + ID);
                Writeln('Subscribed:      ' + BoolToWord(ServerSubscribe));
                Writeln('In Server cache: ' + BoolToWord(ServerCache));

                end
                else }
              begin
                Writeln('');
                Writeln('Name:            ' + FileName);
                Writeln('ID:              ' + ID);
                Writeln('Subscribed:      ' + BoolToWord(ServerSubscribe));
                Writeln('In Map Entry:    ' + BoolToWord(MapEntry));
                Writeln('In Map Cycle:    ' + BoolToWord(MapCycleEntry));
                Writeln('In Server cache: ' + BoolToWord(ServerCache));

              end;

            end;
          end;

          Exit;
        end;

        Writeln('KF2ServerTool fineshed. Wrong param?');
      finally
        serverTool.Free;
      end;

    end;
    // Readln(serverPath);
    { TODO -oUser -cConsole Main : Insert code here }
  except
    on E: Exception do
      Writeln('Error: ' + E.Message);
  end;

end.
