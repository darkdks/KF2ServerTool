unit AddMap;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms,
  StdCtrls, JvLabel, JvEdit,
  UFuncoes, JvExStdCtrls, JvExControls;

type
  TAddType = (AddWorkshopMap, AddWorkshopMod, EditWorkshopMap,
    EditWorkshopItem, ReinstallWorkshopMap, ReinstallWorkshopItem,
    UnknowedWorkshopItem);

  TFormAdd = class(TForm)
    edtID: TJvEdit;
    jvlbl1: TJvLabel;
    chkAddMapEntry: TCheckBox;
    chkAddMapCycle: TCheckBox;
    Browse: TButton;
    btnOk: TButton;
    btnCancel: TButton;
    chkDownloadItem: TCheckBox;
    chkAddWorkshopRedirect: TCheckBox;
    lbl1: TLabel;
    chkDoForAll: TCheckBox;
    procedure BrowseClick(Sender: TObject);
    procedure chkDownloadItemClick(Sender: TObject);
    procedure edtIDExit(Sender: TObject);
    procedure edtIDChange(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    FrmAddType: TAddType;
    { Private declarations }
  public
    procedure SetAddType(AddType: TAddType);

    { Public declarations }
  var
    ItemName, ItemID: string;
    addWkspRedirect, downloadNow, addMapCycle, addMapENtry: Boolean;
  end;

var
  FormAdd: TFormAdd;

implementation

uses
  Workshop, Main;
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

procedure TFormAdd.btnOkClick(Sender: TObject);

begin
  try
    try
      Self.Hide;
      if edtID.Text <> '' then
      begin

        addWkspRedirect := chkAddWorkshopRedirect.Checked;
        downloadNow := chkDownloadItem.Checked;
        if (ItemName <> '') and ((FrmAddType = TAddType.ReinstallWorkshopMap)
            or (FrmAddType = TAddType.ReinstallWorkshopItem)) then
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

      end;
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
  if not(FrmAddType = TAddType.ReinstallWorkshopMap) or
    (FrmAddType = TAddType.ReinstallWorkshopItem) then
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
    lbl1.Caption := '';
    chkDoForAll.Visible := false;

  end;
end;

procedure TFormAdd.FormShow(Sender: TObject);
begin
  if chkDoForAll.Checked then
    Exit;

  if FrmAddType = AddWorkshopMap then
  begin
    Self.Caption := 'Add Map';
    chkDownloadItem.Checked := true;
    chkDownloadItem.Visible := true;

    chkAddMapEntry.Checked := true;
    chkAddMapEntry.Visible := true;

    chkAddWorkshopRedirect.Checked := true;
    chkAddWorkshopRedirect.Visible := true;

    chkAddMapCycle.Checked := true;
    chkAddMapCycle.Visible := true;
    edtID.Text := '';
    edtID.Enabled := true;
    Browse.Visible := true;
    btnOk.Enabled := false;
    Exit;
  end;
  if FrmAddType = AddWorkshopMod then
  begin
    Self.Caption := 'Add Mod';
    chkDownloadItem.Checked := true;
    chkDownloadItem.Visible := true;

    chkAddWorkshopRedirect.Checked := true;
    chkAddWorkshopRedirect.Visible := true;

    chkAddMapEntry.Checked := false;
    chkAddMapEntry.Visible := false;

    chkAddMapCycle.Checked := false;
    chkAddMapCycle.Visible := false;
    edtID.Enabled := true;
    Browse.Visible := true;
    edtID.Text := '';
    btnOk.Enabled := false;
    Exit;
  end;
  if FrmAddType = EditWorkshopMap then
  begin
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
    Browse.Visible := false;
    btnOk.Enabled := true;
    Exit;
  end;

  if FrmAddType = EditWorkshopItem then
  begin
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
    Browse.Visible := false;
    btnOk.Enabled := true;
    Exit;
  end;
  if FrmAddType = ReinstallWorkshopMap then
  begin
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
    Browse.Visible := false;
    btnOk.Enabled := true;
    Exit;
  end;

  if FrmAddType = ReinstallWorkshopItem then
  begin
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
    Browse.Visible := false;
    btnOk.Enabled := true;
  end;

end;

procedure TFormAdd.SetAddType(AddType: TAddType);
begin
  FrmAddType := AddType;
end;

end.
