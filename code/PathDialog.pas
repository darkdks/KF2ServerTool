unit PathDialog;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms,
  StdCtrls, JvBrowseFolder, Dialogs, JvBaseDlg;

type
  TkfPathDialog = class(TForm)
    btn1: TButton;
    btn2: TButton;
    lbl1: TLabel;
    dlgServerBrowser: TJvBrowseForFolderDialog;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  kfPathDialog: TkfPathDialog;

implementation

{$R *.dfm}

uses
  Main;

procedure TkfPathDialog.btn1Click(Sender: TObject);
begin
  // dlgServerBrowser.RootDirectoryPath := GetCurrentDir;
  if dlgServerBrowser.Execute then
  begin
    FormMain.customServerPath := dlgServerBrowser.Directory;
    Self.ModalResult := 101;
  end;
end;

procedure TkfPathDialog.btn2Click(Sender: TObject);
begin

  case Application.MessageBox
    (PWideChar( 'This will download and install the KF2 Server in '
      + extractFilePath(Application.ExeName)
      + '. ' + #13#10 + 'this will take time depending on your internet connection.'),
    'Install Killing Floor 2 Server', MB_OKCANCEL + MB_ICONQUESTION) of
    IDOK:
      begin
          Self.ModalResult := 102;
      end;
  end;


end;

end.
