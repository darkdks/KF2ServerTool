unit Workshop;

interface

uses
  SysUtils, Variants, Classes, Controls, Forms, StdCtrls, ExtCtrls, OleCtrls,
  SHDocVw, MSHTML, dialogs, System.StrUtils;

type
  TWkspType = (WorkshopMap, WorkshopMod);

  TFormWorkshop = class(TForm)
    wb1: TWebBrowser;
    pnl2: TPanel;
    btnForward: TButton;
    btnBack: TButton;
    btnAdd: TButton;
    lblTip: TLabel;
    lblId: TLabel;
    procedure btnBackClick(Sender: TObject);
    procedure btnForwardClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function BrowserItem(BrowserType: TWkspType; SearchText: string): string;
    procedure wbReplaceSubcribe;
    procedure wb1DocumentComplete(ASender: TObject; const pDisp: IDispatch;
      const URL: OleVariant);
    procedure wb1BeforeNavigate2(ASender: TObject; const pDisp: IDispatch;
      const URL, Flags, TargetFrameName, PostData, Headers: OleVariant;
      var Cancel: WordBool);
  private

    { Private declarations }
  public
    procedure NavigateBW(URL: string);

  var
    ItemBrowserId, TempID: string;
    callBackAdd : TProc<string>;
    { Public declarations }
  end;

var
  FormWorkshop: TFormWorkshop;

implementation

uses
  Main;
{$R *.dfm}

procedure TFormWorkshop.btnForwardClick(Sender: TObject);
begin
  wb1.GoForward;
end;

procedure TFormWorkshop.btnBackClick(Sender: TObject);
begin
  wb1.GoBack;
  btnForward.Enabled := True;
end;

function TFormWorkshop.BrowserItem(BrowserType: TWkspType;
  SearchText: string): string;
var
  SteamWkspURL: string;
begin
  SteamWkspURL := 'http://steamcommunity.com/workshop/browse/?appid=232090';
  if SearchText = '' then
  begin

    NavigateBW(SteamWkspURL);
  end
  else
  begin

    NavigateBW(SteamWkspURL + '&searchtext=' + SearchText);

  end;
  Self.ShowModal;
   Result := ItemBrowserId;
end;

procedure TFormWorkshop.btnAddClick(Sender: TObject);
begin
  ItemBrowserId := TempID;

  if Assigned(callBackAdd) then
  callBackAdd(ItemBrowserId)
   else
 Self.Close;

end;

procedure TFormWorkshop.FormCreate(Sender: TObject);
begin
  lblTip.Visible := false;
  btnForward.Enabled := false;
  btnBack.Enabled := false;

  if FormMain.appLanguage = 'BR' then
  begin
    lblTip.Caption :=
      'Procure pelo item, entre em sua página da workshop e clique no botão Adicionar';
    btnAdd.Caption := 'Adicionar';
  end;
end;

procedure TFormWorkshop.NavigateBW(URL: string);
begin
  wb1.Silent := True;
  wb1.Navigate(URL);
  btnBack.Enabled := True;

end;
// get the html code in a string:

function WBGetDocumentHTML(wb: TWebBrowser): string;
var
  DOM: variant;
begin
  Result := '';
  DOM := wb.Document;
  if wb.LocationURL <> '' then
  begin
    Result := DOM.Body.OuterHTML;
  end;
end;

procedure TFormWorkshop.wb1BeforeNavigate2(ASender: TObject;
  const pDisp: IDispatch; const URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
var
  URLTemp, itemID: String;
  I: Integer;
begin
  if (Pos('?id=', URL) > 0) and (Pos('/addToServer', URL) > 0) then
  begin
    URLTemp := Copy(URL, Pos('?id=', URL) + 4, length(URL) - Pos('?id=',
      URL) + 4);
    for I := 1 to length(URLTemp) do
    begin
      if CharInSet(URLTemp[I], ['0' .. '9']) then
      begin
        itemID := itemID + URLTemp[I];
      end
      else
      begin
        Break;
      end;
    end;
    Cancel := True;
    ItemBrowserId := TempID;
    btnAddClick(nil);
  end
end;

procedure TFormWorkshop.wb1DocumentComplete(ASender: TObject;
  const pDisp: IDispatch; const URL: OleVariant);
var
  itemID: string;
  URLTemp: string;
  I: Integer;
begin
  if Pos('?id=', URL) > 0 then
  begin
    wbReplaceSubcribe;
    URLTemp := Copy(URL, Pos('?id=', URL) + 4, length(URL) - Pos('?id=',
      URL) + 4);
    for I := 1 to length(URLTemp) do
    begin
      if CharInSet(URLTemp[I], ['0' .. '9']) then
      begin
        itemID := itemID + URLTemp[I];
      end
      else
      begin
        Break;
      end;
    end;
    btnAdd.Enabled := True;
    lblId.Caption := 'ID: ' + itemID;
    TempID := itemID;
    lblId.Visible := True;

  end
  else
  begin
    btnAdd.Enabled := false;
    TempID := '';
    lblId.Caption := '';
    lblId.Visible := false;
  end;

end;

procedure TFormWorkshop.wbReplaceSubcribe;
var
  TextElement: IHTMLElement;
  Element: IHTMLElement;
  outHTML: String;
begin
  try
    Element := (wb1.Document as IHTMLDocument3)
      .getElementById('SubscribeItemBtn') as IHTMLElement;
    outHTML := Element.OuterHTML;
    outHTML := ReplaceStr(outHTML, 'onclick="SubscribeItem();"',
      'href="' + wb1.LocationURL + '/addToServer"');
    Element.OuterHTML := outHTML;
    TextElement := ((wb1.Document as IHTMLDocument3)
      .getElementById('SubscribeItemOptionAdd') as IHTMLElement);
    if Assigned(TextElement) then
      TextElement.innerText := 'Add to server';
  finally

  end;
end;

end.
