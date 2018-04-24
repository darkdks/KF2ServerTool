program KF2ServerToolCMD;
{$APPTYPE CONSOLE}

uses
  SysUtils,
  IniFiles, StrUtils, classes,
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
  customServerPath, pathKFGameIni, pathKFEngineIni, pathCmdTool,
    pathServerEXE: string;
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
            WriteString('PATHS', 'SteamCmdTool', '/home/darkdks/KF2Server/steamcmd/steamcmd.sh');
{$ELSE}
      WriteBool('PATHS', 'UseCustomServerPath', False);
      WriteString('PATHS', 'CustomServerPath', 'CHANGE_ME_FOR_CUSTOM_PATH');
      WriteString('PATHS', 'SteamCmdTool', 'steamcmd');
{$ENDIF}
{$IFDEF LINUX64}
      WriteString('PATHS', 'ServerEXE',
        '/Binaries/Win64/KFGameSteamServer.bin.x86_64');

      WriteString('PATHS', 'KFGameIni', 'KFGame/Config/LinuxServer-KFGame.ini');
      WriteString('PATHS', 'KFEngineIni',
        'KFGame/Config/LinuxServer-KFEngine.ini');
{$ELSE}
      WriteString('PATHS', 'KFGameIni', 'KFGame\Config\PCServer-KFGame.ini');
      WriteString('PATHS', 'KFEngineIni',
        'KFGame\Config\PCServer-KFEngine.ini');
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
        'KFGame' + PathDelim + 'Config' + PathDelim + 'PCServer-KFEngine.ini');
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

procedure ShowHelp;
begin
  writeln('KF2ServerTool ' + TKFServerTool.SERVERTOOLVERSION);
{$IFDEF LINUX64}
  writeln('Console for Linux');
{$ELSE}
  writeln('Console for Windows');

{$ENDIF }
  writeln('  Usage:');
  writeln('  KF2ServerToolCMD -option argument=value');
  writeln('  Example:');
  writeln('  KF2ServerToolCMD -addmap id=1234567891');
  writeln('');
  writeln('');
  writeln('Options:');
  writeln('-list : list all installed itens');
  writeln('');
  writeln('-listdetalied : list all itens installed in a detalied view');
  writeln('');
  writeln('-remove id=<WorkshopID>   : Fully remove item');
  writeln('');
  writeln('-addmap id=<WorkshopID>   : Download and add entrys to map');
  writeln('');
  writeln('-addmod id=<WorkshopID>   : Download and add entrys to mod');
  writeln('');
  writeln('-custom <Agurments>  : Does one o more specied steps');
  writeln('    Custom agurments:');
  writeln('    aws=<WorkshopID>  : Add specified Workshop Subcribe');
  writeln('    rws=<WorkshopID>  : Remove specified Workshop Subcribe');
  writeln('    ame=<MapFileName> : Add specified Map Entry');
  writeln('    rme=<MapFileName> : Remove specified Map Entry');
  writeln('    amc=<MapFileName> : Add specified Map In Map Cycle');
  writeln('    rmc=<MapFileName> : Remove specified Map In Map Cycle');
  writeln('    adl=<WorkshopID>  : Download specified Workshop map or item to cache');
  writeln('    rdl=<WorkshopID>  : Remove specified Workshop map or item to cache');
  writeln('');
  writeln('    Example: KF2ServerToolCMD -custom ame=KF-MyMap amc=KF-MyMap aws=1234567891');
  writeln('   (This will add just the map entry, the map in server cycle and workshop subscription.)');
  writeln('');
  writeln('-help : Show this message');

end;

procedure ShowItems();
var
  I: Integer;
begin

  serverTool.LoadItems;
  writeln('----------------------------------------------------------------------------');
  writeln('   NAME                     /    ID     / SUBS. / M.ENTRY / M.CYCLE / CACHE');
  writeln('----------------------------------------------------------------------------');
  for I := 0 to High(serverTool.Items) do
  begin
    with serverTool.Items[I] do
    begin
      writeln(TextForXchar(FileName, 26) + ' ' + TextForXchar(ID, 12) +
        TextForXchar(BoolToWord(ServerSubscribe), 8) +
        TextForXchar(BoolToWord(MapEntry), 8) +
        TextForXchar(BoolToWord(MapCycleEntry), 9) +
        TextForXchar(BoolToWord(ServerCache), 8));

    end;
  end;

  writeln('----------------------------------------------------------------------------');
end;

procedure ShowItemsDetalied();
var
  I: Integer;
begin
  serverTool.LoadItems;

  for I := 0 to High(serverTool.Items) do
  begin

    with serverTool.Items[I] do
    begin

      if serverTool.Items[I].ItemType = KFmod then
      begin
        writeln('');
        writeln('Name:            ' + FileName);
        writeln('ID:              ' + ID);
        writeln('Subscribed:      ' + BoolToWord(ServerSubscribe));
        writeln('In Server cache: ' + BoolToWord(ServerCache));

      end
      else
      begin
        writeln('');
        writeln('Name:            ' + FileName);
        writeln('ID:              ' + ID);
        writeln('Subscribed:      ' + BoolToWord(ServerSubscribe));
        writeln('In Map Entry:    ' + BoolToWord(MapEntry));
        writeln('In Map Cycle:    ' + BoolToWord(MapCycleEntry));
        writeln('In Server cache: ' + BoolToWord(ServerCache));

      end;

    end;
  end;
end;

procedure addmod(itemID: string);
begin
  writeln(' Adding mod...');
  writeln(' Item ID: ' + itemID);
  serverTool.InstallWorkshopItem(itemID, '', True, True, False, False);
  writeln(' Finished');
end;

procedure addMap(itemID: String);
begin
  writeln(' Adding Map...');
  writeln(' Item ID: ' + itemID);
  serverTool.InstallWorkshopItem(itemID, '', True, True, True, True);
  writeln(' Finished');
end;

procedure addWorkshopSubcribe(itemID: String);
begin
  writeln(' Adding Subcribe...');
  writeln(' Item ID: ' + itemID);
  serverTool.InstallWorkshopItem(itemID, '', True, False, False, False);
  writeln(' Finished');
end;

procedure removeWorkshopSubcribe(itemID: String);
begin
  writeln(' Removing Subcribe...');
  writeln(' Item ID: ' + itemID);
  serverTool.RemoveItem('', itemID, False, False, True, False,
    TKFSource.KFSteamWorkshop);
  writeln(' Finished');
end;

procedure addMapEntry(ItemName: String);
begin
  writeln(' Adding map entry...');
  writeln(' Item Name: ' + ItemName);
  serverTool.InstallWorkshopItem('', ItemName, False, False, False, True);
  writeln(' Finished');
end;

procedure removeMapEntry(ItemName: String);
begin
  writeln(' Removing map entry...');
  writeln(' Item Name: ' + ItemName);
  serverTool.RemoveItem(ItemName, '', False, True, False, False,
    TKFSource.KFSteamWorkshop);
  writeln(' Finished');
end;

procedure addMapCycle(ItemName: String);
begin
  writeln(' Adding map cycle...');
  writeln(' Item Name: ' + ItemName);
  serverTool.InstallWorkshopItem('', ItemName, False, False, True, False);
  writeln(' Finished');
end;

procedure removeMapCycle(ItemName: String);
begin
  writeln(' Removing map cycle...');
  writeln(' Item Name: ' + ItemName);
  serverTool.RemoveItem(ItemName, '', False, False, True, False,
    TKFSource.KFSteamWorkshop);
  writeln(' Finished');
end;

procedure downloadItem(itemID: String);
begin
  writeln(' Downloading item...');
  writeln(' Item ID: ' + itemID);
  serverTool.InstallWorkshopItem(itemID, '', False, True, False, False);
  writeln(' Finished');
end;

procedure removeDownloadedItem(itemID: String);
begin
  writeln(' Removing cache...');
  writeln(' Item ID: ' + itemID);
  serverTool.RemoveItem('', itemID, False, False, False, True,
    TKFSource.KFSteamWorkshop);
  writeln(' Finished');
end;

function RemoveItem(itemID: string): Boolean;
var
  ItemName: String;
  I: Integer;
begin
  Result := False;
  writeln(' Removing item...');
  writeln(' Item ID: ' + itemID);
  serverTool.LoadItems;
  for I := 0 to High(serverTool.Items) do
  begin
    if serverTool.Items[I].ID = itemID then
    begin
      ItemName := serverTool.Items[I].FileName;
      writeln(' Item Name: ' + ItemName);

      Result := serverTool.RemoveItem(ItemName, itemID, True, True, True, True,
        TKFSource.KFSteamWorkshop);
      Exit;
    end;

  end;
  writeln('Remove item Finished');
end;

var
  I: Integer;
  itemID: string;
  option, argument, argType, argValue: string;
  params: TStringList;
  enableVerbose: Boolean;

begin
  ApplicationPath := IncludeTrailingPathDelimiter( GetCurrentDir) ;
  params := TStringList.Create;
  for I := 1 to ParamCount do // Discart tool path
    if LowerCase(ParamStr(I)) = '-v' then
      enableVerbose := True
    else
      params.Add(LowerCase(Trim(ParamStr(I)))); // clean and lowercase param

    if enableVerbose then  Writeln('Verbose mod is set to Enabled');
    
      
  try
    if (params.Count < 1) or (params.IndexOf('-help') > 0) then
    begin
      ShowHelp;
    end
    else
    begin
      loadConfig;
      CheckServerPath;
      serverTool := TKFServerTool.Create;
      try
        serverTool.verbose := enableVerbose;
        serverTool.SetKFApplicationPath(serverPath);
        serverTool.SetKFngineIniSubPath(pathKFEngineIni);
        serverTool.SetKFGameIniSubPath(pathKFGameIni);
        serverTool.SetKFServerPathEXE(pathServerEXE);
        serverTool.SetSteamCmdPath(pathCmdTool);


        option := params[0];
        if params.Count > 1 then
          argument := params[1];

        // ------------------------------------------------------------------- -AddMap
        if option = '-addmap' then
        begin

          if params.Count <> 2 then
            raise Exception.Create('Addmap: Invalid arguments');

          itemID := CleanInt(argument);
          if Length(itemID) < 6 then
            raise Exception.Create('Addmap: Invalid ID');
          addMap(itemID);
          Exit;
        end;
        // ------------------------------------------------------------------ -AddMod
        if option = '-addmod' then
        begin

          if params.Count <> 2 then
            raise Exception.Create('addmod: Invalid arguments');
          itemID := CleanInt(argument);
          if Length(itemID) < 6 then
            raise Exception.Create('addmod: Invalid ID');
          addmod(itemID);
          Exit;
        end;
        // ------------------------------------------------------------------ -Remove
        if option = '-remove' then
        begin
          if params.Count <> 2 then
            raise Exception.Create('remove: Invalid arguments');
          itemID := CleanInt(argument);
          if Length(itemID) < 6 then
            raise Exception.Create('remove: Invalid ID');
          RemoveItem(itemID);
          Exit;
        end;
        // ------------------------------------------------------------------ -list
        if option = '-list' then
        begin
          if params.Count <> 1 then
            raise Exception.Create('addmod: Invalid arguments');
          ShowItems;
          Exit;
        end;
        // ------------------------------------------------------------------ -listdetalied
        if option = '-listdetalied' then
        begin
          if params.Count <> 1 then
            raise Exception.Create('addmod: Invalid arguments');
          ShowItemsDetalied;
          Exit;
        end;
        // ------------------------------------------------------------------ -custom
        if option = '-custom' then
        begin
          if params.Count < 2 then
            raise Exception.Create('custom: Invalid arguments');

          for I := 1 to params.Count - 1 do
          begin
            argument := params[I];
            argType := LowerCase(Copy(argument, 0, Pos('=', argument) - 1));
            argValue := Copy(argument, Pos('=', argument) + 1,
              Length(argument));

            case AnsiIndexStr(argType, ['aws', 'rws', 'ame', 'rme', 'amc',
              'rmc', 'adl', 'rdl']) of
              0: { aws }
                begin
                  itemID := CleanInt(argValue);
                  addWorkshopSubcribe(itemID)
                end;
              1: { rws }
                begin
                  itemID := CleanInt(argValue);
                  removeWorkshopSubcribe(itemID);
                end;
              2: { ame }
                begin
                  addMapEntry(argValue);
                end;
              3: { rme }
                begin
                  removeMapEntry(argValue);
                end;
              4: { amc }
                begin
                  addMapCycle(argValue);
                end;
              5: { rmc }
                removeMapCycle(argValue);
              6: { adl }
                begin
                  itemID := CleanInt(argValue);
                  downloadItem(itemID);
                end;
              7: { rdl }
                begin
                  itemID := CleanInt(argValue);
                  removeDownloadedItem(itemID);
                end;
            end;
          end;

          Exit;
        end;

        writeln('KF2ServerTool finished. Wrong param?');
      finally
        serverTool.Free;
      end;

    end;
  except
    on E: Exception do
      writeln('Error: ' + E.Message);
  end;

end.
