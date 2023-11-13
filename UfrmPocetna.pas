unit UfrmPocetna;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmPocetna = class(TForm)
    Button1: TButton;
    lbNaslov: TLabel;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPocetna: TfrmPocetna;

implementation

{$R *.dfm}

uses UfrmRadna;

procedure TfrmPocetna.Button1Click(Sender: TObject);
begin
  Application.CreateForm(TfrmRadna,frmRadna);
  frmRadna.ShowModal;
  frmRadna.Free;
end;

end.
