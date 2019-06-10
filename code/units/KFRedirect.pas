unit KFRedirect;

interface

uses
  Classes,
  SysUtils,
  MiscFunc,
{$IFDEF WIN32}
  Forms,
  MSHTML,
  ComObj,
  ActiveX,
{$ELSE}
{$ENDIF}
  IDHttp,
  Variants,
  KFTypes;

type

  TKFRedirect = class(TObject)

  private
    function getUrlText(URL: String): TStringList;

  public
    function getRedirectItems(URL: String; itemsType: TKFRedirectItemType)
      : TStringList;
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
    files := TStringList.Create;
    files.Add(ItemFolder + itemName)
  end;

  try
    try
      if files.Count > 0 then
        Result := FileOperation(files, '', 3 { FO_DELETE } )
      else
        Result := True;
    finally
      if Assigned(files) then
        FreeAndNil(files);
    end;
  except

  end

end;

function TKFRedirect.getRedirectItems(URL: String;
  itemsType: TKFRedirectItemType): TStringList;
var
  itemsText: TStringList;
  i, y: integer;
  lineC: string;
  KFtagPos, extTagPos, spaceTagPos: integer;
  tagSize: integer;
  RDtagName: String;
  itemName: string;
const
  // KF2 File types prefix
  KF_MAPPREFIX = '.KFM';
  KF_MODPREFIX: array [0 .. 3] of string = ('.UPX', '.UPK', '.UC', '.U');

begin
  itemsText := getUrlText(URL);
  Result := TStringList.Create;
  try
    try
      if itemsType = KFRmap then
      begin
        for i := 0 to itemsText.Count - 1 do
        begin
          lineC := Trim(itemsText[i]);
          KFtagPos := Pos('KF-', UpperCase(lineC));
          extTagPos := Pos(KF_MAPPREFIX, UpperCase(lineC));
          if (KFtagPos > 0) and (extTagPos > 0) and (extTagPos > KFtagPos) then
          begin
            itemName := Copy(lineC, KFtagPos, extTagPos - KFtagPos + 4);
            spaceTagPos := Pos(' ', itemName);
            if (spaceTagPos > 0) and (spaceTagPos < KFtagPos) then
              itemName := Copy(itemName, spaceTagPos,
                length(itemName) - spaceTagPos);
            Result.Add(itemName);
          end;
        end;
      end;
      if itemsType = KFRmod then
      begin
        for i := 0 to itemsText.Count - 1 do
        begin
          lineC := Trim(itemsText[i]);
          for y := 0 to High(KF_MODPREFIX) do
          begin
            RDtagName := KF_MODPREFIX[y];
            extTagPos := Pos(RDtagName, UpperCase(lineC));
            if (extTagPos > 0) then
            begin
              tagSize := length(RDtagName);
              itemName := Copy(lineC, 0, extTagPos + tagSize - 1);
              spaceTagPos := Pos(' ', itemName);
              if (spaceTagPos > 0) and (spaceTagPos < extTagPos) then
                itemName := Copy(itemName, spaceTagPos,
                  length(itemName) - spaceTagPos);
              Result.Add(itemName);
              Break
            end;
          end;
        end;
      end;

    finally
      if Assigned(itemsText) then
        FreeAndNil(itemsText);
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
