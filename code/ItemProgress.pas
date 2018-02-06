unit ItemProgress;

interface

uses
  Classes, Controls, Forms,
  StdCtrls, ComCtrls, JvProgressBar, JvExComCtrls;

type
  TformPB = class(TForm)
    pb1: TJvProgressBar;
    lblStatus: TLabel;
    btncancel: TButton;
    procedure btncancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
  lblStatus.Caption := 'Canceling action...';
end;

procedure TformPB.FormCreate(Sender: TObject);
begin
cancel := False;
btncancel.Enabled := True;
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

  Application.ProcessMessages;
  pb1.Position := value;
  Application.ProcessMessages;
  Application.ProcessMessages;
  Application.ProcessMessages;
end;

procedure TformPB.UpdateStatus(status: string);
begin
Application.ProcessMessages;
lblStatus.Caption := status;
Application.ProcessMessages;
Application.ProcessMessages;
end;

end.
