unit ItemProgress;

interface

uses
  Classes, Controls, Forms,
  StdCtrls, ComCtrls, JvProgressBar, JvExComCtrls, ExtCtrls;

type
  TformPB = class(TForm)
    lblStatus: TLabel;
    btnCancel: TButton;
    pbStatus: TProgressBar;
    tmrUndeterminedPB: TTimer;
    lblTitle: TLabel;
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tmrUndeterminedPBTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }

  public
    procedure UpdateStatus(status: string);
    procedure SetPBMax(value: Integer);
    function GetPBMax(): Integer;
    procedure SetPBValue(value: Integer);
    procedure NextPBValue(status: String);

  var
    cancel: Boolean;
    { Public declarations }
  end;

var
  formPB: TformPB;

implementation

uses main;
{$R *.dfm}

procedure TformPB.btnCancelClick(Sender: TObject);
begin
  cancel := True;
  btnCancel.Enabled := False;
  lblStatus.Caption :=
    FormMain._s('Canceling, please wait this item finish...');
end;

procedure TformPB.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  tmrUndeterminedPB.Enabled := False;
end;

procedure TformPB.FormCreate(Sender: TObject);
begin
  cancel := False;
  btnCancel.Enabled := True;
  lblTitle.Caption := '';
end;

function TformPB.GetPBMax: Integer;
begin
  Result := pbStatus.Max;
end;

procedure TformPB.NextPBValue(status: String);
begin
  if pbStatus.Position < pbStatus.Max then
    pbStatus.Position := pbStatus.Position + 1;
  if status <> '' then
    UpdateStatus(status);
end;

procedure TformPB.SetPBMax(value: Integer);
begin
  pbStatus.Max := value;
  Application.ProcessMessages;
end;

procedure TformPB.SetPBValue(value: Integer);
begin

  pbStatus.Position := value;
  Application.ProcessMessages;
end;

procedure TformPB.tmrUndeterminedPBTimer(Sender: TObject);
begin
  if pbStatus.Position < pbStatus.Max then
    pbStatus.Position := pbStatus.Position + 1
  else
    pbStatus.Position := 0;
  Application.ProcessMessages;
end;

procedure TformPB.UpdateStatus(status: string);
begin
  lblStatus.Caption := status;
  Application.ProcessMessages;

end;

end.
