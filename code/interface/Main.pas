unit Main;

interface

uses
  Forms, Windows, SysUtils, Classes, Graphics, Controls,
  Dialogs, ComCtrls, JvComCtrls, StdCtrls,
  Menus,
  JvSpeedButton, IniFiles, KFServerTool,
  MiscFunc, ExtCtrls, Buttons, ShellAPI, frmDnt, Workshop, Clipbrd,
  JvgImage,
  KFWksp, JvColorButton,
  JvCombobox, JvEdit, IdBaseComponent,
  IdTCPClient, ImgList, OleCtrls,
  MSHTML, Variants, SHDocVw,
  ItemProgress, System.ImageList, JvExControls, JvColorBox,
  JvExStdCtrls, JvExComCtrls, Vcl.Themes, GitAutoUpdate, System.uitypes,
  downloaderTool,
  System.Net.HttpClient, System.Net.HttpClientComponent, Registry,
  System.Net.URLClient, System.Types;

type
  TLvSelectedItems = Array of TListItem;

  TFormMain = class(TForm)
    pmRemove: TPopupMenu;
    RemoveGameSteamCache1: TMenuItem;
    RemovefromCycle1: TMenuItem;
    RemoveMapEntry1: TMenuItem;
    Removeall1: TMenuItem;
    il1: TImageList;
    RemoveServerSubcribe1: TMenuItem;
    pmLV: TPopupMenu;
    add1: TMenuItem;
    Remove1: TMenuItem;
    Browserworkshop1: TMenuItem;
    AddbyID1: TMenuItem;
    Manual1: TMenuItem;
    allfilesandentry1: TMenuItem;
    cache1: TMenuItem;
    Mapentry1: TMenuItem;
    MapCycle1: TMenuItem;
    Subcribe1: TMenuItem;
    Forceupdate1: TMenuItem;
    Reinstall1: TMenuItem;
    N1: TMenuItem;
    lblCredits: TLabel;
    pnl1: TPanel;
    lblDonate: TLabel;
    btnReinstall: TBitBtn;
    btnUpdate: TBitBtn;
    mniCopyID1: TMenuItem;
    mniShowitempage1: TMenuItem;
    mniN2: TMenuItem;
    jvpgcntrl1: TJvPageControl;
    tsMods: TTabSheet;
    lvMods: TListView;
    tsServer: TTabSheet;
    grpStartServer: TGroupBox;
    JvgBitmapImage1: TJvgBitmapImage;
    tsExtra: TTabSheet;
    grpEnableDisable: TGroupBox;
    tsUnknowed: TTabSheet;
    lvUnknowed: TListView;
    grpapplication: TGroupBox;
    lblFontSize: TLabel;
    trckbrFontSize: TTrackBar;
    pnl3: TPanel;
    btnNewProfile: TButton;
    btnRenameProfile: TButton;
    btnDeleteProfile: TButton;
    cbbProfile: TComboBox;
    lblProfile: TLabel;
    pnl4: TPanel;
    pnl5: TPanel;
    pnl6: TPanel;
    pnlmap: TPanel;
    pnldifficulty: TPanel;
    cbbMap: TComboBox;
    lblMap: TLabel;
    cbbDifficulty: TComboBox;
    lblDifficulty: TLabel;
    pnlgamelenght: TPanel;
    cbbLength: TComboBox;
    lblGameLength: TLabel;
    pnl10: TPanel;
    lblAddParam: TLabel;
    edtExtra: TEdit;
    edtGmPass: TEdit;
    lblGamePass: TLabel;
    btnStartServer: TButton;
    tsNotes: TTabSheet;
    lbl1: TLabel;
    mmoNotepad: TMemo;
    grpmaintenance: TGroupBox;
    btnCheckForUpdate: TButton;
    btnCleanDownloadCache: TButton;
    btnCheckForPreview: TButton;
    lbl6: TLabel;
    lbl7: TLabel;
    btnCleanWorkshopData: TButton;
    tswebadmin: TTabSheet;
    wb1: TWebBrowser;
    tmrWebAdmin: TTimer;
    chkAutoConnectWeb: TCheckBox;
    lblAllChangesWillbe: TLabel;
    pmAdd: TPopupMenu;
    AddWorkshopMap: TMenuItem;
    AddWorkshopIDorURL: TMenuItem;
    Multipleitems1: TMenuItem;
    AddManualEntry: TMenuItem;
    lblGameMode: TLabel;
    cbbGameMode: TComboBox;
    lblLanguage: TLabel;
    cbbLanguage: TJvComboBox;
    tsDebug: TTabSheet;
    btn1: TButton;
    btn2: TButton;
    edtDebugID: TEdit;
    edtDebugItemName: TEdit;
    lbl4: TLabel;
    lbl8: TLabel;
    btn3: TButton;
    btn4: TButton;
    lbl9: TLabel;
    chkOnlyFromConfigItems: TCheckBox;
    btn5: TButton;
    Redirect1: TMenuItem;
    ManualEntry1: TMenuItem;
    pnl7: TPanel;
    edtPort: TJvEdit;
    lblDescWebPort: TLabel;
    lblDescWebAdmin: TLabel;
    cbStatusWeb: TJvComboBox;
    lblWkspDownMan: TLabel;
    cbWorkshopDMStatus: TJvComboBox;
    Panel1: TPanel;
    lblRedirectURL: TLabel;
    lblCustomRedirect: TLabel;
    edtRedirectURL: TJvEdit;
    cbbRedirectEnabled: TJvComboBox;
    FromRedirect1: TMenuItem;
    N2: TMenuItem;
    lblHelpAdditionParam: TLabel;
    Export1: TMenuItem;
    Explorerlocalfolder1: TMenuItem;
    FromList1: TMenuItem;
    edtWebPass: TJvEdit;
    lblWebPass: TLabel;
    chkAutoLoginAdmin: TCheckBox;
    lblTheme: TLabel;
    cbbTheme: TJvComboBox;
    btnAddNew: TBitBtn;
    btnRemove: TBitBtn;
    chkAutoCheckForUpdates: TCheckBox;
    tsMaps: TTabSheet;
    pnl2: TPanel;
    lblSearch: TLabel;
    edtSearch: TEdit;
    lvMaps: TListView;
    procedure AddWorkshopClick(Sender: TObject);
    procedure Removeall1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure AddWorkshopIDorURLClick(Sender: TObject);
    procedure pmRemovePopup(Sender: TObject);
    procedure RemoveGameSteamCache1Click(Sender: TObject);
    procedure RemovefromCycle1Click(Sender: TObject);
    procedure RemoveMapEntry1Click(Sender: TObject);
    procedure RemoveServerSubcribe1Click(Sender: TObject);
    procedure btnReinstallClick(Sender: TObject);
    procedure pmLVPopup(Sender: TObject);
    procedure lvClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure lblDonateClick(Sender: TObject);
    procedure jvpgcntrl1Change(Sender: TObject);
    procedure btnStartServerClick(Sender: TObject);
    procedure lblsasdadClick(Sender: TObject);
    procedure mniShowitempage1Click(Sender: TObject);
    procedure mniCopyID1Click(Sender: TObject);
    procedure lvMapsColumnClick(Sender: TObject; Column: TListColumn);
    procedure lvCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer;
      var Compare: Integer);
    procedure edtSearchChange(Sender: TObject);
    procedure cbbProfileChange(Sender: TObject);
    procedure btnNewProfileClick(Sender: TObject);
    procedure btnDeleteProfileClick(Sender: TObject);
    procedure btnRenameProfileClick(Sender: TObject);
    procedure cbbMapChange(Sender: TObject);
    procedure cbbDifficultyChange(Sender: TObject);
    procedure cbbLengthChange(Sender: TObject);
    procedure edtExtraChange(Sender: TObject);
    procedure edtGmPassChange(Sender: TObject);
    procedure trckbrFontSizeChange(Sender: TObject);
    procedure btnCheckForUpdateClick(Sender: TObject);
    procedure cbb1Change(Sender: TObject);
    procedure cbWorkshopDMStatusChange(Sender: TObject);
    procedure cbStatusWebChange(Sender: TObject);
    procedure edtPortExit(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure btnCheckForPreviewClick(Sender: TObject);
    procedure btnCleanDownloadCacheClick(Sender: TObject);
    procedure btnCleanWorkshopDataClick(Sender: TObject);
    procedure tmrWebAdminTimer(Sender: TObject);
    procedure chkAutoConnectWebClick(Sender: TObject);
    procedure Multipleitems1Click(Sender: TObject);
    function getSelectedCount(ListView: TListView): Integer;
    procedure lvMapsCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure cbbGameModeChange(Sender: TObject);
    procedure cbbLanguageChange(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure checkForUpdates(Sender: TObject);
    procedure lostFocusSave(Sender: TObject);
    procedure chkOnlyFromConfigItemsClick(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure edtRedirectURLExit(Sender: TObject);
    procedure cbbRedirectEnabledCloseUp(Sender: TObject);
    procedure FromRedirect1Click(Sender: TObject);
    procedure btnAddNewClick(Sender: TObject);
    procedure edtExtraEnter(Sender: TObject);

    procedure Export1Click(Sender: TObject);
    procedure FromList1Click(Sender: TObject);
    procedure Explorerlocalfolder1Click(Sender: TObject);
    procedure edtWebPassExit(Sender: TObject);
    procedure chkAutoLoginAdminClick(Sender: TObject);
    procedure wb1DocumentComplete(ASender: TObject; const pDisp: IDispatch;
      const URL: OleVariant);
    procedure cbbThemeChange(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure chkAutoCheckForUpdatesClick(Sender: TObject);

  private
    function loadConfig: Boolean;
    function saveconfig: Boolean;
    procedure LoadItensToLv(Filter: String);
    procedure TranstaleToBR;
    procedure LoadServerProfile;
    procedure LoadUIConfig;
    procedure InstallServer(Path: String);
    function CheckForServerRunningAndClose: Boolean;
    function GetLVSelectedItems(ListView: TListView): TLvSelectedItems;
    function IsDiffCategory(lvitems: TLvSelectedItems): Boolean;
    procedure autoLoginWb;
    procedure RedirectDownloadProgress(currentPosition: Int64);
    procedure RedirectDownloadStarted(fileSize: Int64);
    procedure RedirectDownloadFinished();
    procedure alignControlAtoControlB(elementA, elementB: TControl);
    procedure checkAutoWebLoginRequirements;
    procedure CheckIfTheServerIsRuning;
    procedure InstallRegBrowserKey;
    procedure CheckDependencies;

  var
    ActiveLV: TListView;
    Descending: Boolean;
    SortedColumn: Integer;
    frmProgress: TformPB;

  const

    MEMONAME = 'KF2ServerTool.text';
    UPDATEPARAM = '-installupdate';
    { Private declarations }
  public
  var
    pathKFGameIni, pathKFEngineIni, pathKFWebIni, pathCmdTool, customServerPath,
      pathServerEXE: string;
    useCustomServerPath, AutoConnectWeb, appMaximized: Boolean;
    onlyFromConfigItems: Boolean;
    appLanguage: string;
    appWidth: Integer;
    appHeight: Integer;
    fontSize: Integer;
    defaultProfile: Integer;
    configName: String;
    autoLoginWebAdmin: Boolean;
    { Public declarations }
    serverTool: TKFServerTool;
    kfprofiles: array of TKFServerProfile;
    fdefaultStyleName: String;
    AutoCheckForUpdates: Boolean;
  end;

var
  FormMain: TFormMain;

implementation

uses
  AddItem, PathDialog, Queue, uRedirectItemsDialog;
{$R *.dfm}

procedure TFormMain.AddWorkshopClick(Sender: TObject);
var
  frmAdd: TFormAdd;
  frmWksp: TFormWorkshop;
  textToFind: string;
  itemID: string;
  isMod: Boolean;
  lgFindAItemWksp, lgSearchFor: string;
  mdResult: Integer;
  progressForm: TformPB;

begin
  if appLanguage = 'BR' then
  begin
    lgFindAItemWksp := 'Buscar na workshop';
    lgSearchFor := 'Buscar por';
  end
  else
  begin
    lgFindAItemWksp := 'Find an item in workshop';
    lgSearchFor := 'Search for';
  end;
  if InputQuery(lgFindAItemWksp, lgSearchFor, textToFind) then
  begin

    frmWksp := TFormWorkshop.Create(Self);

    try
      isMod := ActiveLV = lvMods;
      if isMod then
      begin

        itemID := frmWksp.BrowserItem(TWkspType.WorkshopMod, textToFind)
      end
      else
      begin
        itemID := frmWksp.BrowserItem(TWkspType.WorkshopMap, textToFind)
      end;
      if itemID <> '' then
      begin

        frmAdd := TFormAdd.Create(Self);
        try
          CheckIfTheServerIsRuning;
          if isMod then
          begin
            frmAdd.SetAddType(TKFItemType.WorkshopItem);
          end
          else
          begin
            frmAdd.SetAddType(TKFItemType.WorkshopMap);
          end;
          frmAdd.edtID.Text := itemID;
          mdResult := frmAdd.ShowModal;
          if mdResult = mrOk then
          begin
            progressForm := TformPB.Create(Self);
            try
              progressForm.NextPBValue('Installing item ' + itemID);
              progressForm.tmrUndeterminedPB.Enabled := True;
              progressForm.Show;
              Application.ProcessMessages;
              if serverTool.InstallWorkshopItem(frmAdd.edtID.Text,
                frmAdd.ItemName, frmAdd.addWkspRedirect, frmAdd.downloadNow,
                frmAdd.addMapCycle, frmAdd.addMapENtry) = false then
              begin
                Application.MessageBox
                  (PWideChar('One o more steps for item ' + frmAdd.edtID.Text +
                  ' falied!'), '', MB_OK + MB_ICONEXCLAMATION);

              end;
              progressForm.Close;
            finally
              progressForm.Free;
            end;

          end;

        finally
          frmAdd.Free;
        end;
      end;
    finally
      frmWksp.Free;
      LoadItensToLv('');
    end;

  end;

end;

procedure TFormMain.AddWorkshopIDorURLClick(Sender: TObject);
var
  frmAdd: TFormAdd;
  inputText: String;
  itemID: string;
  lgAddWkspItem, lgWkspIdUrl, lgInvalidUrlID: string;
  mdResult: Integer;
  progressForm: TformPB;
begin

  if appLanguage = 'BR' then
  begin
    lgAddWkspItem := 'Adicionar item da Workshop';
    lgWkspIdUrl := 'ID ou URL da Workshop:';
    lgInvalidUrlID := 'ID/URL inválidos';
  end
  else
  begin
    lgAddWkspItem := 'Add Workshop item';
    lgWkspIdUrl := 'Workshop ID or URL:';
    lgInvalidUrlID := 'Invalid ID/URL';
  end;

  if InputQuery(lgAddWkspItem, lgWkspIdUrl, inputText) then
  begin
    if Length(inputText) <= 11 then
    begin
      itemID := cleanInt(inputText)
    end
    else
    begin
      itemID := WorkshopURLtoID(inputText);
    end;

    if Length(itemID) > 4 then
    begin

      frmAdd := TFormAdd.Create(Self);
      try
        frmAdd.edtID.Text := itemID;
        if ActiveLV = lvMaps then
        begin
          frmAdd.SetAddType(TKFItemType.WorkshopMap);
        end
        else
        begin
          frmAdd.SetAddType(TKFItemType.WorkshopItem);
        end;

        mdResult := frmAdd.ShowModal;

        if mdResult = mrOk then
        begin
          progressForm := TformPB.Create(Self);
          CheckIfTheServerIsRuning;
          try
            progressForm.NextPBValue('Installing item ' + itemID);
            progressForm.Show;
            progressForm.tmrUndeterminedPB.Enabled := True;
            if serverTool.InstallWorkshopItem(frmAdd.edtID.Text,
              frmAdd.ItemName, frmAdd.addWkspRedirect, frmAdd.downloadNow,
              frmAdd.addMapCycle, frmAdd.addMapENtry) = false then
            begin
              Application.MessageBox
                (PWideChar('One o more steps for item ' + frmAdd.edtID.Text +
                ' falied!'), '', MB_OK + MB_ICONEXCLAMATION);

            end;
          finally
            progressForm.Free;
          end;
        end;

      finally
        frmAdd.Free;
        LoadItensToLv('');
      end;
    end
    else
    begin

      Application.MessageBox(PWideChar(lgInvalidUrlID), 'Error',
        MB_OK + MB_ICONWARNING);

    end;

  end;

end;

procedure TFormMain.btnStartServerClick(Sender: TObject);
var
  svPath: string;
  argCmd: string;
  lgAInstaceIsRun, lgBeforeSelect: string;
begin
  saveconfig;
  if appLanguage = 'BR' then
  begin
    lgAInstaceIsRun := 'Um processo do servidor já está em execução' + #13#10 +
      'Deseja fechar este antes';
    lgBeforeSelect := 'Antes de iniciar o servidor selecione um mapa';
  end
  else
  begin
    lgAInstaceIsRun := 'An instace of server is already running.' + #13#10 +
      'Do you wanna kill this process before?';
    lgBeforeSelect := 'Select a map before start the server';
  end;

  if ProcessExists(ExtractFileName(pathServerEXE)) then
  begin

    case Application.MessageBox(PWideChar(lgAInstaceIsRun), 'Server',
      MB_YESNOCANCEL + MB_ICONINFORMATION) of
      IDCANCEL:
        begin
          Exit;
        end;
      IDYES:
        begin
          KillProcessByName(ExtractFileName(pathServerEXE));
          Sleep(1000);
        end;
    end;

  end
  else
  begin

  end;

  if cbbMap.Text <> '' then
  begin

    if useCustomServerPath then
    begin
      svPath := IncludeTrailingPathDelimiter(customServerPath);
    end
    else
    begin
      svPath := ExtractFilePath(Application.ExeName);
    end;
    argCmd := cbbMap.Text;
    argCmd := argCmd + '?Difficulty=' + IntToStr(cbbDifficulty.ItemIndex);
    argCmd := argCmd + '?GameLength=' + IntToStr(cbbLength.ItemIndex);
    if edtGmPass.Text <> '' then
      argCmd := argCmd + '?GamePassword=' + edtGmPass.Text;
    if edtExtra.Text <> '' then
      argCmd := argCmd + edtExtra.Text;
    case cbbGameMode.ItemIndex of
      0:
        argCmd := argCmd + '?game=KFGameContent.KFGameInfo_Endless';
      1:
        argCmd := argCmd + '?game=KFGameContent.KFGameInfo_Survival';
      2:
        argCmd := argCmd + '?game=KFGameContent.KFGameInfo_VersusSurvival';
      3:
        argCmd := argCmd + '?game=KFGameContent.KFGameInfo_WeeklySurvival';
      4:
        begin
          if (Pos('GAME=', UpperCase(edtExtra.Text)) <= 0) then
            Application.MessageBox
              ('You have set the game mode to custom but you won''t ' + #13 +
              'specified the custom game in additional parameters',
              'Invalid custom game mod', MB_OK + MB_ICONWARNING);

        end;
    end;

    // ShowMessage(argCmd);
    ShellExecute(handle, 'open', Pchar(pathServerEXE), Pchar(argCmd),
      Pchar(svPath), SW_SHOWNORMAL);

    if (chkAutoConnectWeb.Checked) and (cbStatusWeb.ItemIndex = 1) then
      tmrWebAdmin.Enabled := True;
  end
  else
  begin
    Application.MessageBox(PWideChar(lgBeforeSelect), 'Map',
      MB_OK + MB_ICONINFORMATION);

  end;

end;

procedure TFormMain.btn1Click(Sender: TObject);
begin
  serverTool.AddWorkshopSubcribe(edtDebugID.Text);
end;

procedure TFormMain.btn2Click(Sender: TObject);
begin
  serverTool.DownloadWorkshopItem(edtDebugID.Text);
end;

procedure TFormMain.btn3Click(Sender: TObject);
begin
  serverTool.addMapCycle(edtDebugItemName.Text);
end;

procedure TFormMain.btn4Click(Sender: TObject);
begin
  serverTool.addMapENtry(edtDebugItemName.Text);
end;

procedure TFormMain.btn5Click(Sender: TObject);
var
  frmRedirect: TfrmRedirectItemsDialog;
begin
  frmRedirect := TfrmRedirectItemsDialog.Create(Self);
  frmRedirect.ShowModal;
  frmRedirect.Free;

end;

procedure TFormMain.btnAddNewClick(Sender: TObject);
begin
  try
    with (Sender as TBitBtn).ClientToScreen
      (point(0, (Sender as TBitBtn).Height)) do
      pmAdd.Popup(X, Y);
  except

  end;
end;

procedure TFormMain.btnCheckForPreviewClick(Sender: TObject);
var
  i: Integer;
  cmdToolFullPath, cmdToolArgs: string;
  serverpath: string;
begin
  i := Application.MessageBox
    ('This will check for a BETA PREVIEW server update.' + #13 +
    ' If it''s avaliable the server will be updated.' + #13#10 +
    'Are you sure?', 'Update server to BETA/PREVIEW',
    MB_OKCANCEL + MB_ICONQUESTION);

  if i = IDOK then
  begin
    if useCustomServerPath then
      serverpath := IncludeTrailingPathDelimiter(customServerPath)
    else
      serverpath := ExtractFilePath(Application.ExeName);

    cmdToolFullPath := serverpath + pathCmdTool;
    cmdToolArgs := '+login anonymous +force_install_dir ' + serverpath +
      ' +app_update 232130 -beta preview +exit';
    ExecuteFileAndWait(Self.handle, cmdToolFullPath, cmdToolArgs, SW_NORMAL);

    Application.MessageBox('Finished', 'Server update',
      MB_OK + MB_ICONINFORMATION);

  end;
end;

procedure TFormMain.btnCheckForUpdateClick(Sender: TObject);
var
  i: Integer;
  cmdToolFullPath, cmdToolArgs: string;
  serverpath: string;
begin
  i := Application.MessageBox('This will check for a server update.' + #13 +
    ' If it''s avaliable the server will be updated.' + #13#10 +
    'Are you sure?', 'Update server', MB_OKCANCEL + MB_ICONQUESTION);

  if i = IDOK then
  begin
    if useCustomServerPath then
      serverpath := IncludeTrailingPathDelimiter(customServerPath)
    else
      serverpath := ExtractFilePath(Application.ExeName);

    cmdToolFullPath := serverpath + pathCmdTool;
    cmdToolArgs := '+login anonymous +force_install_dir ' + serverpath +
      ' +app_update 232130 +exit';
    ExecuteFileAndWait(Self.handle, cmdToolFullPath, cmdToolArgs, SW_NORMAL);

    Application.MessageBox('Finished', 'Server update',
      MB_OK + MB_ICONINFORMATION);

  end;

end;

procedure TFormMain.btnCleanDownloadCacheClick(Sender: TObject);
var
  i: Integer;

  DeleteFolder: TStringList;
  serverpath: String;
begin
  i := Application.MessageBox('This will erase all data in cache folder.' +
    #13#10 + 'Are you sure?', 'Clean download cache',
    MB_OKCANCEL + MB_ICONEXCLAMATION);
  if i = IDOK then
  begin

    DeleteFolder := TStringList.Create;
    try
      if useCustomServerPath then
        serverpath := IncludeTrailingPathDelimiter(customServerPath)
      else
        serverpath := ExtractFilePath(Application.ExeName);
      DeleteFolder.Add(serverpath + 'KFGame\Cache\');
      FileOperation(DeleteFolder, '', FO_DELETE);
    finally
     FreeAndNil(DeleteFolder);
    end;
    Application.MessageBox('Finished', 'Clear cache',
      MB_OK + MB_ICONINFORMATION);

  end;

end;

procedure TFormMain.btnCleanWorkshopDataClick(Sender: TObject);
var
  i: Integer;
  DeleteFolder: TStringList;
  wkspacf: TStringList;
  serverpath: String;
begin
  i := Application.MessageBox('This will erase the workshop data base file.' +
    #13#10 + 'Are you sure?', 'Clean download cache',
    MB_OKCANCEL + MB_ICONEXCLAMATION);
  if i = IDOK then
  begin
    DeleteFolder := TStringList.Create;
    wkspacf := TStringList.Create;
    try
      if useCustomServerPath then
        serverpath := IncludeTrailingPathDelimiter(customServerPath)
      else
        serverpath := ExtractFilePath(Application.ExeName);
      DeleteFolder.Add(serverpath +
        'Binaries\Win64\steamapps\workshop\content\232090');
      FileOperation(DeleteFolder, '', FO_DELETE);
      serverTool.CreateBlankACFFile;
    finally
      FreeAndNil(DeleteFolder);
      FreeAndNil(wkspacf);
    end;
    Application.MessageBox('Finished', 'Clear cache',
      MB_OK + MB_ICONINFORMATION);
  end;
end;

procedure TFormMain.CheckDependencies;
var
  steamcmdpath: String;
begin
  steamcmdpath := ExtractFilePath(Application.ExeName) + pathCmdTool;
  if not FileExists(steamcmdpath) then
  begin
    raise Exception.Create('SteamCmd tool not found. ' + #13 + #13 +
      'Your installation of kf2servertool is incomplete.' + #13 +
      'The steamcmd tool is missing in the path ' + #13 + steamcmdpath + #13 +
      'Reinstall the tool and start the application again.');
    Exit;
  end;

end;

procedure TFormMain.btnDeleteProfileClick(Sender: TObject);
var
  TitleDelete, TextDelete: String;
  i: Integer;
begin
  if appLanguage = 'BR' then
  begin
    TitleDelete := 'Remover perfil';
    TextDelete := 'Você tem certeza que deseja remover este perfil?';
  end
  else
  begin
    TitleDelete := 'Remove profile';
    TextDelete := 'Are you sure you want to delete this profile?';
  end;

  if Application.MessageBox(Pchar(TextDelete), Pchar(TitleDelete),
    MB_OKCANCEL + MB_ICONWARNING) = IDOK then
  begin
    kfprofiles[cbbProfile.ItemIndex].Free;
    for i := cbbProfile.ItemIndex to High(kfprofiles) - 1 do
      kfprofiles[i] := kfprofiles[i + 1];
    SetLength(kfprofiles, Length(kfprofiles) - 1);
    defaultProfile := 0;
    LoadServerProfile;
  end;

end;

procedure TFormMain.InstallServer(Path: String);
var
  cmdToolFullPath, cmdToolArgs: string;
begin
  cmdToolFullPath := ExtractFilePath(Application.ExeName) + pathCmdTool;
  cmdToolArgs := '+login anonymous +force_install_dir ' + Path +
    ' +app_update 232130 +exit';
  ExecuteFileAndWait(Self.handle, cmdToolFullPath, cmdToolArgs, SW_NORMAL);
end;

procedure TFormMain.btnNewProfileClick(Sender: TObject);
var
  newItemTitle, newItemText, newItemError, newItemError1, newName: String;
  inputResult: Boolean;
begin
  if appLanguage = 'BR' then
  begin
    newItemTitle := 'Adicionar novo perfil';
    newItemText := 'Nome do perfil';
    newItemError := 'Você precisa informar um nome para o perfil';
    newItemError1 := 'Erro';
  end
  else
  begin
    newItemTitle := 'Add new profile';
    newItemText := 'Profile name';
    newItemError := 'You must type in a name for the profile';
    newItemError1 := 'Error';

  end;

  repeat
    inputResult := InputQuery(newItemTitle, newItemText, newName);
    if inputResult then
    begin
      if newName = '' then
      begin
        Application.MessageBox(Pchar(newItemError), Pchar(newItemError1),
          MB_OK + MB_ICONSTOP);

      end
      else
      begin
        SetLength(kfprofiles, Length(kfprofiles) + 1);
        kfprofiles[High(kfprofiles)] := TKFServerProfile.Create;
        defaultProfile := High(kfprofiles);
        with kfprofiles[defaultProfile] do
        begin
          ProfileName := newName;
          DefaultDifficulty := 0;
          DefaultLength := 0;
          DefaultPass := '';
          AdditionalParam := '';
          DefaultMap := '';

        end;
        LoadServerProfile;

      end;

    end;

  until (newName <> '') or (inputResult = false);

end;

procedure TFormMain.btnReinstallClick(Sender: TObject);
var
  ItemName: string;
  itemID: string;
  frmReinstall: TFormAdd;
  slItemsCount, i: Integer;
  itemsDone: Integer;
  modalResult: Integer;
  selectedItems: TLvSelectedItems;
  progressForm: TformPB;
begin

  if ActiveLV.Selected = nil then
  begin
    ShowMessage('Select an item first.');
    Exit;
  end
  else
  begin
    slItemsCount := getSelectedCount(ActiveLV);
    itemsDone := 0;
    modalResult := mrNone;
    selectedItems := GetLVSelectedItems(ActiveLV);
    frmReinstall := TFormAdd.Create(Self);
    try
      if IsDiffCategory(selectedItems) then
      begin
        ShowMessage
          ('You can not reinstall multiple items of different types. Select items of only one type.');
        Exit
      end;
      progressForm := TformPB.Create(Self);
      progressForm.SetPBMax(slItemsCount);
      progressForm.btncancel.Visible := True;
      progressForm.Show;
      CheckIfTheServerIsRuning;
      try
        for i := 0 to High(selectedItems) do
        begin
          try
            // For more than one item
            ItemName := selectedItems[i].Caption;
            itemID := selectedItems[i].SubItems[0];
            if ActiveLV = lvMaps then
            begin
              if (ItemName <> '') and (itemID <> '') then
              begin
                frmReinstall.SetAddType(TKFItemType.ReinstallWorkshopMap);

              end
              else
              begin
                case selectedItems[i].GroupID of
                  0:
                    frmReinstall.SetAddType(TKFItemType.WorkshopMap);

                  1:
                    frmReinstall.SetAddType(TKFItemType.OfficialItem);
                  2:
                    frmReinstall.SetAddType(TKFItemType.LocalOrRedirectItem);
                else
                  raise Exception.Create('Unknowed Group ID');
                end;

              end;
            end
            else if ActiveLV = lvMods then
            begin
              if (ItemName <> '') and (itemID <> '') then
                frmReinstall.SetAddType(TKFItemType.ReinstallWorkshopItem)
              else
                frmReinstall.SetAddType(TKFItemType.WorkshopItem);
            end
            else if ActiveLV = lvUnknowed then
            begin
              frmReinstall.SetAddType(TKFItemType.UnknowedWorkshopItem)

            end;

            frmReinstall.edtID.Text := itemID;
            frmReinstall.ItemName := ItemName;
            frmReinstall.edtID.Enabled := false;
            frmReinstall.Caption := 'Reinstall ' + ItemName;
            if slItemsCount > 1 then
            begin
              frmReinstall.chkDoForAll.Visible := True;
              if appLanguage = 'BR' then
              begin
                frmReinstall.chkDoForAll.Caption :=
                  'Fazer isso para os próximos ' +
                  IntToStr(slItemsCount - itemsDone) + ' itens';
              end
              else
              begin
                frmReinstall.chkDoForAll.Caption := 'Do the same for the next '
                  + IntToStr(slItemsCount - itemsDone) + ' items';
              end;

              if modalResult <> mrAll then
              begin
                modalResult := frmReinstall.ShowModal;
                if modalResult = mrCancel then
                  Exit;

              end;

              if (modalResult = mrOk) or (modalResult = mrAll) then
              begin
                if progressForm.cancel then
                  Break;

                progressForm.NextPBValue(IntToStr(i + 1) + '/' +
                  IntToStr(High(selectedItems)) + ' Installing item ' + itemID);
                if serverTool.InstallWorkshopItem(frmReinstall.edtID.Text,
                  frmReinstall.ItemName, frmReinstall.addWkspRedirect,
                  frmReinstall.downloadNow, frmReinstall.addMapCycle,
                  frmReinstall.addMapENtry) = false then
                begin
                  Application.MessageBox
                    (PWideChar('One o more steps for item ' +
                    frmReinstall.edtID.Text + ' falied!'), '',
                    MB_OK + MB_ICONEXCLAMATION);

                end;
              end
              else
              begin
                Break;
              end;

              itemsDone := itemsDone + 1;
            end
            else
            begin
              // Just one item
              modalResult := frmReinstall.ShowModal;
              if (modalResult = mrOk) then
              begin

                progressForm.NextPBValue('Installing item ' + itemID);

                if serverTool.InstallWorkshopItem(frmReinstall.edtID.Text,
                  frmReinstall.ItemName, frmReinstall.addWkspRedirect,
                  frmReinstall.downloadNow, frmReinstall.addMapCycle,
                  frmReinstall.addMapENtry) = false then
                begin
                  Application.MessageBox
                    (PWideChar('One o more steps for item ' +
                    frmReinstall.edtID.Text + ' falied!'), '',
                    MB_OK + MB_ICONEXCLAMATION);

                end;

              end
              else
              begin
                LoadItensToLv('');
                Exit;
              end;

            end;

          except
            on E: Exception do
              ShowMessage(E.Message);
          end;

        end;
      finally
        progressForm.Free;
      end;
      LoadItensToLv('');
      Application.MessageBox('Finished!', '', MB_OK + MB_ICONINFORMATION)
    finally
      frmReinstall.Free;
    end;

  end;
end;

procedure TFormMain.btnRemoveClick(Sender: TObject);
begin
  try
    with (Sender as TBitBtn).ClientToScreen
      (point(0, (Sender as TBitBtn).Height)) do
      pmRemove.Popup(X, Y);
  except

  end;
end;

procedure TFormMain.btnRenameProfileClick(Sender: TObject);
var
  renameItemTitle, renameItemText, newName, renameItemError,
    renameItemError1: String;
  inputResult: Boolean;
begin
  if appLanguage = 'BR' then
  begin
    renameItemTitle := 'Renomear perfil';
    renameItemText := 'Novo nome';
    renameItemError := 'Você precisa informar um novo item para o perfil';
    renameItemError1 := 'Erro';
  end
  else
  begin
    renameItemTitle := 'Rename profile';
    renameItemText := 'New name';
    renameItemError := 'You must type in a name for the profile';
    renameItemError1 := 'Error';
  end;
  repeat
    inputResult := InputQuery(renameItemTitle, renameItemText, newName);
    if inputResult then
    begin
      if newName = '' then
      begin
        Application.MessageBox(Pchar(renameItemError), Pchar(renameItemError1),
          MB_OK + MB_ICONSTOP);

      end
      else
      begin
        kfprofiles[defaultProfile].ProfileName := newName;
        LoadServerProfile;
      end;
    end;
  until (newName <> '') or (inputResult = false);

end;

function TFormMain.GetLVSelectedItems(ListView: TListView): TLvSelectedItems;
var
  i: Integer;
begin
  try
    SetLength(Result, 0);
    try
      for i := 0 to ListView.Items.Count - 1 do
      begin
        if ListView.Items[i].Selected then
        begin

          SetLength(Result, Length(Result) + 1);
          Result[High(Result)] := ListView.Items[i];
        end;
      end;
    finally

    end;
  except
    SetLength(Result, 0);
    raise Exception.Create('Falied to generate Seletec itens array');
  end;
end;

function TFormMain.IsDiffCategory(lvitems: TLvSelectedItems): Boolean;
var
  i: Integer;
begin
  Result := false;
  try
    try
      for i := 0 to High(lvitems) - 1 do
      begin
        if lvitems[i].GroupID <> lvitems[i + 1].GroupID then
        begin
          Result := True;
          Exit;

        end;
      end;
    finally

    end;
  except
    raise Exception.Create('Error getting selected cagegorys types');
  end;
end;

procedure TFormMain.btnUpdateClick(Sender: TObject);
var
  ItemName: string;
  itemID: string;
  slItems, i: Integer;
  dlgText: String;
  progressForm: TformPB;
  selectedItems: TLvSelectedItems;
begin
  if ActiveLV.Selected = nil then
  begin
    ShowMessage('Select na item first.');
    Exit;
  end
  else
  begin

    slItems := getSelectedCount(ActiveLV);
    selectedItems := GetLVSelectedItems(ActiveLV);
    try
      if slItems = 1 then
        dlgText := 'Force update?'
      else
        dlgText := 'Force update to ' + IntToStr(slItems) + ' selected items?';

      if messagedlg(dlgText, mtConfirmation, [mbYes, mbCancel], 0) = mrYes then
      begin
        progressForm := TformPB.Create(Self);
        progressForm.btncancel.Visible := True;
        progressForm.SetPBMax(slItems);
        try
          for i := 0 to High(selectedItems) do
          begin
            if progressForm.cancel then
              Break;

            ItemName := selectedItems[i].Caption;
            itemID := selectedItems[i].SubItems[0];
            if slItems = 1 then
              progressForm.NextPBValue(' Updating item ' + itemID + ' '
                + ItemName)
            else
              progressForm.NextPBValue(IntToStr(i + 1) + '/' + IntToStr(slItems)
                + ' Updating item ' + itemID);
            progressForm.Show;
            CheckIfTheServerIsRuning;
            serverTool.ForceUpdate(itemID, false);

          end;
          progressForm.Close;
        finally
          progressForm.Free;
        end;
        ShowMessage('Finished!');
        LoadItensToLv('');
      end;

    except
      on E: Exception do
        ShowMessage(E.Message);
    end;

  end;

end;

procedure TFormMain.chkAutoCheckForUpdatesClick(Sender: TObject);
begin
  AutoCheckForUpdates := chkAutoCheckForUpdates.Checked;
end;

procedure TFormMain.cbb1Change(Sender: TObject);
begin

  // sknmngr1.SkinName := cbb1.Text;
end;

procedure TFormMain.cbbDifficultyChange(Sender: TObject);
begin
  kfprofiles[defaultProfile].DefaultDifficulty := cbbDifficulty.ItemIndex;
end;

procedure TFormMain.cbbGameModeChange(Sender: TObject);
begin
  kfprofiles[defaultProfile].DefaultGameMode := cbbGameMode.ItemIndex;
  if (cbbGameMode.ItemIndex = 4) then
  begin
    if (Pos('?GAME=', UpperCase(edtExtra.Text)) <= 0) then
    begin
      Application.MessageBox
        ('Specify the gamemod param in additional paramenters.' + #13 + #13 +
        'Example: ?Game=CustomModGame.MyGame', 'Custom game mode set',
        MB_OK + MB_ICONINFORMATION);
      edtExtra.SetFocus;
    end;
  end
  else
  begin

    if Pos('?GAME=', UpperCase(edtExtra.Text)) > 0 then
      Application.MessageBox
        (PWideChar('You specified a custom game mode in additional parameters.'
        + #13 + 'Configuring ' + cbbGameMode.Text +
        ' as a game mode will cause the server to ignore' + #13 +
        'the custom game that you specified in Additional parameters box.'),
        'Custom game mode set', MB_OK + MB_ICONWARNING);

    ;
  end;

end;

procedure TFormMain.cbbLanguageChange(Sender: TObject);
begin
  if cbbLanguage.ItemIndex = 0 then
    appLanguage := 'EG'
  else
    appLanguage := 'BR';
  // ShowMessage('The application will be restarted');
  Application.Terminate;

  ShellExecute(Application.handle, 'Open', Pchar(Application.ExeName), nil, nil,
    SW_NORMAL);
end;

procedure TFormMain.cbbLengthChange(Sender: TObject);
begin
  kfprofiles[defaultProfile].DefaultLength := cbbLength.ItemIndex;
end;

procedure TFormMain.cbbMapChange(Sender: TObject);
begin
  kfprofiles[defaultProfile].DefaultMap := cbbMap.Items[cbbMap.ItemIndex];
end;

procedure TFormMain.cbbProfileChange(Sender: TObject);
begin
  // cb Server Length and Difficulty
  saveconfig();
  defaultProfile := cbbProfile.ItemIndex;
  LoadServerProfile();
  saveconfig();
end;

procedure TFormMain.cbbRedirectEnabledCloseUp(Sender: TObject);
begin
  if cbbRedirectEnabled.ItemIndex = 0 then
  begin
    edtRedirectURL.Text := '';
    try
      serverTool.SetCustomRedirect('');
    except
      on E: Exception do
        ShowMessage(E.Message);
    end;
    edtRedirectURL.Enabled := false;
    lblRedirectURL.Enabled := false;

  end
  else
  begin
    edtRedirectURL.Enabled := True;
    lblRedirectURL.Enabled := True;
    edtRedirectURL.SetFocus;
  end;
end;

procedure TFormMain.cbbThemeChange(Sender: TObject);
begin
  fdefaultStyleName := cbbTheme.Text;
  if Assigned(TStyleManager.ActiveStyle) then
  begin
    TStyleManager.TrySetStyle(fdefaultStyleName);
    // whatever was in the project settings.
  end;
end;

function TFormMain.CheckForServerRunningAndClose: Boolean;
var
  lgAInstaceIsRun: String;
begin
  Result := false;
  if ProcessExists(ExtractFileName(pathServerEXE)) then
  begin
    Result := True;
    if appLanguage = 'BR' then
    begin

      lgAInstaceIsRun :=
        'Servidor está está em execução, você precisa fecha-lo para poder fazer este tipo de modificação.'
        + #13#10 + 'Deseja fechar o server agora?';
    end
    else
    begin
      lgAInstaceIsRun :=
        'An instace of server is running, you need close it to make this kind of change.'
        + #13#10 + 'Do you wanna close the server now??';
    end;
    case Application.MessageBox(PWideChar(lgAInstaceIsRun), 'Server',
      MB_YESNOCANCEL + MB_ICONINFORMATION) of
      IDCANCEL:
        begin
          Result := True;
          Exit;
        end;
      IDYES:
        begin
          KillProcessByName(ExtractFileName(pathServerEXE));
          Sleep(1000);
          Result := false;
        end;
    end;

  end;
end;

procedure TFormMain.chkOnlyFromConfigItemsClick(Sender: TObject);
begin
  onlyFromConfigItems := chkOnlyFromConfigItems.Checked;
  LoadItensToLv('');
end;

procedure TFormMain.chkAutoConnectWebClick(Sender: TObject);
begin
  AutoConnectWeb := chkAutoConnectWeb.Checked;
end;

procedure TFormMain.chkAutoLoginAdminClick(Sender: TObject);
begin
  autoLoginWebAdmin := chkAutoLoginAdmin.Checked;
end;

procedure TFormMain.cbStatusWebChange(Sender: TObject);

begin
  try
    if CheckForServerRunningAndClose = false then
    begin
      if cbStatusWeb.ItemIndex = 0 then
        serverTool.SetWebStatus(false)
      else
        serverTool.SetWebStatus(True);

    end;
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TFormMain.cbWorkshopDMStatusChange(Sender: TObject);
begin
  try
    if cbWorkshopDMStatus.ItemIndex = 0 then
      serverTool.RemoveWorkshopManager
    else
      serverTool.InstallWorkshopManager;

  except
    on E: Exception do
      ShowMessage(E.Message);
  end;

end;

procedure TFormMain.edtExtraChange(Sender: TObject);
begin
  kfprofiles[defaultProfile].AdditionalParam := edtExtra.Text;
  if Pos('GAME=', UpperCase(edtExtra.Text)) > 0 then
    cbbGameMode.ItemIndex := 4;

end;

procedure TFormMain.edtExtraEnter(Sender: TObject);
begin
  lblHelpAdditionParam.Visible := True;
end;

procedure TFormMain.edtGmPassChange(Sender: TObject);
begin
  kfprofiles[defaultProfile].DefaultPass := edtGmPass.Text;
end;

procedure TFormMain.lostFocusSave(Sender: TObject);
begin
  lblHelpAdditionParam.Visible := false;
  saveconfig();
end;

procedure TFormMain.edtPortExit(Sender: TObject);
var
  Port: Integer;
begin
  if CheckForServerRunningAndClose = false then
  begin
    try
      edtPort.Text := cleanInt(edtPort.Text);
      Port := StrToInt(edtPort.Text);

    except
      ShowMessage('Invalid port number');
      edtPort.Text := '8080';
      Exit;
    end;
    try
      serverTool.SetWebPort(Port);
    except
      on E: Exception do
        ShowMessage(E.Message);
    end;

  end;
end;

procedure TFormMain.edtRedirectURLExit(Sender: TObject);
begin
  try
    serverTool.SetCustomRedirect(Trim(edtRedirectURL.Text));
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TFormMain.edtSearchChange(Sender: TObject);
begin
  LoadItensToLv(edtSearch.Text);
end;

procedure TFormMain.edtWebPassExit(Sender: TObject);
begin
  try
    serverTool.SetWebPass(edtWebPass.Text);
    checkAutoWebLoginRequirements();
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TFormMain.checkAutoWebLoginRequirements;
begin
  if edtWebPass.Text = '' then
  begin
    chkAutoLoginAdmin.Checked := false;
    chkAutoLoginAdmin.Enabled := false;
  end
  else
  begin
    chkAutoLoginAdmin.Enabled := True;
  end;
end;

procedure TFormMain.Explorerlocalfolder1Click(Sender: TObject);
var
  i: Integer;
  slItems: TLvSelectedItems;
  itemPath: String;
begin
  slItems := GetLVSelectedItems(ActiveLV);

  for i := 0 to High(slItems) do
  begin
    case slItems[i].GroupID of
      0:
        itemPath := serverTool.GetKFApplicationPath +
          TKFWorkshop.WKP_CACHEFOLDER + slItems[i].SubItems[0];
      1:
        itemPath := serverTool.GetKFApplicationPath +
          serverTool.KF_LOCALMAPSSUBFOLDER;
      2:
        itemPath := serverTool.GetKFApplicationPath +
          serverTool.KF_LOCALMAPSSUBFOLDER;
    end;
    ShellExecute(Application.handle, 'open', 'explorer.exe', Pchar(itemPath),
      nil, SW_NORMAL);
  end;

end;

procedure TFormMain.CheckIfTheServerIsRuning();
var
  warningText, serverRunning: string;
begin

  warningText := 'You should close the server before make changes. ' + #13#10 +
    'Do you wanna close it now?';
  serverRunning := 'Server is running';

  if serverTool.IsServerRunning then
  begin

    if serverTool.GetKFAppLanguage = KFServerTool.KFL_PORTUGUESE then
    begin
      warningText := 'Você precisa fechar o server antes de fazer alterações. '
        + #13#10 + 'Fecha-lo agora??';
      serverRunning := 'Server em execução';
    end;

    if Application.MessageBox(PWideChar(warningText), PWideChar(serverRunning),
      MB_YESNO + MB_ICONWARNING) = IDYES then
    begin
      serverTool.KillKFServer();
    end;

  end;
end;

procedure TFormMain.Export1Click(Sender: TObject);
var
  i: Integer;
  exportItems: Array of TKFItem;
  aKFItem: TKFItem;
  dlgOutputFile: TSaveDialog;
  itemsExported: Integer;
  selectedItems: TLvSelectedItems;
begin
  dlgOutputFile := TSaveDialog.Create(Self);

  try
    try
      SetLength(exportItems, 0);

      dlgOutputFile.FileName := 'MapListBackup.mapList';
      dlgOutputFile.Options := [ofFileMustExist];
      dlgOutputFile.Filter := 'KF2 MAP LIST BACKUP (*.mapList)|*.mapList';
      selectedItems := GetLVSelectedItems(ActiveLV);
      if IsDiffCategory(selectedItems) then
      begin
        ShowMessage('Select just one category of items and try again.');
        Exit;
      end;

      if dlgOutputFile.Execute(Self.handle) then
      begin

        for i := 0 to High(selectedItems) do
        begin

          aKFItem := TKFItem.Create;
          aKFItem.FileName := selectedItems[i].Caption;
          aKFItem.ID := selectedItems[i].SubItems[0];

          SetLength(exportItems, Length(exportItems) + 1);
          exportItems[High(exportItems)] := aKFItem;
        end;
        itemsExported := serverTool.ExportItemsList(exportItems,
          dlgOutputFile.FileName);
        if itemsExported > 0 then
        begin
          ShowMessage(IntToStr(itemsExported) +
            ' items exported successfully.');
        end;
      end;
    finally
      dlgOutputFile.Free;
    end;

  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TFormMain.LoadItensToLv(Filter: String);
var
  i: Integer;
  Item: TListItem;
  textYes, textNo: string;
  mapCycle: TStringList;
  ItemNameF, ItemIDF: string;

begin

  serverTool.LoadItems;
  textYes := '';
  textNo := '';
  lvMaps.Items.Clear;
  lvMods.Clear;
  lvUnknowed.Items.Clear;
  // lvSubscriptions.Clear;
  for i := 0 to High(serverTool.Items) do
  begin
    Filter := UpperCase(Filter);
    ItemNameF := UpperCase(serverTool.Items[i].FileName);
    ItemIDF := UpperCase(serverTool.Items[i].ID);

    if (Filter = '') or (Pos(Filter, ItemNameF) > 0) or
      (Pos(Filter, ItemIDF) > 0) then
    begin
      // Ignore cache files if the server is not subscribed
      if (onlyFromConfigItems) and (serverTool.Items[i].ServerCache) and
        (serverTool.Items[i].ServerSubscribe = false) then
      begin
        Continue;
      end;

      if serverTool.Items[i].ItemType = KFMod then
      begin
        Item := lvMods.Items.Add;
        Item.Caption := serverTool.Items[i].FileName;
        Item.SubItems.Add(serverTool.Items[i].ID);
        Item.SubItems.Add(BoolToWord(serverTool.Items[i].ServerSubscribe));
        Item.SubItems.Add(BoolToWord(serverTool.Items[i].ServerCache));
      end
      else
      begin
        if serverTool.Items[i].ItemType = KFMap then
          Item := lvMaps.Items.Add
        else
          Item := lvUnknowed.Items.Add;
        Item.ImageIndex := 3;
        Item.Caption := serverTool.Items[i].FileName;
        Item.SubItems.Add(serverTool.Items[i].ID);
        //ServerSubscription
        if serverTool.Items[i].ServerSubscribe then
        begin
          Item.SubItems.Add(textYes);
          Item.SubItemImages[1] := 0;
        end
        else
        begin
          Item.SubItems.Add(textNo);
          if serverTool.Items[i].SourceFrom = KFSteamWorkshop then
          begin

            if serverTool.Items[i].ItemType = KFUnknowed then
              Item.SubItemImages[1] := 4
            else
              Item.SubItemImages[1] := 1;
          end;

        end;
        //MapCycle
        if serverTool.Items[i].MapEntry then
        begin
          Item.SubItems.Add(textYes);
          Item.SubItemImages[2] := 0
        end
        else
        begin
          Item.SubItems.Add(textNo);
          if serverTool.Items[i].ItemType = KFUnknowed then
            Item.SubItemImages[2] := 4
          else
            Item.SubItemImages[2] := 1;
        end;
        //MapEntry
        if serverTool.Items[i].MapCycleEntry then
        begin
          Item.SubItems.Add(textYes);
          Item.SubItemImages[3] := 0
        end
        else
        begin
          Item.SubItems.Add(textNo);
          if serverTool.Items[i].ItemType = KFUnknowed then
            Item.SubItemImages[3] := 4
          else
            Item.SubItemImages[3] := 1;
        end;
         //ServerCache
        if serverTool.Items[i].ServerCache then
        begin
          Item.SubItems.Add(textYes);
          Item.SubItemImages[4] := 0
        end
        else
        begin
          Item.SubItems.Add(textNo);
          if serverTool.Items[i].ItemType = KFUnknowed then
            Item.SubItemImages[4] := 4
          else
            Item.SubItemImages[4] := 1;

        end;
        //Item group
        case serverTool.Items[i].SourceFrom of
          KFSteamWorkshop:
            Item.GroupID := 0;
          KFOfficial:
            Item.GroupID := 1;
          KFRedirectOrLocal:
            Item.GroupID := 2;
          KFUnknowedSource:
            Item.GroupID := 3;
        end;

      end;
      {
        //LvSubscriptions
        if serverTool.Items[i].ServerSubscribe then
        begin
        Item := lvSubscriptions.Items.Add;
        Item.Caption := serverTool.Items[i].ID;
        end;
        //LvMapEntrys
        if serverTool.Items[i].MapEntry then
        begin
        Item := lvMapEntrys.Items.Add;
        Item.Caption := serverTool.Items[i].FileName;
        end;
        //LvMapCycle
        if serverTool.Items[i].MapCycleEntry then
        begin
        Item := lvMapCycle.Items.Add;
        Item.Caption := serverTool.Items[i].FileName;
        end;
        //LvCache
        if serverTool.Items[i].ServerCache then
        begin
        Item := lvMapCycle.Items.Add;
        Item.Caption := serverTool.Items[i].FileName;
        Item.SubItems.Add(serverTool.Items[i].ID);
        end;
      }
    end;

  end;

  if lvUnknowed.Items.Count > 0 then
    tsUnknowed.TabVisible := True
  else
    tsUnknowed.TabVisible := false;
  // Map Cycle to combo box

  cbbMap.Clear;
  mapCycle := serverTool.GetGameCycle;
  try
    for i := 0 to mapCycle.Count - 1 do
      cbbMap.Items.Add(mapCycle[i]);
  finally
    FreeAndNil(mapCycle);
  end;

end;

procedure TFormMain.lvMapsColumnClick(Sender: TObject; Column: TListColumn);
begin
  TListView(Sender).SortType := stNone;
  if Column.Index <> SortedColumn then
  begin
    SortedColumn := Column.Index;
    Descending := false;
  end
  else
    Descending := not Descending;
  TListView(Sender).SortType := stText;
end;

procedure TFormMain.lvMapsCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if not(fdefaultStyleName <> 'Windows') then

    with lvMaps.Canvas.Brush do
    begin
      if (Item.Index mod 2) = 0 then
        Color := clInactiveBorder
      else
        Color := clWhite;
    end;
end;

procedure TFormMain.lvCompare(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
begin
  if SortedColumn = 0 then
    Compare := CompareText(Item1.Caption, Item2.Caption)
  else if SortedColumn <> 0 then
    Compare := CompareText(Item1.SubItems[SortedColumn - 1],
      Item2.SubItems[SortedColumn - 1]);
  if Descending then
    Compare := -Compare;
end;

procedure TFormMain.lvClick(Sender: TObject);
var
  selectedItems: TLvSelectedItems;
begin

  try
    if (ActiveLV.Selected <> nil) then
    begin
      selectedItems := GetLVSelectedItems(ActiveLV);
      if IsDiffCategory(selectedItems) then
      begin

        btnReinstall.Enabled := false;
        btnUpdate.Enabled := false;
        btnRemove.Enabled := false;
        Exit;
      end;

      if ActiveLV.Selected.GroupID = 0 then // Workshop
      begin
        btnReinstall.Enabled := True;
        btnReinstall.Visible := True;
        btnUpdate.Visible := True;
        btnUpdate.Enabled := True;
        btnRemove.Enabled := True;
        Removeall1.Visible := True;
        RemoveGameSteamCache1.Visible := True;
        RemoveMapEntry1.Visible := True;
        RemovefromCycle1.Visible := True;
        RemoveServerSubcribe1.Visible := True;
      end
      else if ActiveLV.Selected.GroupID = 1 then
      begin // Official
        btnReinstall.Enabled := True;
        btnReinstall.Visible := True;
        btnUpdate.Visible := false;
        btnUpdate.Enabled := false;
        btnRemove.Enabled := True;
        Removeall1.Visible := false;
        RemoveGameSteamCache1.Visible := false;
        RemoveMapEntry1.Visible := false;
        RemovefromCycle1.Visible := True;
        RemoveServerSubcribe1.Visible := false;
      end
      else if ActiveLV.Selected.GroupID = 2 then
      begin // Redirect or local
        btnReinstall.Enabled := True;
        btnReinstall.Visible := True;
        btnUpdate.Visible := false;
        btnUpdate.Enabled := false;
        btnRemove.Enabled := True;

        Removeall1.Visible := True;
        RemoveGameSteamCache1.Visible := True;
        RemoveMapEntry1.Visible := True;
        RemovefromCycle1.Visible := True;
        RemoveServerSubcribe1.Visible := false;

      end;

    end
    else
    begin

      btnReinstall.Enabled := false;
      btnUpdate.Enabled := false;
      btnRemove.Enabled := false;
    end;

  finally
    SetLength(selectedItems, 0);
  end;
end;

procedure TFormMain.mniCopyID1Click(Sender: TObject);
var
  itemsId: String;
  i: Integer;
  slItems: TLvSelectedItems;
begin
  itemsId := '';
  slItems := GetLVSelectedItems(ActiveLV);
  for i := 0 to High(slItems) do
  begin
    itemsId := itemsId + slItems[i].SubItems[0] + ' ';

    Clipboard.AsText := itemsId;

  end;
end;

procedure TFormMain.mniShowitempage1Click(Sender: TObject);
var
  i: Integer;
  slItems: TLvSelectedItems;
begin
  slItems := GetLVSelectedItems(ActiveLV);
  if ActiveLV.Selected <> nil then
  begin

    for i := 0 to High(slItems) do
    begin
      if slItems[i].Selected then
        ShellExecute(0, 'open',
          Pchar('https://steamcommunity.com/sharedfiles/filedetails/?id=' +
          slItems[i].SubItems[0]), nil, nil, SW_SHOWNORMAL);
    end;
  end;

end;

procedure TFormMain.Multipleitems1Click(Sender: TObject);
var
  frmQueue: TfrmQueue;
  isMod: Boolean;
begin
  frmQueue := TfrmQueue.Create(Self);
  isMod := ActiveLV = lvMods;
  try
    try
      if isMod then
      begin
        frmQueue.addType := TKFItemType.WorkshopItem;
      end
      else
      begin
        frmQueue.addType := TKFItemType.WorkshopMap;
      end;
      frmQueue.Font.Size := fontSize;
      frmQueue.ShowModal;
      LoadItensToLv('');
    finally
      frmQueue.Free;
    end;

  except
    on E: Exception do
      ShowMessage(E.Message);

  end;
end;

procedure TFormMain.pmLVPopup(Sender: TObject);
var
  selectedItems: TLvSelectedItems;
begin

  selectedItems := GetLVSelectedItems(ActiveLV);
  try
    if (ActiveLV = lvMaps) or (ActiveLV = lvUnknowed) then
    begin
      Mapentry1.Visible := True;
      MapCycle1.Visible := True;

    end
    else if ActiveLV = lvMods then
    begin
      Mapentry1.Visible := false;
      MapCycle1.Visible := false;
    end;

    if (ActiveLV.Selected = nil) or IsDiffCategory(selectedItems) then
    begin
      add1.Enabled := True;
      add1.Visible := True;
      Browserworkshop1.Enabled := True;
      AddbyID1.Enabled := True;
      Remove1.Enabled := false;
      allfilesandentry1.Enabled := false;
      cache1.Enabled := false;
      RemoveMapEntry1.Enabled := false;
      MapCycle1.Enabled := false;
      Subcribe1.Enabled := false;
      Forceupdate1.Enabled := false;
      Reinstall1.Enabled := false;
      mniShowitempage1.Visible := false;
      mniCopyID1.Visible := false;
    end
    else
    begin
      // ShowMessage(IntToStr( ActiveLV.Selected.SubItemImages[2]));

      if ActiveLV.Selected.GroupID = 0 then // Workshop
      begin
        Browserworkshop1.Enabled := True;
        Browserworkshop1.Visible := True;
        Remove1.Enabled := True;
        mniShowitempage1.Visible := True;
        mniCopyID1.Visible := True;
        Subcribe1.Visible := True;
        Forceupdate1.Visible := True;
        Subcribe1.Enabled := True;
        Forceupdate1.Enabled := True;
        allfilesandentry1.Enabled := True;
        cache1.Enabled := True;
        RemoveMapEntry1.Enabled := True;
        MapCycle1.Enabled := True;
        allfilesandentry1.Visible := True;
        cache1.Visible := True;
        RemoveMapEntry1.Visible := True;
        MapCycle1.Visible := True;
      end
      else if ActiveLV.Selected.GroupID = 1 then
      begin // Official
        Browserworkshop1.Enabled := false;
        Browserworkshop1.Visible := false;
        mniShowitempage1.Visible := false;
        mniCopyID1.Visible := false;
        Subcribe1.Visible := false;
        Forceupdate1.Visible := false;
        allfilesandentry1.Enabled := false;
        cache1.Enabled := false;
        RemoveMapEntry1.Enabled := false;
        MapCycle1.Enabled := True;
        allfilesandentry1.Visible := false;
        cache1.Visible := false;
        RemoveMapEntry1.Visible := false;
        MapCycle1.Visible := True;

      end
      else if ActiveLV.Selected.GroupID = 2 then
      begin // Redirect or local

        Browserworkshop1.Enabled := false;
        Browserworkshop1.Visible := false;
        mniShowitempage1.Visible := false;
        mniCopyID1.Visible := false;
        Subcribe1.Visible := false;
        Forceupdate1.Visible := false;
        allfilesandentry1.Enabled := True;
        cache1.Enabled := True;
        RemoveMapEntry1.Enabled := True;
        MapCycle1.Enabled := True;
        allfilesandentry1.Visible := True;
        cache1.Visible := True;
        RemoveMapEntry1.Visible := false;
        MapCycle1.Visible := True;
      end;

      Remove1.Enabled := True;
      add1.Visible := false;
      add1.Enabled := True;

      AddbyID1.Enabled := True;

      Reinstall1.Enabled := True;

    end;

  finally
    SetLength(selectedItems, 0);
  end;
end;

procedure TFormMain.pmRemovePopup(Sender: TObject);
var
  i: Integer;
begin
  if ActiveLV = lvMaps then
  begin
    if appLanguage = 'BR' then
    begin
      Removeall1.Caption := 'Remover completamente';
      RemoveGameSteamCache1.Caption := 'Remover cache do mapa';
      RemoveServerSubcribe1.Caption := 'Remover inscrição do mapa';

    end
    else
    begin

      Removeall1.Caption := 'Remove full map';
      RemoveGameSteamCache1.Caption := 'Remove map cache';
      RemoveServerSubcribe1.Caption := 'Remove map subcribe';

    end;
    RemoveMapEntry1.Visible := True;
    RemovefromCycle1.Visible := True;
  end
  else
  begin
    if appLanguage = 'BR' then
    begin
      Removeall1.Caption := 'Remover completamente';
      RemoveGameSteamCache1.Caption := 'Remover cache do item';
      RemoveServerSubcribe1.Caption := 'Remover inscrição do item';

    end
    else
    begin
      Removeall1.Caption := 'Remove full item';
      RemoveGameSteamCache1.Caption := 'Remove item cache';
      RemoveServerSubcribe1.Caption := 'Remove item subcribe';

    end;
    RemoveMapEntry1.Visible := false;
    RemovefromCycle1.Visible := false;
  end;

  if ActiveLV.Selected = nil then
  begin
    for i := 0 to pmRemove.Items.Count - 1 do
      pmRemove.Items[i].Enabled := false;
  end
  else
  begin
    for i := 0 to pmRemove.Items.Count - 1 do
      pmRemove.Items[i].Enabled := True;

  end;
end;

procedure TFormMain.FormCanResize(Sender: TObject;
  var NewWidth, NewHeight: Integer; var Resize: Boolean);
begin
  try
    edtRedirectURL.Width := Panel1.Width - 15;
    if NewWidth > 950 then
    begin
      pnlgamelenght.Align := alLeft;
      pnldifficulty.Align := alLeft;
    end
    else
    begin

      pnlgamelenght.Align := alRight;
      pnldifficulty.Align := alRight;
    end;
  except

  end;
end;

procedure TFormMain.FormCreate(Sender: TObject);
var

  serverpath: string;
  kfPathDialog: TkfPathDialog;
  pathDialogResult: Integer;
  ExeName: String;
  i: Integer;

begin

  // ---- Configname path
  ExeName := ExtractFileName(Application.ExeName);
  configName := Copy(ExeName, 0, Length(ExeName) - 4) + '.ini';
  if ParamCount > 0 then
  begin
    for i := 0 to ParamCount do
    begin
      if LowerCase(ParamStr(i)) = '-config' then
      begin
        if ExtractFileExt(ParamStr(i + 1)) = '.ini' then
        begin
          configName := ParamStr(i + 1);
          Break;
        end
        else
          ShowMessage('Config is not valid');
        Break;
      end;
    end;
  end;

  // ---- Config load
  loadConfig;

  // ----- Verify for dependencies
  try
    CheckDependencies;
  except
    on E: Exception do
    begin
      Application.MessageBox(PWideChar(E.Message), 'Dependencie not found',
        MB_OK + MB_ICONSTOP);
      Application.Terminate;
      Exit;
    end;
  end;

  // ---- Server check
  repeat
    if useCustomServerPath then
      serverpath := IncludeTrailingPathDelimiter(customServerPath)
    else
      serverpath := ExtractFilePath(Application.ExeName);

    if FileExists(serverpath + pathServerEXE) = false then
    begin
      kfPathDialog := TkfPathDialog.Create(Self);
      try
        pathDialogResult := kfPathDialog.ShowModal;
        case pathDialogResult of
          2: // Cancel
            begin
              Application.Terminate;
              Exit;
            end;
          101: // Path set
            begin
              useCustomServerPath := True;
              serverpath := IncludeTrailingPathDelimiter(customServerPath)
            end;
          102:
            // Install Server
            begin
              useCustomServerPath := false;
              customServerPath := '';
              serverpath := ExtractFilePath(Application.ExeName);
              InstallServer(ExtractFilePath(Application.ExeName));
            end;
        end;

      finally
        kfPathDialog.Free;
      end;
    end;
  until FileExists(serverpath + pathServerEXE);

  // ---- Files load
  serverTool := TKFServerTool.Create;
  try
    serverTool.SetKFApplicationPath(serverpath);
    serverTool.SetKFngineIniSubPath(pathKFEngineIni);
    serverTool.SetKFGameIniSubPath(pathKFGameIni);
    serverTool.SetKFServerPathEXE(pathServerEXE);
    serverTool.SetKFWebIniSubPath(pathKFWebIni);
    serverTool.SetSteamCmdPath(serverpath + pathCmdTool);
  except
    on E: Exception do
    begin
      Application.MessageBox(PWideChar(E.Message), 'Error',
        MB_OK + MB_ICONSTOP);
      Application.Terminate;
      Exit
    end;
  end;

  // ---- Load UI Config
  LoadUIConfig;

  // ---- Auto check for update system
  if AutoCheckForUpdates then
    checkForUpdates(Self);

end;

procedure TFormMain.LoadUIConfig;
var
  i: Integer;
var

  webPort: String;
  customRedirect: string;
begin
  Self.Caption := Self.Caption + ' ' + TKFServerTool.SERVERTOOLVERSION;
  LoadServerProfile();
  LoadItensToLv('');

  jvpgcntrl1.ActivePageIndex := 0;
  // pgcMaps.ActivePageIndex := 0;
  jvpgcntrl1Change(Self);

  btnRemove.Enabled := false;
  if jvpgcntrl1.ActivePage = tsMaps then

    ActiveLV := lvMaps
  else
    ActiveLV := lvMods;
  btnReinstall.Enabled := false;
  btnUpdate.Enabled := false;
  chkOnlyFromConfigItems.Checked := onlyFromConfigItems;
  customRedirect := serverTool.GetCustomRedirect;
  // ShowMessage(configName);
{$IFDEF DEBUG}
  tsDebug.TabVisible := True;
{$ELSE}
  tsDebug.TabVisible := false;
{$ENDIF}
  if customRedirect = '' then
  begin
    cbbRedirectEnabled.ItemIndex := 0;
    edtRedirectURL.Text := '';
    edtRedirectURL.Enabled := false;
  end
  else
  begin
    cbbRedirectEnabled.ItemIndex := 1;
    edtRedirectURL.Text := customRedirect;
    edtRedirectURL.Enabled := True;
  end;

  lblHelpAdditionParam.Visible := false;
  // Windows size
  Self.Width := appWidth;
  Self.Height := appHeight;
  if appMaximized then
    Self.WindowState := wsMaximized;

  // Font size
  Self.Font.Size := fontSize;
  trckbrFontSize.Position := fontSize;
  // Workshop redirect installed

  if serverTool.IsWorkshopManagerInstalled then
    cbWorkshopDMStatus.ItemIndex := 1
  else
    cbWorkshopDMStatus.ItemIndex := 0;
  chkAutoConnectWeb.Checked := AutoConnectWeb;
  cbWorkshopDMStatus.Font.Size := fontSize;
  cbWorkshopDMStatus.Top := lblWkspDownMan.Top;
  cbWorkshopDMStatus.Left := lblWkspDownMan.Left + lblWkspDownMan.Width + 5;
  // Web port
  try
    webPort := IntToStr(serverTool.GetWebPort);
  except
    on E: Exception do
    begin
      webPort := 'Error';
      ShowMessage(E.Message);
    end;
  end;
  edtPort.Text := webPort;
  // Web Status
  try
    if serverTool.GetWebStatus then
      cbStatusWeb.ItemIndex := 1
    else
      cbStatusWeb.ItemIndex := 0;
  except
    on E: Exception do
    begin
      cbStatusWeb.ItemIndex := -1;
      ShowMessage(E.Message);
    end;
  end;
  // Web pass
  try
    edtWebPass.Text := serverTool.GetWebPass;
  except
    on E: Exception do
      ShowMessage('Falied to get webPass ' + E.Message);
  end;

  // Language
  if appLanguage = 'EG' then
    cbbLanguage.ItemIndex := 0
  else
    cbbLanguage.ItemIndex := 1;
  chkAutoLoginAdmin.Checked := autoLoginWebAdmin;
  checkAutoWebLoginRequirements();

  if Assigned(TStyleManager.ActiveStyle) then
  begin
    for i := 0 to High(TStyleManager.StyleNames) do
      cbbTheme.Items.Add(TStyleManager.StyleNames[i]);
  end;
  // Auto check for updates checkbox
  chkAutoCheckForUpdates.Checked := AutoCheckForUpdates;

  cbbTheme.ItemIndex := cbbTheme.Items.IndexOf(fdefaultStyleName);
  TStyleManager.TrySetStyle(fdefaultStyleName);
  // whatever was in the project settings.
  Application.HintHidePause := 15000; // 15 Sec

  // ---- Translation
  if appLanguage = 'BR' then
    TranstaleToBR;
  // Fix webbrowser compabillity
  InstallRegBrowserKey()
end;

procedure TFormMain.FormDestroy(Sender: TObject);
var
  i: Integer;
begin
  try
    // cb Server Length and Difficulty
    if Assigned(kfprofiles) then begin
    with kfprofiles[defaultProfile] do
    begin
      DefaultDifficulty := cbbDifficulty.ItemIndex;
      DefaultLength := cbbLength.ItemIndex;
      DefaultPass := edtGmPass.Text;
      AdditionalParam := edtExtra.Text;
      DefaultMap := cbbMap.Text;
    end;
    end;
    appWidth := Self.Width;
    appHeight := Self.Height;
    appMaximized := FormMain.WindowState = wsMaximized;
    saveconfig;
    if Assigned(serverTool) then

    FreeAndNil(serverTool);
    for i := 0 to High(kfprofiles) do
      FreeAndNil(kfprofiles[i]);
  except

  end;

end;

procedure TFormMain.FromList1Click(Sender: TObject);
var
  ItemName: string;
  itemID: string;
  frmReinstall: TFormAdd;
  ItemsCount, i: Integer;
  itemsDone: Integer;
  modalResult: Integer;
  bkpFile: TStringList;
  dlgOpenbkp: TOpenDialog;
  bkpFilePath: String;
  separatorPoint: Integer;
  separator: String;
  progressForm: TformPB;
begin
  bkpFilePath := '';
  separator := '\\';

  dlgOpenbkp := TOpenDialog.Create(Self);
  dlgOpenbkp.Filter := '';
  if dlgOpenbkp.Execute(Self.handle) then
    bkpFilePath := dlgOpenbkp.FileName;

  if bkpFilePath = '' then
  begin
    ShowMessage('No item selected');
    Exit;
  end
  else
  begin
    itemsDone := 0;
    modalResult := mrNone;
    bkpFile := TStringList.Create();
    bkpFile.LoadFromFile(bkpFilePath);
    ItemsCount := bkpFile.Count;
    frmReinstall := TFormAdd.Create(Self);
    progressForm := TformPB.Create(Self);

    try
      progressForm.SetPBMax(bkpFile.Count);
      progressForm.btncancel.Visible := True;
      progressForm.Show;
      CheckIfTheServerIsRuning;
      for i := 0 to bkpFile.Count - 1 do
      begin
        try
          Application.ProcessMessages;
          // For more than one item
          separatorPoint := Pos(separator, bkpFile[i]);
          itemID := Copy(bkpFile[i], 0, separatorPoint - 1);
          ItemName := Copy(bkpFile[i], separatorPoint + 2,
            Length(bkpFile[i]) - separatorPoint - 2);
          if ActiveLV = lvMaps then
          begin
            if (ItemName <> '') and (itemID <> '') then
            begin
              frmReinstall.SetAddType(TKFItemType.ReinstallWorkshopMap);
            end;
            frmReinstall.edtID.Text := itemID;
            frmReinstall.ItemName := ItemName;
            frmReinstall.edtID.Enabled := false;
            frmReinstall.Caption := 'Reinstall ' + ItemName;
            if bkpFile.Count > 1 then
            begin
              frmReinstall.chkDoForAll.Visible := True;
              if appLanguage = 'BR' then
              begin
                frmReinstall.chkDoForAll.Caption :=
                  'Fazer isso para os próximos ' +
                  IntToStr(ItemsCount - 1 - itemsDone) + ' itens';
              end
              else
              begin
                frmReinstall.chkDoForAll.Caption := 'Do the same for the next '
                  + IntToStr(ItemsCount - 1 - itemsDone) + ' items';
              end;

              if modalResult <> mrAll then
              begin
                modalResult := frmReinstall.ShowModal;
                if modalResult = mrCancel then
                  Exit;

              end;
              Application.ProcessMessages;
              if (modalResult = mrOk) or (modalResult = mrAll) then
              begin
                if progressForm.cancel then
                  Break;
                progressForm.NextPBValue(IntToStr(i + 1) + '/' +
                  IntToStr(bkpFile.Count) + ' Installing item ' + itemID);
                if serverTool.InstallWorkshopItem(frmReinstall.edtID.Text,
                  frmReinstall.ItemName, frmReinstall.addWkspRedirect,
                  frmReinstall.downloadNow, frmReinstall.addMapCycle,
                  frmReinstall.addMapENtry) = false then
                begin
                  Application.MessageBox
                    (PWideChar('One o more steps for item ' +
                    frmReinstall.edtID.Text + ' falied!'), '',
                    MB_OK + MB_ICONEXCLAMATION);

                end;
              end
              else
              begin
                Break;
              end;

              itemsDone := itemsDone + 1;
            end
            else
            begin
              Application.ProcessMessages;
              // Just one item
              modalResult := frmReinstall.ShowModal;
              if (modalResult = mrOk) then
              begin
                progressForm.NextPBValue('Installing item ' + itemID);
                if serverTool.InstallWorkshopItem(frmReinstall.edtID.Text,
                  frmReinstall.ItemName, frmReinstall.addWkspRedirect,
                  frmReinstall.downloadNow, frmReinstall.addMapCycle,
                  frmReinstall.addMapENtry) = false then
                begin
                  Application.MessageBox
                    (PWideChar('One o more steps for item ' +
                    frmReinstall.edtID.Text + ' falied!'), '',
                    MB_OK + MB_ICONEXCLAMATION);

                end;

              end
              else
              begin
                LoadItensToLv('');
                Exit;
              end;
              Application.ProcessMessages;
            end;
          end;

        except
          on E: Exception do
            ShowMessage(E.Message);
        end;

      end;
      LoadItensToLv('');
      Application.MessageBox('Finished!', '', MB_OK + MB_ICONINFORMATION)
    finally
      FreeAndNil(progressForm);
      FreeAndNil(frmReinstall);
      FreeAndNil(bkpFile);
    end;

  end;

end;

procedure TFormMain.FromRedirect1Click(Sender: TObject);
var
  frmAdd: TFormAdd;
  mdResult: Integer;
  redirectURL: String;
  DownURL: string;
  FileName: String;
  dlManager: TDownloadManager;

begin
  frmAdd := TFormAdd.Create(Self);
  if Assigned(frmProgress) then
    frmProgress.Free;
  frmProgress := TformPB.Create(Self);
  try
    try
      if ActiveLV = lvMaps then
      begin
        frmAdd.SetAddType(TKFItemType.RedirectMap);
      end
      else
      begin
        ShowMessage('Not supported yet');
        Exit;
      end;
      redirectURL := serverTool.GetCustomRedirect();
      if redirectURL <> '' then
      begin
        frmAdd.edtRedirectURL.Text := redirectURL;

      end
      else
      begin

        ShowMessage
          ('Warning: The redirect URL is not set. Go to the options tab to set it up.');
      end;
      mdResult := frmAdd.ShowModal;

      if mdResult = mrOk then
      begin

        redirectURL := frmAdd.edtRedirectURL.Text;
        FileName := Trim(frmAdd.edtItemName.Text);
        if redirectURL[Length(redirectURL)] <> '/' then
          redirectURL := Trim(redirectURL) + '/';
        DownURL := redirectURL + FileName;
        dlManager := TDownloadManager.Create;

        dlManager.OnProgress := RedirectDownloadProgress;
        dlManager.OnStarted := RedirectDownloadStarted;
        dlManager.OnFinished := RedirectDownloadFinished;

        dlManager.FileDAbort := @frmProgress.cancel;
        frmProgress.btncancel.Visible := True;
        frmProgress.Show;
        try
          CheckIfTheServerIsRuning;
          serverTool.NewRedirectItem(DownURL, FileName, (DownURL <> ''),
            frmAdd.addMapCycle, frmAdd.addMapENtry, dlManager);
        finally
          FreeAndNil(dlManager);
        end;
      end;
    finally
      FreeAndNil(frmAdd);
      FreeAndNil(frmProgress);
      LoadItensToLv('');
    end;
  except
    on E: Exception do
      ShowMessage('Falied to add item: ' + E.Message);
  end;

end;

procedure TFormMain.RedirectDownloadProgress(currentPosition: Int64);
begin
  if Assigned(frmProgress) then
  begin
    with frmProgress do
    begin
      if currentPosition < pb1.Max then
        pb1.Position := currentPosition;

      frmProgress.lblStatus.Caption := 'Downloading  ' +
        FormatFloat('0%', ((currentPosition * 100) / frmProgress.pb1.Max)) +
        ' - ' + FormatByteSize(currentPosition);
    end;
    Application.ProcessMessages;

  end;
end;

procedure TFormMain.RedirectDownloadStarted(fileSize: Int64);
begin
  if Assigned(frmProgress) then
  begin
    frmProgress.pb1.Max := fileSize;

  end;
end;

procedure TFormMain.RedirectDownloadFinished();
begin
  if Assigned(frmProgress) then
  begin
    frmProgress.pb1.Position := 0;
  end;
end;

procedure TFormMain.LoadServerProfile();
var
  i: Integer;
begin
  if cbbMap.Items.Count > 0 then
    cbbMap.ItemIndex := 0;
  // cb Profile
  cbbProfile.Clear;
  for i := 0 to High(kfprofiles) do
    cbbProfile.Items.Add(kfprofiles[i].ProfileName);

  // cb Server Length and Difficulty
  cbbProfile.ItemIndex := defaultProfile;
  with kfprofiles[defaultProfile] do
  begin
    cbbDifficulty.ItemIndex := DefaultDifficulty;
    cbbLength.ItemIndex := DefaultLength;
    edtGmPass.Text := DefaultPass;
    edtExtra.Text := AdditionalParam;
    if cbbMap.Items.IndexOf(DefaultMap) > 0 then
      cbbMap.ItemIndex := cbbMap.Items.IndexOf(DefaultMap);
    cbbGameMode.ItemIndex := DefaultGameMode;
  end;
  if High(kfprofiles) < 1 then
    btnDeleteProfile.Enabled := false
  else
    btnDeleteProfile.Enabled := True;

end;

procedure TFormMain.jvpgcntrl1Change(Sender: TObject);
begin
  if jvpgcntrl1.ActivePage = tsMaps then
  begin
    ActiveLV := lvMaps;
    btnRemove.Visible := True;
    btnAddNew.Visible := True;
    btnReinstall.Visible := True;
    btnUpdate.Visible := True;
    lvClick(Sender);
  end;
  if jvpgcntrl1.ActivePage = tsMods then
  begin
    ActiveLV := lvMods;
    btnRemove.Visible := True;
    btnAddNew.Visible := True;
    btnReinstall.Visible := True;
    btnUpdate.Visible := True;
    lvClick(Sender);
  end;
  if jvpgcntrl1.ActivePage = tsUnknowed then
  begin
    ActiveLV := lvUnknowed;
    btnRemove.Visible := True;
    btnAddNew.Visible := false;
    btnReinstall.Visible := True;
    btnUpdate.Visible := True;
    lvClick(Sender);
  end;
  if (jvpgcntrl1.ActivePage = tsServer) or (jvpgcntrl1.ActivePage = tsExtra)
  then
  begin
    ActiveLV := nil;
    btnRemove.Visible := false;
    btnAddNew.Visible := false;
    btnReinstall.Visible := false;
    btnUpdate.Visible := false;
  end;

  if jvpgcntrl1.ActivePage = tswebadmin then
  begin
    ActiveLV := nil;
    btnRemove.Visible := false;
    btnAddNew.Visible := false;
    btnReinstall.Visible := false;
    btnUpdate.Visible := false;
    if ProcessExists(ExtractFileName(pathServerEXE)) then
    begin

      wb1.Navigate('http://127.0.0.1:' + edtPort.Text);
    end
    else
    begin
      if appLanguage = 'BR' then
        Application.MessageBox('O Web server não está sendo executado',
          'Server', MB_OK + MB_ICONINFORMATION)
      else
        Application.MessageBox('Web server is not running', 'Server',
          MB_OK + MB_ICONINFORMATION)
    end;
  end;

end;

function TFormMain.getSelectedCount(ListView: TListView): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to ActiveLV.Items.Count - 1 do
    if ActiveLV.Items[i].Selected then
      Result := Result + 1;
end;

procedure TFormMain.Removeall1Click(Sender: TObject);
var
  ItemName: string;
  itemID: string;
  lgText1, lgText2, lgText: string;
  i: Integer;
  slCount: Integer;
  itemSource: TKFSource;
  slItems: TLvSelectedItems;
  progressForm: TformPB;
begin
  slCount := getSelectedCount(ActiveLV);
  slItems := GetLVSelectedItems(ActiveLV);
  if ActiveLV.Selected = nil then
  begin
    ShowMessage('Select na item first.');
    Exit;
  end
  else
  begin
    try

      if appLanguage = 'BR' then
      begin
        if slCount = 1 then
        begin

          lgText1 :=
            'Você tem certeza que deseja apagar completamente o mapa? ';
          lgText2 := 'Você tem certeza que deseja apagar completamente o item?';

        end
        else
        begin
          lgText1 := 'Você tem certeza que deseja apagar completamente os ' +
            IntToStr(slCount) + ' mapa selecionados? ';
          lgText2 := 'Você tem certeza que deseja apagar completamente os ' +
            IntToStr(slCount) + ' itens selecionados?';

        end;
      end
      else
      begin
        if slCount = 1 then
        begin
          lgText1 := 'Are you sure you want to full delete the map? ';
          lgText2 := 'Are you sure you want to full delete the item?';
        end
        else
        begin
          lgText1 := 'Are you sure you want to full delete the ' +
            IntToStr(slCount) + ' selected maps? ';
          lgText2 := 'Are you sure you want to full delete the ' +
            IntToStr(slCount) + ' selected items?';

        end;

      end;

      if ActiveLV = lvMaps then
        lgText := lgText1;
      if ActiveLV = lvMods then
        lgText := lgText2;

      if messagedlg(lgText1, mtConfirmation, [mbYes, mbCancel], 0) = mrYes then
      begin

        progressForm := TformPB.Create(Self);
        progressForm.Show;
        progressForm.SetPBMax(slCount);
        try
          CheckIfTheServerIsRuning;
          for i := 0 to High(slItems) do
          begin

            ItemName := slItems[i].Caption;
            itemID := slItems[i].SubItems[0];
            itemSource := TKFSource(slItems[i].GroupID);
            if ActiveLV = lvMaps then
            begin
              progressForm.NextPBValue(IntToStr(i + 1) + '/' + IntToStr(slCount)
                + ' Removing map ' + ItemName + ' ' + itemID);
              serverTool.RemoveItem(ItemName, itemID, (ItemName <> ''),
                (ItemName <> ''), (itemID <> ''), (ItemName <> ''), itemSource);

            end
            else
            begin
              if ActiveLV = lvMods then
              begin
                progressForm.NextPBValue(IntToStr(i + 1) + '/' +
                  IntToStr(slCount) + ' Removing mod ' + ItemName + ' '
                  + itemID);
                serverTool.RemoveItem(ItemName, itemID, false, false, True,
                  True, itemSource);

              end
              else
              begin
                progressForm.NextPBValue(IntToStr(i + 1) + '/' +
                  IntToStr(slCount) + ' Removing item ' + ItemName + ' '
                  + itemID);
                if ActiveLV = lvUnknowed then
                  serverTool.RemoveItem(ItemName, itemID, True, True, True,
                    True, itemSource);
              end;
            end;
            progressForm.Close;
          end;
        finally
          progressForm.Free;
        end;
      end;

      LoadItensToLv('');

    except
      on E: Exception do
        ShowMessage(E.Message);
    end;

  end;
end;

procedure TFormMain.RemovefromCycle1Click(Sender: TObject);
var
  ItemName: string;
  itemID: string;
  lgText: string;
  slCount, i: Integer;
  slItems: TLvSelectedItems;
  itemSource: TKFSource;
  progressForm: TformPB;
begin
  slCount := getSelectedCount(ActiveLV);
  slItems := GetLVSelectedItems(ActiveLV);
  if ActiveLV.Selected = nil then
  begin
    ShowMessage('Select na item first.');
    Exit;
  end
  else
  begin
    try
      if appLanguage = 'BR' then
      begin
        if slCount = 1 then
          lgText := 'Remover ' + ActiveLV.Selected.Caption +
            ' do ciclo de mapas?'
        else
          lgText := 'Remover os ' + IntToStr(slCount) +
            ' mapas selecionados do ciclo de mapas?';
      end
      else
      begin
        if slCount = 1 then
          lgText := 'Remove ' + ActiveLV.Selected.Caption + ' from map cycle?'
        else
          lgText := 'Remove the ' + IntToStr(slCount) +
            ' selected maps from map cycle?';

      end;

      if messagedlg(lgText, mtConfirmation, [mbYes, mbCancel], 0) = mrYes then
      begin
        progressForm := TformPB.Create(Self);
        progressForm.SetPBMax(slCount);
        progressForm.Show;

        try
          CheckIfTheServerIsRuning;
          for i := 0 to High(slItems) do
          begin

            ItemName := slItems[i].Caption;
            itemID := slItems[i].SubItems[0];
            itemSource := TKFSource(slItems[i].GroupID);
            progressForm.NextPBValue('Removing map ' + ItemName +
              ' from map cycle');
            serverTool.RemoveItem(ItemName, itemID, false, True, false, false,
              itemSource);
            progressForm.Close;
          end;
        finally
          progressForm.Free;
        end;

      end;
      LoadItensToLv('');
    except

    end;

  end;
end;

procedure TFormMain.RemoveGameSteamCache1Click(Sender: TObject);
var
  ItemName: string;
  itemID: string;
  lgText: string;
  slCount, i: Integer;
  itemSource: TKFSource;
  slItems: TLvSelectedItems;
  progressForm: TformPB;
begin
  slCount := getSelectedCount(ActiveLV);
  slItems := GetLVSelectedItems(ActiveLV);
  if ActiveLV.Selected = nil then
  begin
    ShowMessage('Select na item first.');
    Exit;
  end
  else
  begin

    if appLanguage = 'BR' then
    begin
      if slCount = 1 then

        lgText := 'Apagar cache do ' + ActiveLV.Selected.Caption + '?'
      else
        lgText := 'Apagar cache dos ' + IntToStr(slCount) +
          ' itens selecionados?';
    end
    else
    begin
      if slCount = 1 then
        lgText := 'Delete cache for ' + ActiveLV.Selected.Caption + '?'
      else
        lgText := 'Delete cache for the ' + IntToStr(slCount) +
          ' selected itens?';
    end;
    try

      if messagedlg(lgText, mtConfirmation, [mbYes, mbCancel], 0) = mrYes then
      begin
        progressForm := TformPB.Create(Self);
        progressForm.Show;
        progressForm.SetPBMax(slCount);
        try
          CheckIfTheServerIsRuning;
          for i := 0 to High(slItems) do
          begin

            ItemName := slItems[i].Caption;
            itemID := slItems[i].SubItems[0];
            itemSource := TKFSource(slItems[i].GroupID);
            progressForm.NextPBValue('Removing cache for item ' + ItemName + ' '
              + itemID);
            serverTool.RemoveItem(ItemName, itemID, false, false, false, True,
              itemSource);
          end;
          progressForm.Close;
        finally
          progressForm.Free;
        end;
      end;
      LoadItensToLv('');
    except
      on E: Exception do
        ShowMessage(E.Message);
    end;

  end;
end;

procedure TFormMain.RemoveMapEntry1Click(Sender: TObject);
var
  ItemName: string;
  itemID: string;
  lgText: string;
  slCount, i: Integer;
  slItems: TLvSelectedItems;
  itemSource: TKFSource;
  progressForm: TformPB;
begin
  slCount := getSelectedCount(ActiveLV);
  slItems := GetLVSelectedItems(ActiveLV);
  if ActiveLV.Selected = nil then
  begin
    ShowMessage('Select na item first.');
    Exit;
  end
  else
  begin
    try
      if appLanguage = 'BR' then
      begin
        if slCount = 1 then
          lgText := 'Remover a entrada de mapa do ' +
            ActiveLV.Selected.Caption + '?'
        else
          lgText := 'Remover as entradas de mapas dos ' + IntToStr(slCount) +
            ' mapas selecionados?';
      end
      else
      begin
        if slCount = 1 then
          lgText := 'Remove the map entry of  ' +
            ActiveLV.Selected.Caption + '?'
        else
          lgText := 'Remove the map entrys from the ' + IntToStr(slCount) +
            ' selected maps?';

      end;

      if messagedlg(lgText, mtConfirmation, [mbYes, mbCancel], 0) = mrYes then
      begin
        progressForm := TformPB.Create(Self);
        progressForm.SetPBMax(slCount);
        progressForm.Show;
        try
          CheckIfTheServerIsRuning;
          for i := 0 to High(slItems) do
          begin
            ItemName := slItems[i].Caption;
            itemID := slItems[i].SubItems[0];
            itemSource := TKFSource(slItems[i].GroupID);
            progressForm.NextPBValue('Removing map entry of  ' + ItemName + ' '
              + itemID);
            serverTool.RemoveItem(ItemName, itemID, True, false, false, false,
              itemSource);
            progressForm.Close;
          end;
        finally
          progressForm.Free;
        end;

      end;
      LoadItensToLv('');
    except

    end;

  end;
end;

procedure TFormMain.RemoveServerSubcribe1Click(Sender: TObject);
var
  ItemName: string;
  itemID: string;
  lgText: string;
  slCount, i: Integer;
  itemSource: TKFSource;
  slItems: TLvSelectedItems;
  progressForm: TformPB;
begin
  slCount := getSelectedCount(ActiveLV);
  slItems := GetLVSelectedItems(ActiveLV);
  if ActiveLV.Selected = nil then
  begin
    ShowMessage('Select na item first.');
    Exit;
  end
  else
  begin
    try
      if appLanguage = 'BR' then
      begin
        if slCount = 1 then
          lgText := 'Remover inscrição da workshop do ' +
            ActiveLV.Selected.Caption + '?'
        else
          lgText := 'Remover as iscrições da workshop para os ' +
            IntToStr(slCount) + ' items selecionados?';
      end
      else
      begin
        if slCount = 1 then
          lgText := 'Remove workshop server subcribe for ' +
            ActiveLV.Selected.Caption + ' ?'
        else
          lgText := 'Remove the ' + IntToStr(slCount) +
            ' selected items from workshop server subscribe?';

      end;

      if messagedlg(lgText, mtConfirmation, [mbYes, mbCancel], 0) = mrYes then
      begin
        progressForm := TformPB.Create(Self);
        progressForm.Show;
        progressForm.SetPBMax(slCount);
        try
          CheckIfTheServerIsRuning;
          for i := 0 to High(slItems) do
          begin
            progressForm.NextPBValue('Removing subcribe for item ' + itemID);
            ItemName := slItems[i].Caption;
            itemID := slItems[i].SubItems[0];
            itemSource := TKFSource(slItems[i].GroupID);
            serverTool.RemoveItem(ItemName, itemID, false, false, True, false,
              itemSource);

          end;
          progressForm.Close;
        finally
          progressForm.Free;
        end;

      end;
      LoadItensToLv('');
    except

    end;

  end;
end;

procedure TFormMain.checkForUpdates(Sender: TObject);
var
  gitUpdate: TGitAutoUpdate;
  latestRelease: TLatestRelease;
  currentVCode, latestVCode: Integer;
  dlManager: TDownloadManager;
begin
  gitUpdate := TGitAutoUpdate.Create(ExtractFilePath(Application.ExeName));
  try
    try
      latestRelease := gitUpdate.GetLatestRelease('darkdks/KF2ServerTool');
    except
      on E: Exception do
      begin
        ShowMessage('Falied to check for updates' + #13 + E.Message);
        Exit
      end;
    end;
    try
      try
        latestVCode := StrToInt(cleanInt(latestRelease.version));
      except
        latestVCode := 0;
      end;
      try
        currentVCode := StrToInt(cleanInt(serverTool.SERVERTOOLVERSION));
      except
        currentVCode := 0;
      end;
      if latestVCode > currentVCode then
      begin

        if Application.MessageBox(PWideChar('A new version is avaliable.' +
          #13#13 + 'Your current version is: ' + serverTool.SERVERTOOLVERSION +
          #13 + 'The newer version is: ' + latestRelease.version + #13 + #13 +
          'Change log: ' + #13 + latestRelease.change_log + #13 + #13 +
          'Do you wanna update it now?'), 'Update aviable',
          MB_YESNO + MB_ICONQUESTION) = mrYes then
        begin
          { ShellExecute(0, 'open', Pchar(latestRelease.download_url), nil, nil,
            SW_SHOWNORMAL)
          }
          dlManager := TDownloadManager.Create;
          if Assigned(frmProgress) then
            frmProgress.Free;
          frmProgress := TformPB.Create(Self);
          dlManager := TDownloadManager.Create;
          dlManager.OnProgress := RedirectDownloadProgress;
          dlManager.OnStarted := RedirectDownloadStarted;
          dlManager.OnFinished := RedirectDownloadFinished;
          dlManager.FileDAbort := @frmProgress.cancel;
          frmProgress.btncancel.Visible := True;
          frmProgress.Show;
          try
            if gitUpdate.DownloadAndExtractUpdate(latestRelease.download_url,
              dlManager, 'KF2ServerTool.exe', True) then
            begin
              ShowMessage
                ('The application will be restarted to complete to update');
              KillProcessByName(gitUpdate.TEMUPDATEFILE);
              gitUpdate.executeUpdateInstall(gitUpdate.TEMUPDATEFILE,
                UPDATEPARAM + ' "' + Application.ExeName + '"');
              Application.Terminate;
            end
            else
              ShowMessage('Error to update');
          finally
            FreeAndNil(dlManager);
            FreeAndNil(frmProgress);
          end;

        end;

      end
      else
      begin
        if Assigned(Sender) then
          if (Sender is TLabel) then
            ShowMessage('The current version is updated.');

      end;

    except
      on E: Exception do
        ShowMessage('Falied to download update' + #13 + E.Message);
    end;

  finally
    FreeAndNil(gitUpdate);
    FreeAndNil(latestRelease);
  end;
end;

procedure TFormMain.lblDonateClick(Sender: TObject);
var
  frmDnt: TfrmDonate;
begin
  frmDnt := TfrmDonate.Create(Self);
  try
    frmDnt.Position := poMainFormCenter;
    frmDnt.ShowModal;
  finally
    frmDnt.Free;
  end;

end;

procedure TFormMain.lblsasdadClick(Sender: TObject);
begin

  if serverTool.IsWorkshopManagerInstalled then
  begin
    // servertool.RemoveWorkshopManager
  end
  else
  begin
    serverTool.InstallWorkshopManager;
  end;

end;

function TFormMain.loadConfig: Boolean;
var
  IniConfig: TIniFile;
  regCount, i: Integer;
  section: String;
begin
  SetLength(kfprofiles, 0);
  Result := false;
  try

    IniConfig := TIniFile.Create(ExtractFilePath(Application.ExeName) +
      configName);
    try
      with IniConfig do
      begin
        // GAME
        useCustomServerPath := ReadBool('PATHS', 'UseCustomServerPath', false);
        customServerPath := ReadString('PATHS', 'CustomServerPath',
          'CHANGE_ME_FOR_CUSTOM_PATH');
        pathKFWebIni := ReadString('PATHS', 'KFWebIni',
          'KFGame\Config\KFWeb.ini');
        pathKFGameIni := ReadString('PATHS', 'KFGameIni',
          'KFGame\Config\PCServer-KFGame.ini');
        pathKFEngineIni := ReadString('PATHS', 'KFEngineIni',
          'KFGame\Config\PCServer-KFEngine.ini');
        pathCmdTool := ReadString('PATHS', 'SteamCmdTool',
          'STEAMCMD\SteamCmd.exe');
        pathServerEXE := ReadString('PATHS', 'ServerEXE',
          'Binaries\win64\kfserver.exe');
        regCount := ReadInteger('GERAL', 'ProfileCount', 1);
        defaultProfile := ReadInteger('GERAL', 'DefaultProfileID', 0);

        for i := 0 to regCount - 1 do
        begin
          SetLength(kfprofiles, Length(kfprofiles) + 1);
          kfprofiles[High(kfprofiles)] := TKFServerProfile.Create;
          with kfprofiles[High(kfprofiles)] do
          begin
            section := 'SERVERPROFILE' + IntToStr(i);
            DefaultDifficulty := ReadInteger(section, 'DefaultDifficulty', 2);
            DefaultLength := ReadInteger(section, 'DefaultLength', 2);
            DefaultPass := ReadString(section, 'DefaultPass', '');
            AdditionalParam := ReadString(section, 'AdditionalParam', '');
            DefaultMap := ReadString(section, 'DefaultMap', '');
            DefaultGameMode := ReadInteger(section, 'DefaultGameMode', 0);
            ProfileName := ReadString(section, 'ProfileName', 'Default');
            AutoConnectWeb := ReadBool(section, 'AutoConnectWeb', false);
          end;
        end;

        // App
        onlyFromConfigItems := ReadBool('GENERAL',
          'OnlyShowItemsFromConfig', false);
        appLanguage := ReadString('GENERAL', 'Language', 'EG');
        fdefaultStyleName := ReadString('GENERAL', 'Theme', 'Windows');
        autoLoginWebAdmin := ReadBool('GENERAL', 'AutoWebAdminLogin', True);
        appHeight := ReadInteger('GENERAL', 'WindowHeight', Self.Height);
        appWidth := ReadInteger('GENERAL', 'WindowWidth', Self.Width);
        fontSize := ReadInteger('GENERAL', 'FontSize', 10);
        appMaximized := ReadBool('GENERAL', 'Maximized', false);
        AutoCheckForUpdates := ReadBool('GENERAL',
          'AutoCheckForUpdates', false);
        if FileExists(ExtractFilePath(Application.ExeName) + MEMONAME) then
          mmoNotepad.Lines.LoadFromFile(ExtractFilePath(Application.ExeName) +
            MEMONAME);
      end;
    finally
      IniConfig.Free;
    end;
  except
    ShowMessage('Falied to load config file');

  end;
end;

function TFormMain.saveconfig: Boolean;
var
  IniConfig: TIniFile;
  i: Integer;
  section: String;
begin
  Result := false;

  try

    IniConfig := TIniFile.Create(ExtractFilePath(Application.ExeName) +
      configName);
    try
      with IniConfig do
      begin
        WriteBool('PATHS', 'UseCustomServerPath', useCustomServerPath);
        WriteString('PATHS', 'CustomServerPath', customServerPath);
        WriteString('PATHS', 'KFWebIni', pathKFWebIni);
        WriteString('PATHS', 'KFGameIni', pathKFGameIni);
        WriteString('PATHS', 'KFEngineIni', pathKFEngineIni);
        WriteString('PATHS', 'SteamCmdTool', pathCmdTool);
        WriteString('PATHS', 'ServerEXE', pathServerEXE);
        WriteInteger('GERAL', 'ProfileCount', Length(kfprofiles));
        WriteInteger('GERAL', 'DefaultProfileID', defaultProfile);

        for i := 0 to High(kfprofiles) do
        begin
          with kfprofiles[i] do
          begin
            section := 'SERVERPROFILE' + IntToStr(i);
            WriteInteger(section, 'DefaultDifficulty', DefaultDifficulty);
            WriteInteger(section, 'DefaultLength', DefaultLength);
            WriteInteger(section, 'DefaultGameMode', DefaultGameMode);
            WriteString(section, 'DefaultPass', DefaultPass);
            WriteString(section, 'AdditionalParam', AdditionalParam);
            WriteString(section, 'DefaultMap', DefaultMap);
            WriteString(section, 'ProfileName', ProfileName);
            WriteBool(section, 'AutoConnectWeb', AutoConnectWeb);
          end;
          WriteBool('GENERAL', 'OnlyShowItemsFromConfig', onlyFromConfigItems);
          WriteString('GENERAL', 'Language', appLanguage);
          WriteString('GENERAL', 'Theme', fdefaultStyleName);
          WriteBool('GENERAL', 'AutoWebAdminLogin', autoLoginWebAdmin);
          WriteInteger('GENERAL', 'WindowHeight', appHeight);
          WriteInteger('GENERAL', 'WindowWidth', appWidth);
          WriteInteger('GENERAL', 'FontSize', fontSize);
          WriteBool('GENERAL', 'Maximized', appMaximized);
          WriteBool('GENERAL', 'AutoCheckForUpdates', AutoCheckForUpdates);
        end;
      end;
      if mmoNotepad.Text <> '' then
      begin
        mmoNotepad.Lines.SaveToFile(ExtractFilePath(Application.ExeName) +
          MEMONAME);
      end
      else
      begin
        if FileExists(ExtractFilePath(Application.ExeName) + MEMONAME) then
          DeleteFile(ExtractFilePath(Application.ExeName) + MEMONAME)
      end;

      Result := True;
    finally
      IniConfig.Free;
    end;
  except
    ShowMessage('Falied to save config. Admin rights?');
  end;

end;

procedure TFormMain.tmrWebAdminTimer(Sender: TObject);
var
  tcpResponse: TIdTCPClient;
begin
  tcpResponse := TIdTCPClient.Create(Self);
  try
    try
      tcpResponse.Host := '127.0.0.1';
      tcpResponse.Port := StrToInt(edtPort.Text);
      tcpResponse.ConnectTimeout := 200;
      tcpResponse.Connect;
      if tcpResponse.Connected then
      begin

        wb1.Navigate('http://127.0.0.1:' + edtPort.Text);
        jvpgcntrl1.ActivePage := tswebadmin;
        tmrWebAdmin.Enabled := false;
        // autoLoginWb;
      end;

    finally
      tcpResponse.Free;
    end;
  except

  end;
end;

procedure TFormMain.autoLoginWb;
var
  Doc: IHTMLDocument2;
  i: Integer;
  Element: OleVariant;
  Elements: IHTMLElementCollection;
  form: IHTMLFormElement;
begin
  try
    Doc := wb1.Document as IHTMLDocument2;
    Elements := Doc.All;
    for i := 0 to Elements.Length - 1 do
    begin
      Element := Elements.Item(i, varEmpty);
      if (UpperCase(Element.tagName) = 'INPUT') and
        (UpperCase(Element.Type) = 'TEXT') then
      begin
        if (Element.name = 'username') then
          Element.value := 'admin';
      end;
      if (UpperCase(Element.tagName) = 'INPUT') and
        (UpperCase(Element.Type) = 'PASSWORD') then
      begin
        if (Element.name = 'password') then
          Element.value := serverTool.GetWebPass;
      end;

      form := (Doc.Forms.Item('loginform', 0) as IHTMLFormElement);
      if Assigned(form) then
        form.submit;
    end;
  except
    // silent discart
  end;
end;

procedure TFormMain.TranstaleToBR();
begin
  btnRemove.Caption := 'Remover';
  btnAddNew.Caption := 'Adicionar';
  btnReinstall.Caption := 'Reinstalar';
  btnUpdate.Caption := 'Atualizar';
  lblDonate.Caption := 'Contribuir';
  with lvMaps do
  begin
    Columns.Items[0].Caption := 'Mapa';
    Columns.Items[2].Caption := 'Inscrito';
    Columns.Items[3].Caption := 'Entrada';
    Columns.Items[4].Caption := 'No ciclo';
    Columns.Items[5].Caption := 'Em cache';
  end;
  with lvMods do
  begin
    Columns.Items[0].Caption := 'Arquivo';
    Columns.Items[2].Caption := 'Inscrito';
    Columns.Items[3].Caption := 'Em cache';
  end;
  AddWorkshopMap.Caption := 'Procurar na Workshop';
  AddWorkshopIDorURL.Caption := 'ID ou URL da Workshop';
  tsMaps.Caption := 'Mapas';
  lblMap.Caption := 'Mapa';
  lblDifficulty.Caption := 'Dificuldade';
  lblGameLength.Caption := 'Duração';
  lblGamePass.Caption := 'Senha';
  btnStartServer.Caption := 'Iniciar servidor';
  grpEnableDisable.Caption := 'Ativar / Desativar';
  grpStartServer.Caption := 'Iniciar servidor';
  cbbDifficulty.Items[1] := 'Difícil';
  cbbDifficulty.Items[2] := 'Suicida';
  cbbDifficulty.Items[3] := 'Inferno na terra';
  cbbLength.Items[0] := 'Curto';
  cbbLength.Items[1] := 'Médio';
  cbbLength.Items[2] := 'Longo';
  add1.Caption := 'Adicionar';
  Remove1.Caption := 'Remover';
  Forceupdate1.Caption := 'Forçar atualização';
  Reinstall1.Caption := 'Reinstalar';
  Browserworkshop1.Caption := 'Procurar na Workshop';
  AddbyID1.Caption := 'ID ou URL da Workshop';
  allfilesandentry1.Caption := 'Completamente';
  Mapentry1.Caption := 'Entrada';
  MapCycle1.Caption := 'Do ciclo';
  Subcribe1.Caption := 'Inscrição';
  mniShowitempage1.Caption := 'Abrir página da workshop';
  mniCopyID1.Caption := 'Copiar ID';
  lblAddParam.Caption := 'Parâmetros adicionais';
  lblSearch.Caption := 'Filtro';
  btnNewProfile.Caption := 'Novo';
  btnRenameProfile.Caption := 'Renomear';
  btnDeleteProfile.Caption := 'Remover';
  lblProfile.Caption := 'Perfil';
  chkAutoConnectWeb.Caption := 'Auto conectar ao WebServer';
  Multipleitems1.Caption := 'Multiplos items';
  lblDescWebPort.Caption := 'Porta do Web admin:';
  cbWorkshopDMStatus.Items[0] := 'Desativado';
  cbWorkshopDMStatus.Items[1] := 'Ativado';
  cbStatusWeb.Items[0] := 'Desativado';
  cbStatusWeb.Items[1] := 'Ativado';
  tsExtra.Caption := 'Opções';
  btnCheckForUpdate.Caption := 'Versão atual';
  btnCleanDownloadCache.Caption := 'Limpar chache de download';
  btnCleanWorkshopData.Caption := 'Limpar dados da workshop';
  grpmaintenance.Caption := 'Manutenção';
  grpapplication.Caption := 'Aplicação';
  lblFontSize.Caption := 'Tamanho da fonte: ';
  lblGameMode.Caption := 'Modo de jogo';
  FromRedirect1.Caption := 'Do Redirect';
  FromList1.Caption := 'De uma lista de backup';
  tsNotes.Caption := 'Notas';
  Export1.Caption := 'Exportar';
  RemoveMapEntry1.Caption := 'Entrada';
  RemoveMapEntry1.Caption := 'Do cíclo';
  lblTheme.Caption := 'Tema:';
  Explorerlocalfolder1.Caption := 'Abrir a pasta do item';
  lblWebPass.Caption := 'Senha do Web admin:';
  chkAutoLoginAdmin.Caption :=
    'Auto logar no web admin usando a senha especificada';
  chkOnlyFromConfigItems.Caption :=
    'Apenas monstrar itens que estão no arquivo configuração';
  chkAutoCheckForUpdates.Caption :=
    'Verificar automaticamente por atualizações';
  chkAutoCheckForUpdates.Hint :=
    'Verificar automaticamente se há atualizações disponíveis para' + #13 +
    ' a ferramenta no repositório oficial do KF2ServerTool';
  chkOnlyFromConfigItems.Hint :=
    'Ative esta opção para ver apenas itens que estão no PCServer-KFGame e no PCServer-KFEngine.'
    + #13 + 'A pasta cache e maps serão ignorados. Isso é útil quando você tem vários servidores'
    + #13 + 'com várias configurações e não quer ver mapas de outro servidor na ferramenta.';

  chkAutoLoginAdmin.Hint :=
    'Habilitar esta opção fará com que o WebAdmin efetue login automaticamente usando o nome de usuário'
    + #13 + ' do "Admin" e a senha especificada. Esta opção só entra em vigor se a conexão automática ao webadmin'
    + #13 + 'estiver ativada na aba server.';

  lblAllChangesWillbe.Caption :=
    'Todas alterações serão salvas automaticamente';
end;

procedure TFormMain.trckbrFontSizeChange(Sender: TObject);
begin
  fontSize := trckbrFontSize.Position;
  Self.Font.Size := fontSize;
  alignControlAtoControlB(cbbRedirectEnabled, lblCustomRedirect);
  alignControlAtoControlB(cbWorkshopDMStatus, lblWkspDownMan);
  alignControlAtoControlB(trckbrFontSize, lblFontSize);
  alignControlAtoControlB(cbbLanguage, lblLanguage);
  alignControlAtoControlB(cbStatusWeb, lblDescWebAdmin);
  alignControlAtoControlB(edtPort, lblDescWebPort);
  alignControlAtoControlB(edtWebPass, lblWebPass);
  alignControlAtoControlB(cbbTheme, lblTheme);

end;

procedure TFormMain.wb1DocumentComplete(ASender: TObject;
  const pDisp: IDispatch; const URL: OleVariant);
begin
  if autoLoginWebAdmin then
  begin

    if URL = 'http://127.0.0.1:' + edtPort.Text + '/ServerAdmin/' then
      autoLoginWb;

  end;

end;

procedure TFormMain.alignControlAtoControlB(elementA, elementB: TControl);
begin
  try
    elementA.Top := elementB.Top + Round(elementB.Height / 2) -
      Round(elementA.Height / 2);

    elementA.Left := elementB.Left + elementB.Width + 5;
  except
    serverTool.LogEvent('Error', 'Error aligncontrolAToB');
  end;

end;

procedure TFormMain.InstallRegBrowserKey();
var
  R: TRegistry;
begin
  try
    R := TRegistry.Create(KEY_WRITE);
    R.RootKey := HKEY_LOCAL_MACHINE;
    try
      if not R.OpenKey
        ('SOFTWARE\WOW6432Node\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION',
        True) then
        RaiseLastOSError;
      R.WriteInteger(ExtractFileName(Application.ExeName), 9999);
    finally
      R.Free;
    end;
  except

  end;
end;

end.
