unit AddItem;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms,
  StdCtrls, JvLabel, JvEdit,
  MiscFunc, JvExStdCtrls, JvExControls, ExtCtrls, Dialogs, Menus;

type
  TKFItemType = (WorkshopMap,
    WorkshopItem, ReinstallWorkshopMap, ReinstallWorkshopItem,
    UnknowedWorkshopItem, LocalOrRedirectItem, OfficialItem,
    RedirectMap, backupWorkhopMap);

  TFormAdd = class(TForm)
    pnlWorkshopID: TPanel;
    edtID: TJvEdit;
    pnlClient: TPanel;
    chkDoForAll: TCheckBox;
    chkAddMapEntry: TCheckBox;
    chkAddMapCycle: TCheckBox;
    chkDownloadItem: TCheckBox;
    chkAddWorkshopRedirect: TCheckBox;
    pnlBottom: TPanel;
    btnCancel: TButton;
    btnOk: TButton;
    pnl3: TPanel;
    edtItemName: TJvEdit;
    pnlRedirectURL: TPanel;
    edtRedirectURL: TJvEdit;
    btnFindMapRedirectNames: TButton;
    jvlbl1: TLabel;
    jvlbl4: TLabel;
    lblPn3: TLabel;
    jvlbl2: TLabel;
    procedure BrowseClick(Sender: TObject);
    procedure chkDownloadItemClick(Sender: TObject);
    procedure edtIDExit(Sender: TObject);
    procedure edtIDChange(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFindMapRedirectNamesClick(Sender: TObject);

  private
    FrmItemType: TKFItemType;
    procedure createItemsNameRedirectForm;
    { Private declarations }
  public
    procedure SetAddType(AddType: TKFItemType);

    { Public declarations }
  var
    ItemName, ItemID: string;
    addWkspRedirect, downloadNow, addMapCycle, addMapENtry: Boolean;
  end;

var
  FormAdd: TFormAdd;

implementation

uses
  Workshop, Main, uRedirectItemsDialog;
{$R *.dfm}

procedure TFormAdd.BrowseClick(Sender: TObject);
var
  frmwksp: TFormWorkshop;
begin

  frmwksp := TFormWorkshop.Create(Self);
  try
    if frmwksp.BrowserItem(TWkspType.WorkshopMap, '') <> '' then
    begin
      edtID.Text := frmwksp.ItemBrowserId;

    end;

  finally
    frmwksp.Free;
  end;

end;

procedure TFormAdd.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFormAdd.btnFindMapRedirectNamesClick(Sender: TObject);
begin

 if FrmItemType = RedirectMap then
 createItemsNameRedirectForm();

end;

procedure TFormAdd.createItemsNameRedirectForm();
var
  frmRedirectContent: TfrmRedirectItemsDialog;
  mdResult: Integer;
  redirectURL: String;
begin
  redirectURL := edtRedirectURL.Text;
  if redirectURL = '' then
  begin
    ShowMessage('First configure the redirect URL');
    Exit;
  end;
  frmRedirectContent := TfrmRedirectItemsDialog.Create(Self);
  try
    try
      if frmRedirectContent.loadListFromRedirect(redirectURL) then
      begin
        mdResult := frmRedirectContent.ShowModal;
        if (mdResult = mrOk) and (frmRedirectContent.selectedItems <> '') then
          edtItemName.Text := frmRedirectContent.selectedItems;

      end else begin
        raise Exception.Create('Falied to load item from URL: ' + redirectURL);
      end;
    finally
      frmRedirectContent.Free;
    end;
  except
    on E: Exception do
    Application.MessageBox(PWideChar(E.Message + #13 + #13 + 'Make sure you have placed a valid redirect URL.'), 'Error loading files from URL', MB_OK +
      MB_ICONWARNING);

  end;

end;

procedure TFormAdd.btnOkClick(Sender: TObject);

begin
  try
    try
      Self.Hide;

      addWkspRedirect := chkAddWorkshopRedirect.Checked;
      downloadNow := chkDownloadItem.Checked;
      if (ItemName <> '') and ((FrmItemType in [ReinstallWorkshopMap,
          ReinstallWorkshopItem, OfficialItem,
          LocalOrRedirectItem])) then
      begin
        addMapCycle := chkAddMapCycle.Checked;
        addMapENtry := chkAddMapEntry.Checked;
      end
      else
      begin
        addMapCycle := chkAddMapCycle.Checked and chkDownloadItem.Checked;
        addMapENtry := chkAddMapEntry.Checked and chkDownloadItem.Checked;

      end;
      ItemID := edtID.Text;

    finally
      if (chkDoForAll.Visible) and (chkDoForAll.Checked) then
        ModalResult := mrAll
      else
        ModalResult := mrOk;
    end;
  except
    on E: Exception do
      Application.MessageBox(PChar(E.Message), 'Error:', MB_OK + MB_ICONSTOP);
  end;
end;

procedure TFormAdd.chkDownloadItemClick(Sender: TObject);
begin
  if not(FrmItemType = TKFItemType.ReinstallWorkshopMap) or
    (FrmItemType = TKFItemType.ReinstallWorkshopItem) then
  begin

    if chkDownloadItem.Checked then
    begin
      chkAddMapEntry.Enabled := true;
      chkAddMapCycle.Enabled := true;
    end
    else
    begin
      chkAddMapEntry.Enabled := false;
      chkAddMapCycle.Enabled := false;
    end;
  end;
end;

procedure TFormAdd.edtIDChange(Sender: TObject);
begin
  if Length(edtID.Text) > 3 then
    btnOk.Enabled := true
  else
    btnOk.Enabled := false;

end;

procedure TFormAdd.edtIDExit(Sender: TObject);
begin
  if Length(edtID.Text) < 12 then
    edtID.Text := cleanInt(edtID.Text)
  else
    edtID.Text := WorkshopURLtoID(edtID.Text);
end;

procedure TFormAdd.FormCreate(Sender: TObject);
begin
  if FormMain.appLanguage = 'BR' then
  begin
    chkAddMapEntry.Caption := 'Adicionar entrada do mapa';
    chkAddMapCycle.Caption := 'Adicionar mapa ao ciclo de mapas';
    chkDownloadItem.Caption := 'Baixar item agora';
    chkAddWorkshopRedirect.Caption := 'Adicionar redirecionamento da workshop';
    btnCancel.Caption := 'Cancelar';

    chkDoForAll.Visible := false;

  end;
end;

procedure TFormAdd.FormShow(Sender: TObject);
begin
  if chkDoForAll.Visible then
    Self.Height := 245
  else
    Self.Height := 220;

  if chkDoForAll.Checked then
    Exit;

  case FrmItemType of




    WorkshopMap:
      begin
        pnlWorkshopID.Visible := true;
        pnlRedirectURL.Visible := false;
        pnl3.Visible := false;
        Self.Caption := 'Add Map';
        chkDownloadItem.Checked := true;
        chkDownloadItem.Visible := true;

        chkAddWorkshopRedirect.Checked := true;
        chkAddWorkshopRedirect.Visible := true;

        chkAddMapEntry.Checked := true;
        chkAddMapEntry.Visible := true;

        chkAddMapCycle.Checked := true;
        chkAddMapCycle.Visible := true;
        edtID.Enabled := false;

        btnOk.Enabled := true;
        Exit;
      end;

    WorkshopItem:
      begin
        pnlWorkshopID.Visible := true;
        pnlRedirectURL.Visible := false;
        pnl3.Visible := false;
        Self.Caption := 'Add Mod';
        chkDownloadItem.Checked := true;
        chkDownloadItem.Visible := true;

        chkAddWorkshopRedirect.Checked := true;
        chkAddWorkshopRedirect.Visible := true;

        chkAddMapEntry.Checked := false;
        chkAddMapEntry.Visible := false;

        chkAddMapCycle.Checked := false;
        chkAddMapCycle.Visible := false;
        edtID.Enabled := false;

        btnOk.Enabled := true;
        Exit;
      end;
    ReinstallWorkshopMap:
      begin
        pnlWorkshopID.Visible := true;
        pnlRedirectURL.Visible := false;
        pnl3.Visible := false;
        Self.Caption := 'Reinstall Map';
        chkDownloadItem.Checked := true;
        chkDownloadItem.Visible := true;

        chkAddWorkshopRedirect.Checked := true;
        chkAddWorkshopRedirect.Visible := true;

        chkAddMapEntry.Checked := true;
        chkAddMapEntry.Visible := true;

        chkAddMapCycle.Checked := true;
        chkAddMapCycle.Visible := true;
        edtID.Enabled := false;

        btnOk.Enabled := true;
        Exit;
      end;

    ReinstallWorkshopItem:
      begin
        pnlWorkshopID.Visible := true;
        pnlRedirectURL.Visible := false;
        pnl3.Visible := false;
        Self.Caption := 'Reinstall Mod';
        chkDownloadItem.Checked := true;
        chkDownloadItem.Visible := true;

        chkAddWorkshopRedirect.Checked := true;
        chkAddWorkshopRedirect.Visible := true;

        chkAddMapEntry.Checked := false;
        chkAddMapEntry.Visible := false;

        chkAddMapCycle.Checked := false;
        chkAddMapCycle.Visible := false;

        edtID.Enabled := false;

        btnOk.Enabled := true;
      end;


     UnknowedWorkshopItem:
      begin
        pnlWorkshopID.Visible := true;
        pnlRedirectURL.Visible := false;
        pnl3.Visible := false;
        Self.Caption := 'Reinstall Unknowed item';
        chkDownloadItem.Checked := true;
        chkDownloadItem.Visible := true;

        chkAddWorkshopRedirect.Checked := true;
        chkAddWorkshopRedirect.Visible := true;

        chkAddMapEntry.Checked := true;
        chkAddMapEntry.Visible := true;

        chkAddMapCycle.Checked := true;
        chkAddMapCycle.Visible := true;
        edtID.Enabled := false;

        btnOk.Enabled := true;
        Exit;
      end;
    OfficialItem:
      begin
        pnlWorkshopID.Visible := false;
        pnlRedirectURL.Visible := false;
        pnl3.Visible := false;
        Self.Caption := 'Reinstall Official';
        chkDownloadItem.Checked := false;
        chkDownloadItem.Visible := false;

        chkAddWorkshopRedirect.Checked := false;
        chkAddWorkshopRedirect.Visible := false;

        chkAddMapEntry.Checked := false;
        chkAddMapEntry.Visible := false;

        chkAddMapCycle.Checked := true;
        chkAddMapCycle.Visible := true;
        edtID.Enabled := false;
        edtID.Visible := false;

        btnOk.Enabled := true;
        jvlbl1.Visible := false;
        if chkDoForAll.Visible then
          Self.Height := 125
        else
          Self.Height := 100;
      end;

    LocalOrRedirectItem:
      begin
        pnlWorkshopID.Visible := false;
        pnlRedirectURL.Visible := false;
        pnl3.Visible := false;
        Self.Caption := 'Reinstall Local or redirect';
        chkDownloadItem.Checked := false;
        chkDownloadItem.Visible := false;

        chkAddWorkshopRedirect.Checked := false;
        chkAddWorkshopRedirect.Visible := false;

        chkAddMapEntry.Checked := true;
        chkAddMapEntry.Visible := true;

        chkAddMapCycle.Checked := true;
        chkAddMapCycle.Visible := true;
        edtID.Enabled := false;
        edtID.Visible := false;

        btnOk.Enabled := true;
        jvlbl1.Visible := false;
        if chkDoForAll.Visible then
          Self.Height := 150
        else
          Self.Height := 125;
      end;

    RedirectMap:
      begin
        pnlWorkshopID.Visible := false;
        pnlRedirectURL.Visible := true;
        pnl3.Visible := true;
        Self.Caption := 'Install from redirect';
        chkDownloadItem.Checked := true;
        chkDownloadItem.Visible := true;

        chkAddWorkshopRedirect.Checked := false;
        chkAddWorkshopRedirect.Visible := false;

        chkAddMapEntry.Checked := true;
        chkAddMapEntry.Visible := true;

        chkAddMapCycle.Checked := true;
        chkAddMapCycle.Visible := true;
        edtID.Enabled := false;
        edtID.Visible := false;

        btnOk.Enabled := true;
        jvlbl1.Visible := false;
        if chkDoForAll.Visible then
          Self.Height := 250
        else
          Self.Height := 275;
      end;
      backupWorkhopMap:
       begin
        pnlWorkshopID.Visible := false;
        pnlRedirectURL.Visible := true;
        pnl3.Visible := true;
        lblPn3.Caption := 'Backup file';
        Self.Caption := 'Restore backup';
        chkDownloadItem.Checked := true;
        chkDownloadItem.Visible := true;

        chkAddWorkshopRedirect.Checked := false;
        chkAddWorkshopRedirect.Visible := false;

        chkAddMapEntry.Checked := true;
        chkAddMapEntry.Visible := true;

        chkAddMapCycle.Checked := true;
        chkAddMapCycle.Visible := true;
        edtID.Enabled := false;
        edtID.Visible := false;

        btnOk.Enabled := true;
        jvlbl1.Visible := false;
        if chkDoForAll.Visible then
          Self.Height := 250
        else
          Self.Height := 275;
      end;

  end;
end;



procedure TFormAdd.SetAddType(AddType: TKFItemType);
begin
  FrmItemType := AddType;
end;

end.
