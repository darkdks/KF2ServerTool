unit Queue;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExControls, JvSpeedButton, ExtCtrls, ComCtrls, Menus, AddItem;

type
  TfrmQueue = class(TForm)
    lvQueue: TListView;
    pnl1: TPanel;
    btnRemove: TJvSpeedButton;
    btnAddNew: TJvSpeedButton;
    btnProced: TJvSpeedButton;
    pmAdd: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    procedure btnProcedClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure AddWorkshopMapClick(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lvQueueCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lvQueueClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lvQueueChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
  private
    procedure callBackAdd(itemID: String);
    { Private declarations }
  public
  var
    addType: TKFItemType
    { Public declarations }
    end;

  var
    frmQueue: TfrmQueue;

implementation

{$R *.dfm}

uses
  Main, MiscFunc, Workshop;

procedure TfrmQueue.AddWorkshopMapClick(Sender: TObject);
var
  frmAdd: TFormAdd;
  mdResult: Integer;
  itemID, lgAddWkspItem, lgWkspIdUrl, lgInvalidUrlID, inputText: string;
  Item: TListItem;
  isMod: Boolean;
begin
  frmAdd := TFormAdd.Create(Self);
  mdResult := mrNone;
  try

    if FormMain.appLanguage = 'BR' then
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
        frmAdd.edtID.Text := itemID;
        frmAdd.SetAddType(addType);

        mdResult := frmAdd.ShowModal;

        if mdResult = mrOk then
        begin
          Item := lvQueue.Items.Add;
          Item.Caption := frmAdd.itemID;
          Item.SubItems.Add(BoolToWord(frmAdd.addWkspRedirect));
          isMod := addType = WorkshopItem;
          if isMod then
          begin
            Item.SubItems.Add(BoolToWord(False));
            Item.SubItems.Add(BoolToWord(False));
          end
          else
          begin
            Item.SubItems.Add(BoolToWord(frmAdd.addMapENtry));
            Item.SubItems.Add(BoolToWord(frmAdd.addMapCycle));
          end;

          Item.SubItems.Add(BoolToWord(frmAdd.downloadNow));
          if FormMain.appLanguage = 'BR' then
            Item.SubItems.Add('Pendente')
          else
            Item.SubItems.Add('Pending');

        end;
      end
      else
      begin

        ShowMessage('Invalid ID/URL');
      end;

    end;
  finally
    frmAdd.Free;
  end;
end;

procedure TfrmQueue.btnProcedClick(Sender: TObject);
var
  ItemName: string;
  itemID: string;
  slItems, i: Integer;
  itemsDone: Integer;
  modalResult: Integer;
  addWkspRedirect, downloadNow, addMapCycle, addMapENtry: Boolean;
begin

  if lvQueue.Items.Count < 0 then
  begin
    ShowMessage('You need add some items to download');
    Exit;
  end
  else
  begin
    slItems := FormMain.getSelectedCount(lvQueue);
    itemsDone := 0;
    modalResult := mrNone;

    try

      for i := 0 to lvQueue.Items.Count - 1 do
      begin
        // For more than one item
        ItemName := '';
        itemID := lvQueue.Items[i].Caption;
        addWkspRedirect := UpperCase(lvQueue.Items[i].SubItems[0]) = 'TRUE';
        addMapENtry := UpperCase(lvQueue.Items[i].SubItems[1]) = 'TRUE';
        addMapCycle := UpperCase(lvQueue.Items[i].SubItems[2]) = 'TRUE';
        downloadNow := UpperCase(lvQueue.Items[i].SubItems[3]) = 'TRUE';

        lvQueue.Items[i].SubItems[4] := 'Working';
        try
          if FormMain.serverTool.InstallWorkshopItem(itemID, ItemName,
            addWkspRedirect, downloadNow, addMapCycle, addMapENtry) then
          begin

            lvQueue.Items[i].SubItems[4] := 'Sucess';
          end
          else
          begin
            lvQueue.Items[i].SubItems[4] := 'Falied';
          end;
        except
          lvQueue.Items[i].SubItems[4] := 'Falied';

        end;

      end;
      ShowMessage('All items finished');
    except
      on E: Exception do
        ShowMessage(E.Message);
    end;
  end;

end;

procedure TfrmQueue.btnRemoveClick(Sender: TObject);
var
  i: Integer;
begin

  if lvQueue.Selected = nil then
  begin
    ShowMessage('Select na item first.');
    Exit;
  end
  else
  begin
    lvQueue.Update;
    for i := 0 to lvQueue.Items.Count - 1 do
    begin
      if lvQueue.Items[i].Selected then
        lvQueue.Items[i].Delete;

    end;
    lvQueue.Update;
    btnProced.Enabled := lvQueue.Items.Count > 0;
  end;
end;

procedure TfrmQueue.FormCreate(Sender: TObject);
begin
  btnRemove.Enabled := False;
  btnProced.Enabled := False;
  if FormMain.appLanguage = 'BR' then
  begin
    btnRemove.Caption := 'Remover';
    btnAddNew.Caption := 'Adicionar';
    btnProced.Caption := 'Proceder';
    lvQueue.Columns[1].Caption := 'Ad. inscrição';
    lvQueue.Columns[2].Caption := 'Ad. entrada do mapa';
    lvQueue.Columns[3].Caption := 'Ad. ao ciclo de mapas';
    lvQueue.Columns[4].Caption := 'Baixar agora';
    MenuItem1.Caption := 'ID/URL da workshop';
    MenuItem2.Caption := 'Procurar na workshop';
  end;

end;

procedure TfrmQueue.FormShow(Sender: TObject);
begin
  if addType = TKFItemType.WorkshopMap then
  begin

  end;
  if addType = TKFItemType.WorkshopItem then
  begin
    lvQueue.Columns[2].Width := 0;
    lvQueue.Columns[3].Width := 0;
    lvQueue.Columns[2].MaxWidth := 1;
    lvQueue.Columns[3].MaxWidth := 1;
    lvQueue.Columns[2].Caption := '';
    lvQueue.Columns[3].Caption := '';

  end;
end;

procedure TfrmQueue.lvQueueChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  btnProced.Enabled := lvQueue.Items.Count > 0;
end;

procedure TfrmQueue.lvQueueClick(Sender: TObject);
begin
  if lvQueue.Selected <> nil then
  begin

    btnRemove.Enabled := True;
  end
  else
  begin
    btnRemove.Enabled := False;
  end;
end;

procedure TfrmQueue.lvQueueCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  with lvQueue.Canvas.Brush do
  begin
    if (Item.Index mod 2) = 0 then
      Color := clInactiveBorder
    else
      Color := clWhite;
  end;
end;

procedure TfrmQueue.MenuItem2Click(Sender: TObject);
var

  frmWksp: TFormWorkshop;
  textToFind: string;
  itemID: string;
  isMod: Boolean;
  lgFindAItemWksp, lgSearchFor: string;
  mdResult: Integer;

begin
  mdResult := mrNone;
  if FormMain.appLanguage = 'BR' then
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
      isMod := addType = WorkshopItem;
      frmWksp.callBackAdd := callBackAdd;
      if isMod then
        itemID := frmWksp.BrowserItem(TWkspType.WorkshopMod, textToFind)
      else
        itemID := frmWksp.BrowserItem(TWkspType.WorkshopMap, textToFind);

    finally
      frmWksp.Free;

    end;

  end;

end;

procedure TfrmQueue.callBackAdd(itemID: String);
var
  frmAdd: TFormAdd;
  mdResult: Integer;
  Item: TListItem;
begin

  if itemID <> '' then
  begin
    frmAdd := TFormAdd.Create(Self);
    try
      if addType = WorkshopItem then
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
        Item := lvQueue.Items.Add;
        Item.Caption := frmAdd.itemID;
        Item.SubItems.Add(BoolToWord(frmAdd.addWkspRedirect));
        if addType = WorkshopItem then
        begin
          Item.SubItems.Add(BoolToWord(False));
          Item.SubItems.Add(BoolToWord(False));
        end
        else
        begin
          Item.SubItems.Add(BoolToWord(frmAdd.addMapENtry));
          Item.SubItems.Add(BoolToWord(frmAdd.addMapCycle));
        end;
        Item.SubItems.Add(BoolToWord(frmAdd.downloadNow));

        if FormMain.appLanguage = 'BR' then  begin
          Item.SubItems.Add('Pendente');
          Application.MessageBox( 'Sucesso, item adicionado a fila.', 'Sucesso',
            MB_OK + MB_ICONINFORMATION);
        end else begin
          Item.SubItems.Add('Pending');
          Application.MessageBox('Sucess, item added to queue.', 'Sucess' ,
            MB_OK + MB_ICONINFORMATION);

        end;


      end;

    finally
      frmAdd.Free;
    end;
  end;

end;

end.
