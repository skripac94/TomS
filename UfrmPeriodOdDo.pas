unit UfrmPeriodOdDo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,JSON,URESTKlijent,REST.Types,QuickRpt;

type
  TfrmPeriodOdDo = class(TForm)
    cbxIzvjestaj: TComboBox;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnPrihvati: TButton;
    procedure btnPrihvatiClick(Sender: TObject);
    procedure pribaviPodatke(datumOd, datumDo,obracun: String;report : TQuickRep);
    procedure populisiDataSet(strJSONData,obracun: String;report : TQuickRep);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPeriodOdDo: TfrmPeriodOdDo;

implementation

{$R *.dfm}

uses UrptObracunPlacanje, UrptObracunArtikli;

procedure TfrmPeriodOdDo.btnPrihvatiClick(Sender: TObject);
begin

  if cbxIzvjestaj.ItemIndex < 0  then
  begin
    ShowMessage('Izaberite tip izvjestaja!');
    Exit;
  end;



  if cbxIzvjestaj.ItemIndex = 0 then
  begin
     Application.CreateForm(TrptObracunPlacanja,rptObracunPlacanja);
    pribaviPodatke(FormatDateTime('dd.mm.yyyy',DateTimePicker1.Date),FormatDateTime('dd.mm.yyyy',DateTimePicker2.Date),'placanja',rptObracunPlacanja);
    rptObracunPlacanja.qrOd.Caption := FormatDateTime('dd.mm.yyyy',DateTimePicker1.Date);
    rptObracunPlacanja.qrDo.Caption := FormatDateTime('dd.mm.yyyy',DateTimePicker2.Date);
    rptObracunPlacanja.QRLabel1.Caption := 'MP Obračun plaćanja u periodu';
    rptObracunPlacanja.Preview;
    rptObracunPlacanja.Free;
    Close;
  end;
  if cbxIzvjestaj.ItemIndex = 1 then
  begin
   Application.CreateForm(TrptObracunArtikli,rptObracunArtikli);
    pribaviPodatke(FormatDateTime('dd.mm.yyyy',DateTimePicker1.Date),FormatDateTime('dd.mm.yyyy',DateTimePicker2.Date),'artikli',rptObracunArtikli);
    rptObracunArtikli.qrOd.Caption := FormatDateTime('dd.mm.yyyy',DateTimePicker1.Date);
    rptObracunArtikli.qrDo.Caption := FormatDateTime('dd.mm.yyyy',DateTimePicker2.Date);
    rptObracunArtikli.QRLabel1.Caption := 'MP Obračun artikala u periodu';
    rptObracunArtikli.Preview;
    rptObracunArtikli.Free;
    Close;
  end;
end;
procedure TfrmPeriodOdDo.pribaviPodatke(datumOd, datumDo, obracun: String;report : TQuickRep);
var
  xRESTRequest : TMRRESTKlijent;
  strPorukaOdgovora : String;
begin
   xRESTRequest := TMRRESTKlijent.Create(nil);

  xRESTRequest.MRMethods := rmGET;
  xRESTRequest.MREndpoint := FORMAT('/datasnap/rest/mpobracun/%s/4986-1/%s/%s',[obracun,datumOd, datumDo]);
  xRESTRequest.MRAccept := '';
  xRESTRequest.MRAllowCookies := False;
  xRESTRequest.MRContentType := 'application/json';


  xRESTRequest.MRMethods := rmGET;
  strPorukaOdgovora := xRESTRequest.Execute;
  if xRESTRequest.FResponseCode = 200 then
    populisiDataSet(strPorukaOdgovora,obracun,report)
  else
    ShowMessage('Došlo je do greške pri pribavljanju podataka!');

  xRESTRequest.Free;
end;
procedure TfrmPeriodOdDo.populisiDataSet(strJSONData,obracun: String;report : TQuickRep);
var
  s, JSON: string;
  jo: TJSONObject;
  myarr: TJSONArray;
  xI : Integer;
begin

  if obracun = 'placanja' then
  begin
    jo := TJSONObject.ParseJSONValue(strJSONData) as TJSONObject;
    try
      if jo.TryGetValue('result', myarr) and (myarr.Count > 0) then
        if myarr.Items[0].TryGetValue('obracun_placanja', myarr) and (myarr.Count > 0) then
            report.DataSet.Active := True;
            for xI := 0 to myarr.Count - 1 do
            begin
              report.DataSet.Append;
              report.DataSet.FieldByName('VrstaPlacanja').Value :=myarr.Items[xI].GetValue<String>('vrste_placanja_uid');
              report.DataSet.FieldByName('Naziv').AsString :=myarr.Items[xI].GetValue<String>('naziv');
              report.DataSet.FieldByName('Iznos').AsString :=myarr.Items[xI].GetValue<String>('iznos');
            end;
    finally
      jo.Free;
    end;
  end;

  if obracun = 'artikli' then
  begin
    jo := TJSONObject.ParseJSONValue(strJSONData) as TJSONObject;
    try
      if jo.TryGetValue('result', myarr) and (myarr.Count > 0) then
        if myarr.Items[0].TryGetValue('obracun_artikli', myarr) and (myarr.Count > 0) then
            report.DataSet.Active := True;
            for xI := 0 to myarr.Count - 1 do
            begin
              report.DataSet.Append;

              report.DataSet.FieldByName('artikl_uid').Value :=myarr.Items[xI].GetValue<String>('artikl_uid');
              report.DataSet.FieldByName('naziv_artikla').AsString :=myarr.Items[xI].GetValue<String>('naziv_artikla');
              report.DataSet.FieldByName('kolicina').AsString :=myarr.Items[xI].GetValue<String>('kolicina');
              report.DataSet.FieldByName('Iznos').AsString :=myarr.Items[xI].GetValue<String>('iznos');
            end;
    finally
      jo.Free;
    end;
  end;
end;
end.
