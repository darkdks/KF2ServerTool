unit AddItem;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms,
  StdCtrls, JvLabel, JvEdit,
  MiscFunc, JvExStdCtrls, JvExControls, ExtCtrls, Dialogs, Menus, KFRedirect,
  KFTypes;

type
  TKFItemType = (WorkshopMap, WorkshopItem, ReinstallWorkshopMap,
    ReinstallWorkshopItem, UnknowedWorkshopItem, LocalOrRedirectItem,
    OfficialItem, RedirectMap, RedirectMod, backupWorkhopMap, LocalItem);

  TFormAdd = class(TForm)
    pnlWorkshopID: TPanel;
    edtWorkshopID: TJvEdit;
    pnlOptions: TPanel;
    chkDoForAll: TCheckBox;
    chkAddMapEntry: TCheckBox;
    chkAddMapCycle: TCheckBox;
    chkDownloadItem: TCheckBox;
    chkAddWorkshopRedirect: TCheckBox;
    pnlBottom: TPanel;
    btnCancel: TButton;
    btnOk: TButton;
    pnlItemName: TPanel;
    edtItemName: TJvEdit;
    pnlRedirectURL: TPanel;
    edtRedirectURL: TJvEdit;
    btnFindMapRedirectNames: TButton;
    lblWorkshopID: TLabel;
    lblRedirectURL: TLabel;
    lblItemName: TLabel;
    lblOptions: TLabel;
    lblItemNameNote: TLabel;
    procedure BrowseClick(Sender: TObject);
    procedure chkDownloadItemClick(Sender: TObject);
    procedure edtWorkshopIDExit(Sender: TObject);
    procedure edtWorkshopIDChange(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFindMapRedirectNamesClick(Sender: TObject);

  private
    FrmItemType: TKFItemType;
    procedure createItemsNameRedirectForm(itemType: TKFRedirectItemType);
    function CalculateWindownHeight: Integer;
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
      edtWorkshopID.Text := frmwksp.ItemBrowserId;

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
  case FrmItemType of
    RedirectMap:
      createItemsNameRedirectForm(KFRmap);
    RedirectMod:
      createItemsNameRedirectForm(KFRmod);
    LocalItem:
      begin
        with TOpenDialog.Create(Self) do
        begin
          Filter := 'Killing Floor 2 Map file (*.kfm)|*.kfm';
          if Execute() then
          begin
            if Pos('KF', UpperCase(ExtractFileName(FileName))) <> 1 then
              raise Exception.Create
                (FormMain._s
                ('Invalid prefix name in the file map. Must be KF*.kfm'))
            else
              edtItemName.Text := FileName;
          end;
          Destroy;
        end;
      end;
  end;
end;

procedure TFormAdd.createItemsNameRedirectForm(itemType: TKFRedirectItemType);
var
  frmRedirectContent: TfrmRedirectItemsDialog;
  mdResult: Integer;
  redirectURL: String;
begin
  redirectURL := edtRedirectURL.Text;
  if redirectURL = '' then
  begin
    ShowMessage(FormMain._s('First configure the redirect URL'));
    Exit;
  end;
  frmRedirectContent := TfrmRedirectItemsDialog.Create(Self);
  try
    try
      if frmRedirectContent.loadListFromRedirect(redirectURL, itemType) then
      begin
        mdResult := frmRedirectContent.ShowModal;
        if (mdResult = mrOk) and (frmRedirectContent.selectedItems <> '') then
          edtItemName.Text := frmRedirectContent.selectedItems;

      end
      else
      begin
        raise Exception.Create(FormMain._s('Failed to load item from URL: ') +
          redirectURL);
      end;
    finally
      frmRedirectContent.Free;
    end;
  except
    on E: Exception do
      Application.MessageBox(PWideChar(E.Message + #13 + #13 +
        FormMain._s('Make sure you have placed a valid redirect URL.')),
        FormMain._p('Error loading files from URL'), MB_OK + MB_ICONWARNING);

  end;

end;

procedure TFormAdd.btnOkClick(Sender: TObject);

begin
  try
    try
      Self.Hide;

      addWkspRedirect := chkAddWorkshopRedirect.Checked;
      downloadNow := chkDownloadItem.Checked;
      if (ItemName <> '') and
        ((FrmItemType in [ReinstallWorkshopMap, ReinstallWorkshopItem,
        OfficialItem, LocalOrRedirectItem])) then
      begin
        addMapCycle := chkAddMapCycle.Checked;
        addMapENtry := chkAddMapEntry.Checked;
      end
      else
      begin
        if FrmItemType = LocalItem then
        begin
          addMapCycle := chkAddMapCycle.Checked;
          addMapENtry := chkAddMapEntry.Checked;
        end
        else
        begin
          addMapCycle := chkAddMapCycle.Checked and chkDownloadItem.Checked;
          addMapENtry := chkAddMapEntry.Checked and chkDownloadItem.Checked;

        end;

      end;
      ItemID := edtWorkshopID.Text;

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

procedure TFormAdd.edtWorkshopIDChange(Sender: TObject);
begin
  if Length(edtWorkshopID.Text) > 3 then
    btnOk.Enabled := true
  else
    btnOk.Enabled := false;

end;

procedure TFormAdd.edtWorkshopIDExit(Sender: TObject);
begin
  if Length(edtWorkshopID.Text) < 12 then
    edtWorkshopID.Text := cleanInt(edtWorkshopID.Text)
  else
    edtWorkshopID.Text := WorkshopURLtoID(edtWorkshopID.Text);
end;

procedure TFormAdd.FormCreate(Sender: TObject);
begin
  with FormMain do
  begin
    chkAddMapEntry.Caption := _s(chkAddMapEntry.Caption);
    chkAddMapCycle.Caption := _s(chkAddMapCycle.Caption);
    chkDownloadItem.Caption := _s(chkDownloadItem.Caption);
    chkAddWorkshopRedirect.Caption := _s(chkAddWorkshopRedirect.Caption);
    lblItemNameNote.Caption := _s(lblItemNameNote.Caption);
    lblItemName.Caption := _s(lblItemName.Caption);
    btnCancel.Caption := _s(btnCancel.Caption);
    lblRedirectURL.Caption := _s(lblRedirectURL.Caption);

    chkDoForAll.Visible := false;
  end;
end;

procedure TFormAdd.FormShow(Sender: TObject);
begin

  if chkDoForAll.Checked then
    Exit;
  lblItemNameNote.Visible := false;
  case FrmItemType of

    WorkshopMap:
      begin
        pnlWorkshopID.Visible := true;
        pnlRedirectURL.Visible := false;
        pnlItemName.Visible := false;
        Self.Caption := FormMain._s('Add Map');
        chkDownloadItem.Checked := true;
        chkDownloadItem.Visible := true;

        chkAddWorkshopRedirect.Checked := true;
        chkAddWorkshopRedirect.Visible := true;

        chkAddMapEntry.Checked := true;
        chkAddMapEntry.Visible := true;

        chkAddMapCycle.Checked := true;
        chkAddMapCycle.Visible := true;
        edtWorkshopID.Enabled := false;

        btnOk.Enabled := true;
      end;

    WorkshopItem:
      begin
        pnlWorkshopID.Visible := true;
        pnlRedirectURL.Visible := false;
        pnlItemName.Visible := false;
        Self.Caption := FormMain._s('Add Mod');
        chkDownloadItem.Checked := true;
        chkDownloadItem.Visible := true;

        chkAddWorkshopRedirect.Checked := true;
        chkAddWorkshopRedirect.Visible := true;

        chkAddMapEntry.Checked := false;
        chkAddMapEntry.Visible := false;

        chkAddMapCycle.Checked := false;
        chkAddMapCycle.Visible := false;
        edtWorkshopID.Enabled := false;

        btnOk.Enabled := true;
      end;
    ReinstallWorkshopMap:
      begin
        pnlWorkshopID.Visible := true;
        pnlRedirectURL.Visible := false;
        pnlItemName.Visible := false;
        Self.Caption := FormMain._s('Reinstall Map');
        chkDownloadItem.Checked := true;
        chkDownloadItem.Visible := true;

        chkAddWorkshopRedirect.Checked := true;
        chkAddWorkshopRedirect.Visible := true;

        chkAddMapEntry.Checked := true;
        chkAddMapEntry.Visible := true;

        chkAddMapCycle.Checked := true;
        chkAddMapCycle.Visible := true;
        edtWorkshopID.Enabled := false;

        btnOk.Enabled := true;
      end;

    ReinstallWorkshopItem:
      begin
        pnlWorkshopID.Visible := true;
        pnlRedirectURL.Visible := false;
        pnlItemName.Visible := false;
        Self.Caption := FormMain._s('Reinstall Mod');
        chkDownloadItem.Checked := true;
        chkDownloadItem.Visible := true;

        chkAddWorkshopRedirect.Checked := true;
        chkAddWorkshopRedirect.Visible := true;

        chkAddMapEntry.Checked := false;
        chkAddMapEntry.Visible := false;

        chkAddMapCycle.Checked := false;
        chkAddMapCycle.Visible := false;

        edtWorkshopID.Enabled := false;

        btnOk.Enabled := true;
      end;

    UnknowedWorkshopItem:
      begin
        pnlWorkshopID.Visible := true;
        pnlRedirectURL.Visible := false;
        pnlItemName.Visible := false;
        Self.Caption := FormMain._s('Reinstall unknown item');
        chkDownloadItem.Checked := true;
        chkDownloadItem.Visible := true;

        chkAddWorkshopRedirect.Checked := true;
        chkAddWorkshopRedirect.Visible := true;

        chkAddMapEntry.Checked := true;
        chkAddMapEntry.Visible := true;

        chkAddMapCycle.Checked := true;
        chkAddMapCycle.Visible := true;
        edtWorkshopID.Enabled := false;

        btnOk.Enabled := true;
        Exit;
      end;
    OfficialItem:
      begin
        pnlWorkshopID.Visible := false;
        pnlRedirectURL.Visible := false;
        pnlItemName.Visible := false;
        Self.Caption := FormMain._s('Reinstall Official');
        chkDownloadItem.Checked := false;
        chkDownloadItem.Visible := false;

        chkAddWorkshopRedirect.Checked := false;
        chkAddWorkshopRedirect.Visible := false;

        chkAddMapEntry.Checked := false;
        chkAddMapEntry.Visible := false;

        chkAddMapCycle.Checked := true;
        chkAddMapCycle.Visible := true;
        edtWorkshopID.Enabled := false;
        edtWorkshopID.Visible := false;

        btnOk.Enabled := true;
        lblWorkshopID.Visible := false;
      end;

    LocalOrRedirectItem:
      begin
        pnlWorkshopID.Visible := false;
        pnlRedirectURL.Visible := false;
        pnlItemName.Visible := false;
        Self.Caption := FormMain._s('Reinstall Local or redirect');
        chkDownloadItem.Checked := false;
        chkDownloadItem.Visible := false;

        chkAddWorkshopRedirect.Checked := false;
        chkAddWorkshopRedirect.Visible := false;

        chkAddMapEntry.Checked := true;
        chkAddMapEntry.Visible := true;

        chkAddMapCycle.Checked := true;
        chkAddMapCycle.Visible := true;
        edtWorkshopID.Enabled := false;
        edtWorkshopID.Visible := false;

        btnOk.Enabled := true;
        lblWorkshopID.Visible := false;
      end;

    LocalItem:
      begin
        pnlWorkshopID.Visible := false;
        pnlRedirectURL.Visible := false;
        pnlItemName.Visible := true;
        Self.Caption := FormMain._s('Local item');
        chkDownloadItem.Checked := false;
        chkDownloadItem.Visible := false;

        lblItemName.Caption := FormMain._s('Map File:');
        chkAddWorkshopRedirect.Checked := false;
        chkAddWorkshopRedirect.Visible := false;

        chkAddMapEntry.Checked := true;
        chkAddMapEntry.Visible := true;

        chkAddMapCycle.Checked := true;
        chkAddMapCycle.Visible := true;
        edtWorkshopID.Enabled := false;
        edtWorkshopID.Visible := false;

        btnOk.Enabled := true;
        lblWorkshopID.Visible := false;
      end;

    RedirectMap:
      begin
        pnlWorkshopID.Visible := false;
        pnlRedirectURL.Visible := true;
        pnlItemName.Visible := true;
        Self.Caption := FormMain._s('Install from redirect');
        chkDownloadItem.Checked := true;
        chkDownloadItem.Visible := true;
        lblItemNameNote.Visible := true;
        chkAddWorkshopRedirect.Checked := false;
        chkAddWorkshopRedirect.Visible := false;

        chkAddMapEntry.Checked := true;
        chkAddMapEntry.Visible := true;

        chkAddMapCycle.Checked := true;
        chkAddMapCycle.Visible := true;
        edtWorkshopID.Enabled := false;
        edtWorkshopID.Visible := false;

        btnOk.Enabled := true;
        lblWorkshopID.Visible := false;

      end;

    RedirectMod:
      begin
        pnlWorkshopID.Visible := false;
        pnlRedirectURL.Visible := true;
        pnlItemName.Visible := true;
        Self.Caption := FormMain._s('Install from redirect');
        chkDownloadItem.Checked := true;
        chkDownloadItem.Visible := true;
        chkDownloadItem.Enabled := false;

        chkAddWorkshopRedirect.Checked := false;
        chkAddWorkshopRedirect.Visible := false;

        chkAddMapEntry.Checked := false;
        chkAddMapEntry.Visible := false;

        chkAddMapCycle.Checked := false;
        chkAddMapCycle.Visible := false;
        edtWorkshopID.Enabled := false;
        edtWorkshopID.Visible := false;

        btnOk.Enabled := true;
        lblWorkshopID.Visible := false;
      end;

    backupWorkhopMap:
      begin
        pnlWorkshopID.Visible := false;
        pnlRedirectURL.Visible := true;
        pnlItemName.Visible := true;
        lblItemName.Caption := FormMain._s('Backup file');
        Self.Caption := FormMain._s('Restore backup');
        chkDownloadItem.Checked := true;
        chkDownloadItem.Visible := true;

        chkAddWorkshopRedirect.Checked := false;
        chkAddWorkshopRedirect.Visible := false;

        chkAddMapEntry.Checked := true;
        chkAddMapEntry.Visible := true;

        chkAddMapCycle.Checked := true;
        chkAddMapCycle.Visible := true;
        edtWorkshopID.Enabled := false;
        edtWorkshopID.Visible := false;

        btnOk.Enabled := true;
        lblWorkshopID.Visible := false;

      end;

  end;
  Application.ProcessMessages;
  Self.Height := CalculateWindownHeight;
end;

procedure TFormAdd.SetAddType(AddType: TKFItemType);
begin
  FrmItemType := AddType;
end;

function TFormAdd.CalculateWindownHeight(): Integer;
var
  winHeight: Integer;
  WinMargin: Integer;
  latestItemTop: Integer;
  i: Integer;
  pnlComponent: TControl;
  panelMargin: Integer;
begin
  winHeight := 0;
  WinMargin := 40;
  latestItemTop := 0;
  panelMargin := 1;
  try
    if pnlWorkshopID.Visible then
      winHeight := winHeight + pnlWorkshopID.Height + panelMargin;

    if pnlRedirectURL.Visible then
      winHeight := winHeight + pnlRedirectURL.Height + panelMargin;

    if pnlItemName.Visible then
      winHeight := winHeight + pnlItemName.Height + panelMargin;

    if pnlOptions.Visible then
    begin
      for i := 0 to Self.ComponentCount - 1 do
      begin
        if (Self.Components[i] is TControl) and
          (Self.Components[i].GetParentComponent = pnlOptions) then
        begin
          pnlComponent := (Self.Components[i] as TControl);
          if (pnlComponent.Visible) and (latestItemTop < pnlComponent.Top) then
            latestItemTop := pnlComponent.Top + pnlComponent.Height;
        end;
      end;
      winHeight := winHeight + latestItemTop + panelMargin;
    end;

    if pnlBottom.Visible then
      winHeight := winHeight + pnlBottom.Height + panelMargin;
    Result := winHeight + WinMargin;
  except
    Result := 450; // fail safe value
  end;
end;

end.
