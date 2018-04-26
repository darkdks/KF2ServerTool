program Project2;

uses
  Vcl.Forms,
  Unit1 in '..\..\..\..\..\Embarcadero\Studio\Projects\testExploreOperation\Unit1.pas' {Form1},
  MiscFunc in 'MiscFunc.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
