unit KFRedirect;

interface

uses
   Classes,
  SysUtils, MiscFunc,
  {$IFDEF WIN32}
   MSHTML, ComObj, ActiveX, 
  {$ELSE}
  {$ENDIF}

   IDHttp, Variants, IdComponent;

type
  TRDMOnProgress = procedure(currentPosition: Int64) of object;
  TRDMOnStarted = procedure(fileSize: Int64) of object;
  TRDMOnFinished = procedure() of object;

  TKFRedirectDownloadManager = class(TObject)
  private
    FileDSize: int64;
    FileDPostion: int64;
    FileDStatus: String;

    FTRDMOnProgress: TRDMOnProgress;
    FTRDMOnStarted: TRDMOnStarted;
    FTRDMOnFinished: TRDMOnFinished;

  var
  public
    property OnDownloadProgress
      : TRDMOnProgress read FTRDMOnProgress write FTRDMOnProgress;
    property OnDownloadStarted
      : TRDMOnStarted read FTRDMOnStarted write FTRDMOnStarted;
    property OnDownloadFinished
      : TRDMOnFinished read FTRDMOnFinished write FTRDMOnFinished;

  var
    FileDAbort: ^Boolean;
    constructor Create();
    destructor Destroy; override;

  end;

  TKFRedirect = class(TObject)

  private
    function getUrlText(URL: String): TStringList;
    procedure IdHTTPWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure IdHTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);

  var

    downloadManager: TKFRedirectDownloadManager;

  public
    function getRedirectItems(URL: String): TStringList;
    function downloadFile(URL: String; Destination: string;
      var dlManager: TKFRedirectDownloadManager): Boolean;
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

function TKFRedirect.downloadFile(URL: String; Destination: string;
  var dlManager: TKFRedirectDownloadManager): Boolean;
var
  IdHTTP1: TIdHTTP;
  Stream: TMemoryStream;
begin

  downloadManager := dlManager;
  Result := False;
  IdHTTP1 := TIdHTTP.Create(nil);
  Stream := TMemoryStream.Create;
  try
    IdHTTP1.OnWork := IdHTTPWork;
    IdHTTP1.OnWorkBegin := IdHTTPWorkBegin;
    try
      IdHTTP1.Get(URL, Stream);
      if downloadManager.FileDSize = downloadManager.FileDPostion then
      begin
        downloadManager.OnDownloadFinished();
        Stream.SaveToFile(Destination);
        Result := FileExists(Destination);
      end
      else
      begin
        Result := False;
      end;
    except
      Result := False;
    end;

  finally
    FreeAndNil(Stream);
    FreeAndNil(IdHTTP1);
  end;
end;

procedure TKFRedirect.IdHTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin

  if Assigned(downloadManager) then
  begin
    downloadManager.FileDSize := AWorkCountMax;
    downloadManager.OnDownloadStarted(AWorkCountMax);

  end;
end;

procedure TKFRedirect.IdHTTPWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
  var dlAborted: Boolean;
begin

  if Assigned(downloadManager) then
  begin
      dlAborted := (downloadManager.FileDAbort)^;
    if dlAborted then
    begin
      if ASender is TIdHTTP then (ASender as TIdHTTP)
        .Disconnect;
      raise Exception.Create('Download Canceled');
      Exit;
    end;
    downloadManager.FileDPostion := AWorkCount;
    downloadManager.OnDownloadProgress(AWorkCount);
  end;
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
        Result := FileOperation(files, '', 3{FO_DELETE})
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
begin
  itemsText := getUrlText(URL);
  Result := TStringList.Create;
  try
    try
      for i := 0 to itemsText.Count - 1 do
      begin

        lineC := Trim(itemsText[i]);
        if (Pos('KF-', UpperCase(lineC)) = 1) and
          (Pos('.KFM', UpperCase(lineC)) = Length(lineC) - 3) then
          Result.Add(lineC);

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

      v := VarArrayCreate([0, 0], VarVariant);
      v[0] := sHTMLFile;
      IDoc.write(PSafeArray(System.TVarData(v).VArray));
      IDoc.designMode := 'off';
      while IDoc.readyState <> 'complete' do

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

constructor TKFRedirectDownloadManager.Create;
begin
  FileDSize := 0;
  FileDPostion := 0;
  FileDStatus := 'undertemined';
  FileDAbort := nil;
end;

destructor TKFRedirectDownloadManager.Destroy;
begin

  inherited;
end;

end.
