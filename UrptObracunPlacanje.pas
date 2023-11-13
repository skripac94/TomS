unit UrptObracunPlacanje;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, ADODB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TrptObracunPlacanja = class(TQuickRep)
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    fdmIzvjestaj: TFDMemTable;
    QRLabel1: TQRLabel;
    qrOd: TQRLabel;
    qrDo: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRDBText1: TQRDBText;
    fdmIzvjestajVrstaPlacanja: TStringField;
    fdmIzvjestajNaziv: TStringField;
    fdmIzvjestajIznos: TCurrencyField;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRBand4: TQRBand;
    QRLabel6: TQRLabel;
    QRExpr1: TQRExpr;
  private

  public

  end;

var
  rptObracunPlacanja: TrptObracunPlacanja;

implementation


{$R *.DFM}

end.

