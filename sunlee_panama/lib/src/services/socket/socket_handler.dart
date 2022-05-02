import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketConnection {
  IO.Socket socket = IO.io("http://192.168.10.147:3000", <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false,
  });

  void initializeSocket() {
    socket.connect(); //connect the Socket.IO Client to the Server

    print('socket created');
    //SOCKET EVENTS
    // --> listening for connection
    socket.on('connect', (data) {
      print(socket.connected);
    });

    //listen for incoming messages from the Server.
    socket.on('message', (data) {
      print(data); //
    });

    //listens when the client is disconnected from the Server
    socket.on('disconnect', (data) {
      print('disconnect');
    });
  }

  void sendMessage(String msg) {
    socket.connect();
    socket.onConnect((_) {
      print('connect');
      socket.emit('broadcast', msg);
      print(msg);
    });

    /* socket.on('event', (data) => print(data));
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_)); */
  }
}
