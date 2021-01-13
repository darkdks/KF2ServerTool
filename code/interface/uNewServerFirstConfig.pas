unit uNewServerFirstConfig;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  JvExStdCtrls, JvEdit;

type
  TformNewServerFirstConfig = class(TForm)
    lblTipText1: TLabel;
    lblTipTextTitle: TLabel;
    gbServer: TGroupBox;
    lblServerName: TLabel;
    edtNCServerName: TJvEdit;
    edtNCServerPort: TJvEdit;
    lblServerPort: TLabel;
    lblWebPort: TLabel;
    edtNCWebPort: TJvEdit;
    pnlBottom: TPanel;
    btnOk: TButton;
    lblTipText2: TLabel;
    cbClearMapEntries: TCheckBox;
    procedure filterEdit(Sender: TObject; var Key: Char);
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formNewServerFirstConfig: TformNewServerFirstConfig;

implementation

{$R *.dfm}

uses
  Main;

procedure TformNewServerFirstConfig.btnOkClick(Sender: TObject);
begin
  try
    if edtNCServerName.Text = '' then
      raise Exception.Create(FormMain._s('Invalid server name'));
    try
      StrToInt(edtNCServerPort.Text);
    except
      raise Exception.Create(FormMain._s('Invalid server port'));
    end;
    try
      StrToInt(edtNCWebPort.Text);
    except
      raise Exception.Create(FormMain._s('Invalid web port'));
    end;

  except
    on E: Exception do
    begin
      ShowMessage(E.Message);
      ModalResult := mrNone;
    end;
  end;
end;

procedure TformNewServerFirstConfig.filterEdit(Sender: TObject; var Key: Char);
begin
  if not(Key in [#8, '0' .. '9']) then
    Key := #0;

end;

procedure TformNewServerFirstConfig.FormShow(Sender: TObject);
begin
  FormMain.alignControlAtoControlB(edtNCServerName, lblServerName);
  FormMain.alignControlAtoControlB(edtNCServerPort, lblServerPort);
  FormMain.alignControlAtoControlB(edtNCWebPort, lblWebPort);
end;

end.
