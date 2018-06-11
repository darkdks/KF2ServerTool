unit ItemProgress;

interface

uses
  Classes, Controls, Forms,
  StdCtrls, ComCtrls, JvProgressBar, JvExComCtrls, ExtCtrls;

type
  TformPB = class(TForm)
    lblStatus: TLabel;
    btncancel: TButton;
    pb1: TProgressBar;
    tmrUndeterminedPB: TTimer;
    lblTitle: TLabel;
    procedure btncancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tmrUndeterminedPBTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }

  public
    procedure UpdateStatus(status: string);
    procedure SetPBMax(value: Integer);
    function GetPBMax():Integer;
    procedure SetPBValue(value: Integer);
    procedure NextPBValue(Status: String);
  var
  cancel: Boolean;
    { Public declarations }
  end;

var
  formPB: TformPB;

implementation

{$R *.dfm}

procedure TformPB.btncancelClick(Sender: TObject);
begin
  cancel := True;
  btncancel.Enabled := False;
  lblStatus.Caption := 'Canceling, please wait this item finish...';
end;

procedure TformPB.FormClose(Sender: TObject; var Action: TCloseAction);
begin
tmrUndeterminedPB.Enabled := false;
end;

procedure TformPB.FormCreate(Sender: TObject);
begin
cancel := False;
btncancel.Enabled := True;
lblTitle.Caption := '';
end;

function TformPB.GetPBMax: Integer;
begin
Result := pb1.Max;
end;

procedure TformPB.NextPBValue(status: String);
begin
  if pb1.Position < pb1.Max then
  pb1.Position := pb1.Position +1;
  if Status <> '' then
   UpdateStatus(Status);
end;

procedure TformPB.SetPBMax(value: Integer);
begin
pb1.Max := value;
Application.ProcessMessages;
end;

procedure TformPB.SetPBValue(value: Integer);
begin

  pb1.Position := value;
  Application.ProcessMessages;
end;

procedure TformPB.tmrUndeterminedPBTimer(Sender: TObject);
begin
if pb1.Position < pb1.Max then
pb1.Position := pb1.Position + 1 else pb1.Position := 0;
Application.ProcessMessages;
end;

procedure TformPB.UpdateStatus(status: string);
begin
lblStatus.Caption := status;
Application.ProcessMessages;

end;

end.
