{
Postovani citaoce ovog komentara. Unit u nastavku koji ces pogledati namjenjen za design time rest komponentu.
Ovo komponentu sam pravio prema svojim potrebama i sada sam je modifikovao za potrebe testnog zadatka.
Komentare sam obrisao tako da ukoliko razumijes logiku na raspolaganju ti je da nastavis razvoj
}
unit URESTKlijent;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope,System.Net.HttpClient, System.Json, Vcl.Grids, Vcl.DBGrids, REST.Response.Adapter,REST.Authenticator.Basic;

  type

  TMRRESTKlijentProperties = class(TPersistent)
  private
    FAktiviraj : Boolean;
    FMRName : String;
    FMRVrijednost : String;
    FMRKind : TRESTRequestParameterKind;
    FMROptions : TRESTRequestParameterOptions;
  published
   property MRAktiviraj : Boolean read FAktiviraj write FAktiviraj;
   property MRName : String read FMRName write FMRName;
   property MRVrijednost : String read FMRVrijednost write FMRVrijednost;
   property MRKind : TRESTRequestParameterKind read FMRKind write FMRKind;
   property MROptions : TRESTRequestParameterOptions read FMROptions write FMROptions;
  end;

  TMRRESTKlijent = class(TComponent)
    private
    {Privatne deklaracije}
    FOwner : TComponent;

    FRESTKlijent : TRESTClient;
    FRESTRequest : TRESTRequest;
    FRESTResponse : TRESTResponse;
    FMRAccept : String;
    FBaseUrl : String;
    FMREndpoint : String;
    FMRContentType : String;
    FMRParametri : WideString;
    FMRAllowCookies : Boolean;
    FMRMethods : TRESTRequestMethod;
    FMRAuth: TMRRESTKlijentProperties;

    procedure MRDodajParametar(AParam : String);
    public
    FResponseCode : Integer;
    FParam: TRESTRequestParameter;
    {Javne deklaracije}
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    function Execute : String;
    published
    property MRAccept : String read FMRAccept write FMRAccept;
    property MRAllowCookies : Boolean read FMRAllowCookies write FMRAllowCookies default True;
    property MRBaseUrl : String read FBaseUrl Write FBaseUrl;
    property MREndpoint : String read FMREndpoint Write FMREndpoint;
    property MRContentType : String read FMRContentType Write FMRContentType;
    property MRMethods : TRESTRequestMethod read FMRMethods write FMRMethods;
    property MRParametri : WideString read FMRParametri write FMRParametri;
    property MRAuth: TMRRESTKlijentProperties read FMRAuth write FMRAuth;
  end;


implementation

{ TEiRESTKlijent }

constructor TMRRESTKlijent.Create(AOwner : TComponent);
begin
  inherited;
  FOwner := AOwner;
  FMRAuth:= TMRRESTKlijentProperties.Create;

  FBaseUrl :='http://apidemo.luceed.hr';

  FRESTKlijent := TRESTClient.Create(FBaseUrl);

  FRESTResponse := TRESTResponse.Create(nil);

  FRESTRequest := TRESTRequest.Create(nil);
  FRESTRequest.Client := FRESTKlijent;
  FRESTRequest.Response := FRESTResponse;

end;

destructor TMRRESTKlijent.Destroy;
begin
  FRESTKlijent.Free;
  FRESTRequest.Free;
  FRESTResponse.Free;
  FMRAuth.Free;
  inherited;
end;

procedure TMRRESTKlijent.MRDodajParametar(AParam: String);
begin

  FRESTKlijent.Authenticator := THTTPBasicAuthenticator.Create('luceed_mb', '7e5y2Uza');


  if MRAuth.MRAktiviraj then
  begin
    FRESTRequest.Params.AddItem(MRAuth.MRName,MRAuth.MRVrijednost,MRAuth.MRKind,MRAuth.MROptions);
  end;
end;

function TMRRESTKlijent.Execute: String;
var
 prepraviBaseUrl : String;
begin
  FRESTKlijent.BaseURL := FBaseUrl + FMREndpoint;

  FRESTRequest.Method :=FMRMethods;

  MRDodajParametar(MRParametri);
  try
    try
      FRESTRequest.Execute;
    except on E : Exception do
      begin
        //
      end;
    end;
  finally
    FRESTRequest.Params.Clear;
    FResponseCode := FRESTResponse.StatusCode;
    Result :=FRESTResponse.Content;
  end;
end;
end.
