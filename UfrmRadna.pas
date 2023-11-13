unit UfrmRadna;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, REST.Types, Data.DB, Vcl.StdCtrls,
  Vcl.Menus, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.ExtCtrls, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope,URESTKlijent,JSON,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmRadna = class(TForm)
    pnlNavigator: TPanel;
    StatusBar1: TStatusBar;
    DBGrid1: TDBGrid;
    mnuRadni: TMainMenu;
    Izvjetaji1: TMenuItem;
    btnPretrazi: TButton;
    fdmRadni: TFDMemTable;
    dsRadni: TDataSource;
    edtPretraga: TEdit;
    cbxOdZapisa: TComboBox;
    cbxBrojZapisa: TComboBox;
    MPobrPlac: TMenuItem;
    procedure pribaviPodatke(pocinjeSa, odZapisa, brojZapisa : String);
    procedure upuniGrid(strJSONData : String);
    procedure btnPretraziClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MPobrPlacClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRadna: TfrmRadna;

implementation

{$R *.dfm}

uses UfrmPeriodOdDo;



procedure TfrmRadna.btnPretraziClick(Sender: TObject);
begin
 if edtPretraga.Text ='' then
 begin
  ShowMessage('Unesite parametar za pretragu!');
  Exit;
 end;

 if Length(cbxOdZapisa.Text)=9 then
 begin
  ShowMessage('Odaberite vrijednost od kog zapisa zelite podatke!');
  Exit;
 end;
 if Length(cbxBrojZapisa.Text)=13 then
 begin
  ShowMessage('Odaberite vrijednost koliko zapisa zelite da prikazete!');
  Exit;
 end;

 pribaviPodatke(edtPretraga.Text,cbxOdZapisa.Text,cbxBrojZapisa.Text);
end;

procedure TfrmRadna.FormCreate(Sender: TObject);
begin
    //Definisanje polja u DataSet-u
    fdmRadni.FieldDefs.Add('id',TFieldType.ftInteger);
    fdmRadni.FieldDefs.Add('naziv',TFieldType.ftString,200,false);
end;

procedure TfrmRadna.MPobrPlacClick(Sender: TObject);
begin
 Application.CreateForm(TfrmPeriodOdDo,frmPeriodOdDo);
 frmPeriodOdDo.ShowModal;
 frmPeriodOdDo.Free;
end;

procedure TfrmRadna.pribaviPodatke(pocinjeSa, odZapisa, brojZapisa: String);
var
  xRESTRequest : TMRRESTKlijent;
  strPorukaOdgovora : String;
begin
  //Pribavljanje podataka od REST servera
   xRESTRequest := TMRRESTKlijent.Create(nil);

  xRESTRequest.MRMethods := rmGET;
  xRESTRequest.MREndpoint := FORMAT('/datasnap/rest/artikli/naziv/%s/[%s,%s]',[pocinjeSa, odZapisa, brojZapisa]);
  xRESTRequest.MRAccept := '';
  xRESTRequest.MRAllowCookies := False;
  xRESTRequest.MRContentType := 'application/json';


  xRESTRequest.MRMethods := rmGET;
  strPorukaOdgovora := xRESTRequest.Execute;
  if xRESTRequest.FResponseCode = 200 then
    upuniGrid(strPorukaOdgovora)
  else
    ShowMessage('Došlo je do greške pri pribavljanju podataka!');

  xRESTRequest.Free;
end;

procedure TfrmRadna.upuniGrid(strJSONData: String);
var
  s, JSON: string;
  jo: TJSONObject;
  myarr: TJSONArray;
  xI : Integer;
begin

  //Obrada JSON odgovora i upunjavanje u DataSet
  jo := TJSONObject.ParseJSONValue(strJSONData) as TJSONObject;
  try
    if jo.TryGetValue('result', myarr) and (myarr.Count > 0) then
      if myarr.Items[0].TryGetValue('artikli', myarr) and (myarr.Count > 0) then
          fdmRadni.Active := True;
          fdmRadni.EmptyDataSet;
          for xI := 0 to myarr.Count - 1 do
          begin
            fdmRadni.Append;
            fdmRadni.FieldByName('id').Value :=myarr.Items[xI].GetValue<String>('id');
            fdmRadni.FieldByName('naziv').AsString :=myarr.Items[xI].GetValue<String>('naziv');
          end;

  finally
    jo.Free;
  end;


end;

end.
