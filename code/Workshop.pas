unit Workshop;

interface

uses
  SysUtils, Variants, Classes, Controls, Forms, StdCtrls, ExtCtrls, OleCtrls,
  SHDocVw;

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
    procedure wb1NavigateComplete2(ASender: TObject; const pDisp: IDispatch; var URL: OleVariant);
    procedure btnBackClick(Sender: TObject);
    procedure btnForwardClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function BrowserItem(BrowserType: TWkspType; SearchText: string): string;
  private


    { Private declarations }
  public
    procedure NavigateBW(URL: string);
    var
      ItemBrowserId, TempID: string;
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

function TFormWorkshop.BrowserItem(BrowserType: TWkspType; SearchText: string): string;
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
  Self.Close;
  ItemBrowserId := TempID;
end;

procedure TFormWorkshop.FormCreate(Sender: TObject);
begin
  lblTip.Visible := false;
  btnForward.Enabled := false;
  btnBack.Enabled := false;

  if FormMain.appLanguage = 'BR' then
  begin
    lblTip.Caption := 'Procure pelo item, entre em sua página da workshop e clique no botão Adicionar';
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
  result := '';
  DOM := wb.Document;
  if wb.LocationURL <> '' then
  begin
    result := DOM.Body.OuterHTML;
  end;
end;

procedure TFormWorkshop.wb1NavigateComplete2(ASender: TObject; const pDisp: IDispatch; var URL: OleVariant);
var
  ItemID: string;
  UrlTemp: string;
  i: Integer;
begin
  if Pos('?id=', URL) > 0 then
  begin
    UrlTemp := Copy(URL, Pos('?id=', URL) + 4, length(URL) - Pos('?id=', URL) + 4);
    for i := 1 to length(UrlTemp) do
    begin
      if CharInSet(UrlTemp[i], ['0'..'9']) then
      begin
        ItemID := ItemID + UrlTemp[i];
      end
      else
      begin
        Break;
      end;

    end;
    btnAdd.Enabled := True;
    lblId.Caption := 'ID: ' + ItemID;
    TempID := ItemID;
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

end.

