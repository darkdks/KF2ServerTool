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
    selectedItem: String;
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
begin
  if lvRedirectItems.Selected <> nil then
    selectedItem := lvRedirectItems.Selected.Caption;
  ModalResult := mrOk;
end;

procedure TfrmRedirectItemsDialog.FormShow(Sender: TObject);
begin
  selectedItem := '';
end;

function TfrmRedirectItemsDialog.loadListFromRedirect(URL: String): Boolean;
var
  lItem: TListItem;
  I: Integer;
  KFRedirect: TKFRedirect;
  redirectItems: TStringlist;
//  IDHTTP: TIdHTTP;  Get file size is very slow, disabled
begin
  KFRedirect := TKFRedirect.Create;

  try
  try
    redirectItems := KFRedirect.getRedirectItems(URL);
 //   IDHTTP :=  TIdHTTP.Create(nil);
    lvRedirectItems.Clear;

    for I := 0 to redirectItems.Count - 1 do
    begin

      lItem := lvRedirectItems.Items.Add;
      lItem.Caption := redirectItems[I];
      try
 //    IDHTTP.Head(URL + redirectItems[i]);
 //    lItem.SubItems.Add(FormatByteSize(IDHTTP.Response.ContentLength));
      except

      end;
    end;
    lvRedirectItems.SortType := stText;
    Result := lvRedirectItems.Items.Count > 0;
  finally
    if Assigned(redirectItems) then
    FreeAndNil(redirectItems);
 //   IDHTTP.Free;
  end;
  except
  On E: Exception do
  raise Exception.Create('Falied to load files list from URL.');

  end;

end;

end.
