unit KFTypes;

interface

uses
  SysUtils, MiscFunc, Classes, IOutils;

type

  TKFSource = (KFSteamWorkshop, KFOfficial, KFRedirectOrLocal,
    KFUnknowedSource);
  TKFAppLanguage = (KFL_ENGLISH, KFL_PORTUGUESE);
  TKFItemType = (KFMap, KFmod, KFUnknowed);
  TKFRedirectItemType = (KFRmod, KFRmap, KFRAny);
  TKFCycleSort = (KFCSortByName, KFCSortByType, KFCKeepSame);
  function IsOfficialMap(mapName: String): Boolean;
procedure LoadOfficialMapList(serverPath: string);
const
{KF_OFFICIALMAPS:
array [0 .. 22, 0 .. 1]{filename/ImgIdx}{ of string = (('KF-Airship.kfm','0'), ('KF-BioticsLab.kfm', '1'),
  ('KF-BlackForest.kfm', '2'), ('KF-BurningParis.kfm', '3'),
  ('KF-Catacombs.kfm', '4'), ('KF-ContainmentStation.kfm','5'), ('KF-DieSector.kfm','6'),
  ('KF-EvacuationPoint.kfm','7'), ('KF-Farmhouse.kfm', '8'),
  ('KF-HostileGrounds.kfm', '9'), ('KF-InfernalRealm.kfm', '10'),
  ('KF-KrampusLair.kfm','11'), ('KF-Nightmare.kfm','12'), ('KF-Nuked.kfm',
  '13'), ('KF-Outpost.kfm', '14'), ('KF-PowerCore_Holdout.kfm', '15'),
  ('KF-Prison.kfm', '16'), ('KF-TheDescent.kfm', '17'), ('KF-TragicKingdom.kfm',
  '18'), ('KF-VolterManor.kfm', '19'), ('KF-ZedLanding.kfm', '20'), ('KF-Lockdown.kfm', '21'), ('KF-MonsterBall.kfm', '22'));
 }
  ARRAYTEST: array [0 .. 2, 0 .. 1] of string = (('teste', '0'), ('teste1',
  '1'), ('teste2', '2'));
  KF_IGNOREDBREWEDPCFILES: array [0 .. 44] of string = ('AkAudio.u',
  'AkResources.upk', 'BaseAI.u', 'Core.u', 'EditorLandscapeResources.upk',
  'EditorMaterials.upk', 'EditorMeshes.upk', 'EditorResources.upk',
  'EditorShellMaterials.upk', 'Engine.u', 'EngineApexResources.upk',
  'EngineBuildings.upk', 'EngineDebugMaterials.upk', 'EngineFonts.upk',
  'EngineMaterials.upk', 'EngineMeshes.upk', 'EngineProduction.upk',
  'EngineResources.upk', 'EngineSounds.upk', 'EngineVolumetrics.upk',
  'Engine_Lights.upk', 'Engine_MI_Shaders.upk', 'GameFramework.u', 'GFxUI.u',
  'GFxUIEditor.u', 'IpDrv.u', 'KFGame.u', 'KFGameContent.u',
  'MapTemplateIndex.upk', 'MapTemplates.upk', 'MaterialTemplates.upk',
  'MobileResources.upk', 'NodeBuddies.upk', 'OnlineSubsystemDingo.u',
  'OnlineSubsystemPC.u', 'OnlineSubsystemSteamworks.u', 'RCam.u',
  'RefShaderCache-Dingo.upk', 'RefShaderCache-PC-D3D-SM4.upk',
  'RefShaderCache-PC-D3D-SM5.upk', 'SubstanceAir.u', 'SubstanceAirEd.u',
  'UnrealEd.u', 'WebAdmin.u', 'WinDrv.u');
  // KF2 File types prefix
  KF_IGNOREMAPSENTRYS: array [1 .. 2] of string = ('KF-DebugItem',
  'KF-Default'); KF_MAPPREFIX = '.KFM';
  KF_MODPREFIX: array [0 .. 3] of string = ('.U', '.UPX', '.UC', '.UPK');
  KF_CYCLE_OFFICIAL_SEPARATOR =   '----- Official -----';
  KF_CYCLE_CUSTOM_SEPARATOR =    '------ Custom ------';

  // Workshop files paths and names
  WKP_ACFFILENAME = 'appworkshop_232090.acf';
{$IFDEF LINUX64}
  WKP_ACFFILEFOLDER = 'Binaries/Win64/steamapps/workshop/';
  WKP_CACHEFOLDER = 'Binaries/Win64/steamapps/workshop/content/232090';
  STEAMAPPCACHEFOLDER = 'Binaries/Win64'; SERVERCACHEFOLDER = 'KFGame/Cache/';
  WORKSHOPSUBITEM = 'steamapps/workshop/content/232090';
   IMGWEBFOLDER = 'KFGame/Web/images/maps/';
{$ELSE}
  WKP_ACFFILEFOLDER = 'Binaries\Win64\steamapps\workshop\';
  WKP_CACHEFOLDER = 'Binaries\Win64\steamapps\workshop\content\232090';
  STEAMAPPCACHEFOLDER = 'Binaries\Win64'; SERVERCACHEFOLDER = 'KFGame\Cache\';
  WORKSHOPSUBITEM = 'steamapps\workshop\content\232090';
  IMGCACHEFOLDER = 'imgs\';
  IMGWEBFOLDER = 'KFGame\Web\images\maps\';

{$ENDIF}
  KF_LOCALMAPSSUBFOLDER = 'KFGame' + PathDelim + 'BrewedPC' + PathDelim + 'Maps'
  + PathDelim; KF_BREWEDPCSSUBFOLDER = 'KFGame' + PathDelim + 'BrewedPC' +
  PathDelim; KF_SERVERCACHEFOLDER = 'KFGame' + PathDelim + 'Cache' + PathDelim;
   var
   KF_OFFICIALMAPS: array of string;
  implementation
function IsOfficialMap(mapName: String): Boolean;
var
  I: Integer;
begin
  result := False;
  if ExtractFileExt(mapName) = '' then mapName := mapName + '.kfm';

  for I := 0 to High(KF_OFFICIALMAPS) do
  begin
    if UpperCase(mapName) = UpperCase(KF_OFFICIALMAPS[I]) then
    begin
      result := true;
      Break;
    end;
  end;
end;

procedure LoadOfficialMapList(serverPath: string);
var imgsPathList: TStringlist;
i: Integer;
filename: string;
begin
  SetLength(KF_OFFICIALMAPS,0);
  imgsPathList := GetAllFilesInsideDirectory(serverPath + IMGWEBFOLDER, '*.jpg');
  for i := 0 to imgsPathList.Count - 1  do begin

    filename := TPath.GetFileNameWithoutExtension(imgsPathList[i]);
  if UpperCase(filename) <> 'NOIMAGE' then begin
     SetLength(KF_OFFICIALMAPS,Length(KF_OFFICIALMAPS) +1);
     KF_OFFICIALMAPS[High(KF_OFFICIALMAPS)] := filename + '.kfm';
  end;
  end;

  try

  finally
  if Assigned(imgsPathList) then
    FreeAndNil(imgsPathList);
  end;
end;
end.
