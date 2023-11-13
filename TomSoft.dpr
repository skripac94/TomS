program TomSoft;

uses
  Vcl.Forms,
  UfrmPocetna in 'UfrmPocetna.pas' {frmPocetna},
  UfrmRadna in 'UfrmRadna.pas' {frmRadna},
  URESTKlijent in 'URESTKlijent.pas',
  UfrmPeriodOdDo in 'UfrmPeriodOdDo.pas' {frmPeriodOdDo},
  UrptObracunPlacanje in 'UrptObracunPlacanje.pas' {rptObracunPlacanja: TQuickRep},
  UrptObracunArtikli in 'UrptObracunArtikli.pas' {rptObracunArtikli: TQuickRep};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPocetna, frmPocetna);
  Application.Run;
end.
