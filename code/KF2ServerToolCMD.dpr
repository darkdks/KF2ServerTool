program KF2ServerToolCMD;
{$APPTYPE CONSOLE}

uses
  SysUtils,
  IniFiles,
  StrUtils,
  classes,
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
  ignoreCacheFolder: Boolean = False;
  customServerPath, pathKFGameIni, pathKFEngineIni, pathCmdTool,
    pathServerEXE: string;
  serverTool: TKFServerTool;
  serverPath: string;
  configName: String = 'KFServerToolCMD.ini';
  ApplicationPath: string;

const
  KF2CMDTOOLVERSION = '1.0.5';

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
      WriteString('PATHS', 'SteamCmdTool',
        '/home/darkdks/KF2Server/steamcmd/steamcmd.sh');
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
  writeln('KF2ServerToolCmd by darkdks');
  writeln('');
  writeln('CMD Version :' + KF2CMDTOOLVERSION);
  writeln('KF2ServerTool library: ' + TKFServerTool.SERVERTOOLVERSION);
{$IFDEF LINUX64}
  writeln('Console for Linux');
{$ELSE}
  writeln('Console for Windows');

{$ENDIF }
  writeln('  Usage:');
  writeln('  KF2ServerToolCMD -option <value>');
  writeln('  Example:');
  writeln('  KF2ServerToolCMD -addmap 1234567891');
  writeln('');
  writeln('');
  writeln('Options:');
  writeln('-list : list all installed items');
  writeln('');
  writeln('-report : report all items installed without formatting');
  writeln('');
  writeln('-remove <WorkshopID>   : Fully remove item');
  writeln('');
  writeln('-addmap <WorkshopID>   : Download and add entrys to map');
  writeln('');
  writeln('-addmod <WorkshopID>   : Download and add entrys to mod');
  writeln('');
  writeln('-custom <Arguments>  : Does one o more specied steps');
  writeln('    Custom arguments:');
  writeln('    aws=<WorkshopID>  : Add specified Workshop subscribe');
  writeln('    rws=<WorkshopID>  : Remove specified Workshop subscribe');
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
  writeln('');
  writeln('-config <FileName.ini>  : Specify a custom  KF2ServerToolCMD.ini, if dont exists');
  writeln('    a new one will be created. Then the tool will work only with the configured KF2Game ');
  writeln('    and KFEngine ini specified inside the custom KF2ServerToolCMD ini file.');
  writeln('    Also when this option is set the tool will ignore show items');
  writeln('    that the current config is not subscribed');
  writeln('');
  writeln('-ig  : Ignore if the server is running (Not recommended)');
  writeln('');
  writeln('-update <WorkshopID>  : Update item from workshop)');
  writeln('');
  writeln('-validate  : Redownload all subscribed workshop files');
  writeln('');
  writeln('-help : Show this message');

end;

procedure ShowItems();
var
  I: Integer;
  sortedList: TStringList;
  aKFItem: TKFItem;
begin

  serverTool.LoadItems;
  sortedList := TStringList.Create;
  for I := 0 to High(serverTool.Items) do
  begin
    sortedList.AddObject(serverTool.Items[I].FileName, serverTool.Items[I]);
  end;
  sortedList.Sort;

  try
    writeln('----------------------------- WORKSHOP MAPS --------------------------------');
    writeln('----------------------------------------------------------------------------');
    writeln('   NAME                     /    ID     / SUBS. / M.ENTRY / M.CYCLE / CACHE');
    writeln('----------------------------------------------------------------------------');

    for I := 0 to sortedList.Count - 1 do
    begin

      aKFItem := sortedList.Objects[I] as TKFItem;
      if (aKFItem.SourceFrom = KFSteamWorkshop) and (aKFItem.ItemType = KFMap)
      then
      begin

        if not((aKFItem.ServerSubscribe = False) and (ignoreCacheFolder)) then
        begin
          with aKFItem do
          begin
            writeln(TextForXchar(FileName, 26) + ' ' + TextForXchar(ID, 12) +
              TextForXchar(BoolToWord(ServerSubscribe), 8) +
              TextForXchar(BoolToWord(MapEntry), 8) +
              TextForXchar(BoolToWord(MapCycleEntry), 9) +
              TextForXchar(BoolToWord(ServerCache), 8));

          end;
        end;
      end;
    end;
    writeln('----------------------------- WORKSHOP MODS --------------------------------');
    writeln('----------------------------------------------------------------------------');
    writeln('   NAME                     /    ID     / SUBSCRIPTION         ITEM IN CACHE');
    writeln('----------------------------------------------------------------------------');

    for I := 0 to sortedList.Count - 1 do
    begin
      aKFItem := sortedList.Objects[I] as TKFItem;
      if (aKFItem.SourceFrom = KFSteamWorkshop) and (aKFItem.ItemType = KFmod)
      then
      begin

        if not((aKFItem.ServerSubscribe = False) and (ignoreCacheFolder)) then
        begin
          with aKFItem do
          begin
            writeln(TextForXchar(FileName, 26) + ' ' + TextForXchar(ID, 12) +
              TextForXchar(BoolToWord(ServerSubscribe), 8) + TextForXchar('', 8)
              + TextForXchar('', 9) + TextForXchar(BoolToWord(ServerCache), 8));

          end;
        end;
      end;
    end;
    writeln('---------------------------- OFICIAL MAPS ----------------------------------');
    writeln('----------------------------------------------------------------------------');
    writeln('   NAME                                          / M.ENTRY / M.CYCLE / CACHE');
    writeln('----------------------------------------------------------------------------');
    for I := 0 to sortedList.Count - 1 do
    begin
      aKFItem := sortedList.Objects[I] as TKFItem;
      if (aKFItem.SourceFrom = KFOfficial) then
      begin
        with aKFItem do
        begin
          writeln(TextForXchar(FileName, 26) + ' ' + TextForXchar(ID, 12) +
            TextForXchar('', 8) + TextForXchar(BoolToWord(MapEntry), 8) +
            TextForXchar(BoolToWord(MapCycleEntry), 9) +
            TextForXchar(BoolToWord(ServerCache), 8));

        end;
      end;
    end;
    if not ignoreCacheFolder then
    begin

      writeln('------------------------ LOCAL OR REDIRECT MAPS ----------------------------');
      writeln('----------------------------------------------------------------------------');
      writeln('   NAME                                          / M.ENTRY / M.CYCLE / CACHE');
      writeln('----------------------------------------------------------------------------');
      for I := 0 to High(serverTool.Items) do
      begin
        aKFItem := sortedList.Objects[I] as TKFItem;
        if (aKFItem.SourceFrom = KFRedirectOrLocal) then
        begin
          with aKFItem do
          begin
            writeln(TextForXchar(FileName, 26) + ' ' + TextForXchar(ID, 12) +
              TextForXchar('', 8) + TextForXchar(BoolToWord(MapEntry), 8) +
              TextForXchar(BoolToWord(MapCycleEntry), 9) +
              TextForXchar(BoolToWord(True), 8));

          end;
        end;
      end;
    end;
    writeln('----------------------------------------------------------------------------');
  finally
    FreeAndNil(sortedList);
  end;
end;

procedure ShowItemsDetailed();
var
  I: Integer;
  sortList: TStringList;
  kfitem: TKFItem;
begin
  serverTool.LoadItems;

  sortList := TStringList.Create;
  try
    for I := 0 to High(serverTool.Items) do
    begin
      sortList.AddObject(serverTool.Items[I].FileName, serverTool.Items[I]);
    end;
    sortList.Sort;

    for I := 0 to sortList.Count - 1 do
    begin
      kfitem := sortList.Objects[I] as TKFItem;
      if not((kfitem.ServerSubscribe = False) and (ignoreCacheFolder)) then
      begin
        with kfitem do
        begin
          writeln('');
          case ItemType of
            KFMap:
              writeln('[KFMap]');
            KFmod:
              writeln('[KFMod]');
            KFUnknowed:
              writeln('[KFUnknowed]');
          end;
          case SourceFrom of
            KFSteamWorkshop:
              writeln('Source:  KFSteamWorkshop');
            KFOfficial:
              writeln('Item Type:  KFOfficial');
            KFRedirectOrLocal:
              writeln('Item Type:  KFRedirectOrLocal');
          end;
          writeln('Name:            ' + FileName);
          writeln('ID:              ' + ID);
          writeln('Subscribed:      ' + BoolToWord(ServerSubscribe));
          if ItemType = KFMap then
          begin
            writeln('In Map Entry:    ' + BoolToWord(MapEntry));
            writeln('In Map Cycle:    ' + BoolToWord(MapCycleEntry));
          end;
          writeln('In Server cache: ' + BoolToWord(ServerCache));

        end;
      end;
    end;
  finally
    FreeAndNil(sortList);
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

procedure addWorkshopSubscribe(itemID: String);
begin
  writeln(' Adding Subscribe...');
  writeln(' Item ID: ' + itemID);
  serverTool.InstallWorkshopItem(itemID, '', True, False, False, False);
  writeln(' Finished');
end;

procedure removeWorkshopSubscribe(itemID: String);
begin
  writeln(' Removing Subscribe...');
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

procedure updateItem(itemID: String);
var
  I: Integer;
  itemExists: Boolean;
begin
  writeln(' Updating item...');
  writeln(' Item ID: ' + itemID);
  itemExists := False;
  for I := 0 to High(serverTool.Items) do
  begin
    if serverTool.Items[I].ID = itemID then
      itemExists := True;
  end;

  if itemExists then
    serverTool.ForceUpdate(itemID, False)
  else
    writeln('Item + ' + itemID + 'not found');

  writeln('Finished');
end;

procedure ValidateWorkshopItems();
var
  I: Integer;
begin
  serverTool.LoadItems;
  for I := 0 to High(serverTool.Items) do
  begin

    if (serverTool.Items[I].SourceFrom = KFSteamWorkshop) then
    // Just items from workshop
    begin

      if not((serverTool.Items[I].ServerSubscribe = False) and
        (ignoreCacheFolder)) then
      begin
        with serverTool.Items[I] do
        begin
          writeln('');
          writeln('Validating item ' + intToStr(I + 1) + ' of ' +
            intToStr(High(serverTool.Items) + 1));
          writeln('Name:            ' + FileName);
          writeln('ID:              ' + ID);
          writeln('Subscribed:      ' + BoolToWord(ServerSubscribe));
          writeln('In Map Entry:    ' + BoolToWord(MapEntry));
          writeln('In Map Cycle:    ' + BoolToWord(MapCycleEntry));
          writeln('In Server cache: ' + BoolToWord(ServerCache));
          serverTool.InstallWorkshopItem(ID, FileName, ServerSubscribe, True,
            MapCycleEntry, MapEntry);
        end;
      end;
    end;
  end;
end;

procedure CheckIfTheServerIsRuning();
var
  warningText, serverRunning: string;
  cmdOp: String;
  cmdAnswer: string;
begin

  warningText := '';
  serverRunning := 'Server is running';

  if serverTool.IsServerRunning then
  begin
    writeln('Is strongly recommended close the server before make changes. ');
    writeln('Do you wanna close it close it now?');
    writeln('yes/no');
    //cmdAnswer := 'yes';
    Readln(cmdAnswer);

    if WordToBool(cmdAnswer) then
    begin
      writeln('Closing the server...');
      serverTool.KillKFServer();
      CheckIfTheServerIsRuning();
    end
    else
    begin
      writeln('Skipping close the server');
    end;

  end
  else
  begin
    if serverTool.verbose then
    begin
      writeln('Debug: Server is not running');
    end;

  end;
end;

function debugTest(argument: string): Boolean;
begin
  writeln('Begin of debug test function with argument: "' + argument + '"');
  CheckIfTheServerIsRuning;
  writeln('End of debug test function');
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
  actions: TStringList;
  enableVerbose: Boolean;
  ignoreParam: Boolean;
  ignoreServerRunning: Boolean;

begin
  ApplicationPath := IncludeTrailingPathDelimiter(GetCurrentDir);
  actions := TStringList.Create;
  ignoreServerRunning := False;
  for I := 1 to ParamCount do
  begin // Discart set options and do actions list
    ignoreParam := False;
    case AnsiIndexStr(LowerCase(ParamStr(I)), ['-v', '-config', '-ig']) of
      0: { -v }
        begin
          enableVerbose := True;
          writeln('Option: Verbose mod is set to on');
        end;
      1: { -config }
        begin
          if (I < ParamCount) and (Pos('.ini', ParamStr(I + 1)) > 0) then
          begin
            configName := ParamStr(I + 1);
            writeln('Option: Custom ini is set to ' + configName);
            ignoreCacheFolder := True;
            ignoreParam := True;
          end;
        end;
      3: { -ig }
        begin
          ignoreServerRunning := True;
          writeln('Option: Server running check is set to off');
        end;
    else
      begin
        if Not ignoreParam then
          actions.Add(LowerCase(Trim(ParamStr(I)))); // add action param
      end;
    end;

  end;

  try
    if (actions.Count < 1) or (actions.IndexOf('-help') > 0) then
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

        option := actions[0];
        if actions.Count > 1 then
          argument := actions[1];
        if not ignoreServerRunning then
          CheckIfTheServerIsRuning;
        // ------------------------------------------------------------------- -AddMap
        if option = '-addmap' then
        begin

          if actions.Count <> 2 then
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

          if actions.Count <> 2 then
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
          if actions.Count <> 2 then
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
          if actions.Count <> 1 then
            raise Exception.Create('addmod: Invalid arguments');
          ShowItems;
          Exit;
        end;
        // ------------------------------------------------------------------ -listdDetailed
        if option = '-listdetailed' then
        begin
          if actions.Count <> 1 then
            raise Exception.Create('addmod: Invalid arguments');
          ShowItemsDetailed;
          Exit;
        end;
        // ------------------------------------------------------------------ -custom
        if option = '-custom' then
        begin
          if actions.Count < 2 then
            raise Exception.Create('custom: Invalid arguments');

          for I := 1 to actions.Count - 1 do
          begin
            argument := actions[I];
            argType := LowerCase(Copy(argument, 0, Pos('=', argument) - 1));
            argValue := Copy(argument, Pos('=', argument) + 1,
              Length(argument));

            case AnsiIndexStr(argType, ['aws', 'rws', 'ame', 'rme', 'amc',
              'rmc', 'adl', 'rdl']) of
              0: { aws }
                begin
                  itemID := CleanInt(argValue);
                  addWorkshopSubscribe(itemID)
                end;
              1: { rws }
                begin
                  itemID := CleanInt(argValue);
                  removeWorkshopSubscribe(itemID);
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
          // ------------------------------------------------------------------ -validate
          if option = '-validate' then
          begin
            if actions.Count <> 1 then
              raise Exception.Create('validate: Invalid arguments');
            ValidateWorkshopItems;
            Exit;
          end;
          if option = '-update' then
          begin
            if actions.Count <> 2 then
              raise Exception.Create('update: Invalid arguments');
            itemID := CleanInt(argument);
            if Length(itemID) < 6 then
              raise Exception.Create('update: Invalid ID');
            updateItem(itemID);
            Exit;

            Exit;
          end;

          Exit;
        end;
        // ------------------------------------------------------------------ -test
      {  begin
          //debugTest(argument);
          Exit;
        end;
       }
        writeln('KF2ServerTool finished. Wrong param?');
      finally
       // Readln(option);
        serverTool.Free;
      end;

    end;
  except
    on E: Exception do
      writeln('Error: ' + E.Message);
  end;

end.
