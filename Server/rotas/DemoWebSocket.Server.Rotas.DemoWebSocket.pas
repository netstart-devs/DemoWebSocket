unit DemoWebSocket.Server.Rotas.DemoWebSocket;

interface

uses
  MVCFramework,
  MVCFramework.Commons,
  MVCFramework.Serializer.Commons,
  System.Generics.Collections,
  DemoWebSocket.Server.Controller.WebSocket,
  System.JSON,
  REST.JSON,
  DemoWebSocket.Server.Modules.DemosWebSocket;

type

  [MVCPath('/api')]
  TServerRotasDemoWebSocket = class(TMVCController)
  public
    [MVCPath]
    [MVCHTTPMethod([httpGET])]
    [MVCProduces(TMVCMediaType.TEXT_HTML)]
    function Index: String;

    [MVCPath('/notificaConectados')]
    [MVCHTTPMethod([httpPOST])]
    procedure notifica(dados: TWebContext);

  end;

implementation

uses
  System.StrUtils,
  System.SysUtils,
  MVCFramework.Logger;

function TServerRotasDemoWebSocket.Index: String;
begin
  // use Context property to access to the HTTP request and response
  Result := '<p>Hello <strong>DelphiMVCFramework</strong> World</p>' + '<p><small>dmvcframework-' + DMVCFRAMEWORK_VERSION + '</small></p>';
end;

procedure TServerRotasDemoWebSocket.notifica(dados: TWebContext);
var LDadosRecebidos, LRetorno: TJSONObject;
begin
  LDadosRecebidos := TJSONObject.Create;
  LDadosRecebidos := TJSONObject.ParseJSONValue(dados.Request.Body) as TJSONObject;

  LRetorno := TJSONObject.Create;
  LRetorno.AddPair('mensagem', 'Sucesso');

  GWSServer.BroadcastText(LDadosRecebidos.ToJSON);

  Render(201, String(LRetorno.ToString));

end;

end.
