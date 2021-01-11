unit uNewConfig;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, JvExMask,
  JvToolEdit;

type
  TformNewConfig = class(TForm)
    lblPCGAMEPATH: TLabel;
    lblPCENGINEPATH: TLabel;
    chkOnlyItemsFromConfig: TCheckBox;
    inputKFEnginePath: TJvFilenameEdit;
    inputKFGamePath: TJvFilenameEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnCancel: TButton;
    btnOk: TButton;
    edtConfigName: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure checkForEnableOK(Sender: TObject);
  private

    { Private declarations }
  public
    { Public declarations }
    procedure SetDirInitialPath(path: string);
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

    if FileExists(ExtractFilePath(Application.ExeName) + edtConfigName.Text)
    then
      raise Exception.Create
        (formMain._s
        ('The KFServerTool configuration file already exists. Specify another name.')
        );

    if FileExists(inputKFEnginePath.FileName) = False then
      raise Exception.Create
        (formMain._s
        ('The specified KFEngine file does not exist. Specify a valid file.'));
    if FileExists(inputKFGamePath.FileName) = False then
      raise Exception.Create
        (formMain._s
        ('The specified KFGame file does not exist. Specify a valid file.'));
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
btnOk.Enabled := (edtConfigName.Text <> '')  and (inputKFEnginePath.FileName <> '') and  (inputKFGamePath.FileName <> '')
end;

procedure TformNewConfig.FormShow(Sender: TObject);
begin
btnOk.Enabled := false;
end;

procedure TformNewConfig.SetDirInitialPath(path: string);
begin
  inputKFEnginePath.InitialDir := path;
  inputKFGamePath.InitialDir := path;
end;

end.
