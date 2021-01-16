unit uNewConfig;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, JvExMask,
  JvToolEdit, Vcl.ExtCtrls, System.typinfo;

type
  TformNewConfig = class(TForm)
    lblNewServerCopy: TLabel;
    lblTip1: TLabel;
    pnlBottom: TPanel;
    btnCancel: TButton;
    btnOk: TButton;
    GroupBox1: TGroupBox;
    lblConfigName: TLabel;
    lblKF2ServerTool: TLabel;
    edtConfigName: TEdit;
    lblIni: TLabel;
    lblConfigFolferSubPath: TLabel;
    lblKFGameConfig: TLabel;
    edtConfigFolder: TEdit;
    chkGenerateNewConfig: TCheckBox;
    chkOnlyItemsFromConfig: TCheckBox;
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure checkForEnableOK(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure filterEdit(Sender: TObject; var Key: Char);
  private

    { Private declarations }
  public
    { Public declarations }
    ConfigFolderFullPath: string;
  end;

var
  formNewConfig: TformNewConfig;

implementation

uses
  Main;
{$R *.dfm}

procedure TformNewConfig.btnOkClick(Sender: TObject);
begin
  try

    if FileExists(ExtractFilePath(Application.ExeName) +
      lblKF2ServerTool.Caption + edtConfigName.Text + '.ini') then
      raise Exception.Create
        (formMain._s
        ('The KFServerTool configuration file already exists. Specify another name.')
        );

    if DirectoryExists(ConfigFolderFullPath + edtConfigFolder.Text) then
      if Application.MessageBox
        (formMain._p
        ('This configuration folder already exists, do you want to use it anyway?'),
        formMain._p('Config folder'), MB_YESNO + MB_ICONQUESTION) = mrNo then
        ModalResult := mrNone;

  except
    on E: Exception do
    begin
      ShowMessage(E.Message);
      abort;
    end;
  end;
end;

procedure TformNewConfig.checkForEnableOK(Sender: TObject);
begin
  btnOk.Enabled := ((edtConfigName.Text <> '') and
    (edtConfigFolder.Text <> ''));
  edtConfigFolder.Text := edtConfigName.Text;
end;

procedure TformNewConfig.filterEdit(Sender: TObject; var Key: Char);
begin
  if not(Key in [#8, '0' .. '9', 'a' .. 'z', 'A' .. 'Z']) then
    Key := #0;

  checkForEnableOK(Sender);

end;

procedure TformNewConfig.FormCreate(Sender: TObject);
begin
  chkOnlyItemsFromConfig.Checked := True;
  chkGenerateNewConfig.Checked := True;

end;

procedure TformNewConfig.FormShow(Sender: TObject);
begin
  btnOk.Enabled := false;
  formMain.alignControlAtoControlB(edtConfigName, lblKF2ServerTool);
  formMain.alignControlAtoControlB(lblIni, edtConfigName);
  formMain.alignControlAtoControlB(edtConfigFolder, lblKFGameConfig);
end;

end.
