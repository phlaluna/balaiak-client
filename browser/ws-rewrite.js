// Incluído no otclient.js via --pre-js (roda na página e nos workers).
// O OTClient web abre "wss://<host>:<porta>" direto no servidor do jogo, que
// só fala TCP. Aqui a conexão é redirecionada para a ponte WebSocket->TCP da
// mesma origem da página: ws(s)://<origem>/ws/<porta>. Assim o IP devolvido
// pelo login (LOGIN_IP) é ignorado e tudo passa por uma única porta HTTP(S).
(function () {
  var G = typeof globalThis !== "undefined" ? globalThis : self;
  var Orig = G.WebSocket;
  if (!Orig || Orig.__otcBridge) return;
  var direct = /^wss?:\/\/[^\/]*:(\d+)\/?$/;
  function BridgedWebSocket(url, protocols) {
    var m = direct.exec(String(url));
    if (m) {
      var scheme = G.location.protocol === "https:" ? "wss://" : "ws://";
      url = scheme + G.location.host + "/ws/" + m[1];
    }
    return protocols === undefined ? new Orig(url) : new Orig(url, protocols);
  }
  BridgedWebSocket.prototype = Orig.prototype;
  BridgedWebSocket.CONNECTING = Orig.CONNECTING;
  BridgedWebSocket.OPEN = Orig.OPEN;
  BridgedWebSocket.CLOSING = Orig.CLOSING;
  BridgedWebSocket.CLOSED = Orig.CLOSED;
  BridgedWebSocket.__otcBridge = true;
  G.WebSocket = BridgedWebSocket;
})();
