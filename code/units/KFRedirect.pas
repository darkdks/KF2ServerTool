unit KFRedirect;

interface

uses
  Classes,
  SysUtils, MiscFunc,
{$IFDEF WIN32}
  Forms,
  MSHTML, ComObj, ActiveX,
{$ELSE}
{$ENDIF}
  IDHttp, Variants;

type

  TKFRedirect = class(TObject)

  private
    function getUrlText(URL: String): TStringList;

  public
    function getRedirectItems(URL: String): TStringList;
    function removeFile(itemName, ItemFolder: string;
      searchSubFolder: Boolean): Boolean;

  var

    constructor Create();
    destructor Destroy; override;

  end;

implementation

{ TKFRedirect }

constructor TKFRedirect.Create();
begin

end;

destructor TKFRedirect.Destroy;
begin

  inherited;
end;

function TKFRedirect.removeFile(itemName, ItemFolder: string;
  searchSubFolder: Boolean): Boolean;
var
  files: TStringList;
begin
  Result := False;
  if searchSubFolder then
  begin
    files := GetAllFilesSubDirectory(ItemFolder, itemName)
  end
  else
  begin
    files.Add(ItemFolder + itemName)
  end;

  try
    try
      if files.Count > 0 then
        Result := FileOperation(files, '', 3 { FO_DELETE } )
      else
        Result := True;
    finally
      FreeAndNil(files);
    end;
  except

  end

end;

function TKFRedirect.getRedirectItems(URL: String): TStringList;
var
  itemsText: TStringList;
  i: integer;
  lineC: string;
  posKF, posKFM: integer;
  mapName: string;
begin
  itemsText := getUrlText(URL);
  Result := TStringList.Create;
  try
    try
      for i := 0 to itemsText.Count - 1 do
      begin

        lineC := Trim(itemsText[i]);
        posKF := Pos('KF-', UpperCase(lineC));
        posKFM := Pos('.KFM', UpperCase(lineC));
        if (posKF > 0) and (posKFM > 0) and (posKFM > posKF) then
        begin
          mapName := Copy(lineC, posKF,  posKFM - posKF + 4);
          Result.Add(mapName);
        end;


      end;
    finally

    end;
  except
    On E: Exception do
    begin
      raise Exception.Create('Falied to load items from URL.');
      Result.Clear;
    end;
  end;

end;

function TKFRedirect.getUrlText(URL: String): TStringList;
{$IFDEF WIN32}
var
  IDoc: IHTMLDocument2;
  sHTMLFile: String;
  v: Variant;
  httpRequest: TIdHTTP;
begin
  httpRequest := TIdHTTP.Create(nil);
  sHTMLFile := httpRequest.Get(URL);
  IDoc := CreateComObject(Class_HTMLDOcument) as IHTMLDocument2;
  Result := TStringList.Create;
  try
    try
      IDoc.designMode := 'on';
      while IDoc.readyState <> 'complete' do
        Application.ProcessMessages;
      v := VarArrayCreate([0, 0], VarVariant);
      v[0] := sHTMLFile;
      IDoc.write(PSafeArray(System.TVarData(v).VArray));
      IDoc.designMode := 'off';
      while IDoc.readyState <> 'complete' do
        Application.ProcessMessages;
      Result.Text := IDoc.body.innerText;
    finally
      IDoc := nil;
      FreeAndNil(httpRequest);
    end;

  except
    Result.Clear;
  end;

end;
{$ELSE}

begin
  Result := TStringList.Create;
  raise Exception.Create('No implemented yet');
end;
{$ENDIF}
{ TKFRedirectDownloadManager }

end.
