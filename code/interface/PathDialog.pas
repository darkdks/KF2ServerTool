unit PathDialog;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms,
  StdCtrls, JvBrowseFolder, Dialogs, JvBaseDlg;

type
  TkfPathDialog = class(TForm)
    btnConfigurePath: TButton;
    btnInstallServer: TButton;
    lblDescriptionHelp: TLabel;
    dlgServerBrowser: TJvBrowseForFolderDialog;
    procedure btnConfigurePathClick(Sender: TObject);
    procedure btnInstallServerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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

procedure TkfPathDialog.btnConfigurePathClick(Sender: TObject);
begin
  // dlgServerBrowser.RootDirectoryPath := GetCurrentDir;
  if dlgServerBrowser.Execute then
  begin
    FormMain.customServerPath := dlgServerBrowser.Directory;
    Self.ModalResult := 101;
  end;
end;

procedure TkfPathDialog.btnInstallServerClick(Sender: TObject);
begin

  case Application.MessageBox
    (PWideChar(FormMain._s('This will download and install the KF2 Server in ')
      + extractFilePath(Application.ExeName)
      + '. ' + #13#10 + FormMain._s('this will take time depending on your internet connection.')),
    FormMain._p('Install Killing Floor 2 Server'), MB_OKCANCEL + MB_ICONQUESTION) of
    IDOK:
      begin
          Self.ModalResult := 102;
      end;
  end;


end;

procedure TkfPathDialog.FormCreate(Sender: TObject);
begin
lblDescriptionHelp.Caption := FormMain._s('To use this tool you need to select the path of your existing server or install a new one. \nWhat do you want to do?');
btnConfigurePath.Caption := FormMain._s('Configure the path');
btnInstallServer.Caption := FormMain._s('Install a new server');
end;

end.
