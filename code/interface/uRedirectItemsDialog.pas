unit uRedirectItemsDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, KFRedirect, ExtCtrls;

type
  TfrmRedirectItemsDialog = class(TForm)
    lvRedirectItems: TListView;
    pnlBottom: TPanel;
    btnCancel: TButton;
    btnOk: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
  var

    { Private declarations }
  public
    selectedItems: String;
    function loadListFromRedirect(URL: String): Boolean;
    { Public declarations }
  end;

var
  frmRedirectItemsDialog: TfrmRedirectItemsDialog;

implementation

{$R *.dfm}

procedure TfrmRedirectItemsDialog.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmRedirectItemsDialog.btnOkClick(Sender: TObject);
var
  i: Integer;
begin
  if lvRedirectItems.Selected <> nil then
  begin
    for i := 0 to lvRedirectItems.Items.Count - 1 do
    begin
      if lvRedirectItems.Items[i].Selected then
      begin
        if selectedItems <> '' then
          selectedItems := selectedItems + ',' + lvRedirectItems.Items
            [i].Caption
        else
          selectedItems := lvRedirectItems.Items[i].Caption;
      end;
    end;

  end;
  ModalResult := mrOk;
end;

procedure TfrmRedirectItemsDialog.FormShow(Sender: TObject);
begin
  selectedItems := '';
end;

function TfrmRedirectItemsDialog.loadListFromRedirect(URL: String): Boolean;
var
  lItem: TListItem;
  i: Integer;
  KFRedirect: TKFRedirect;
  redirectItems: TStringlist;
begin
  KFRedirect := TKFRedirect.Create;
  try
    try
      redirectItems := KFRedirect.getRedirectItems(URL);
      lvRedirectItems.Clear;
      for i := 0 to redirectItems.Count - 1 do
      begin
        lItem := lvRedirectItems.Items.Add;
        lItem.Caption := redirectItems[i];
      end;
      lvRedirectItems.SortType := stText;
      Result := lvRedirectItems.Items.Count > 0;
    finally
      if Assigned(redirectItems) then
        FreeAndNil(redirectItems);
      FreeAndNil(KFRedirect);
    end;
  except
    On E: Exception do
      raise Exception.Create('Falied to load files list from URL.')
  end;

end;

end.
