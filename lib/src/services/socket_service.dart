import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;
  ServerStatus get serverStatus => _serverStatus;
  set serverStatus(ServerStatus status) {
    _serverStatus = status;
    notifyListeners();
  }

  IO.Socket get socket => _socket;
  set socket(IO.Socket val) {
    _socket = val;
    notifyListeners();
  }

  SocketService() {
    initConfig();
  }

  void initConfig() {
    socket = IO.io('http://192.168.100.5:3000', {
      'transports': ['websocket'],
      'autoConnect': true,
      // 'extraHeaders': {'foo': 'bar'} // optional
    });

    socket.on('connect', (_) {
      serverStatus = ServerStatus.Online;
      print('connect');
    });

    socket.on('disconnect', (_) {
      serverStatus = ServerStatus.Offline;
      print('disconnect');
    });

    // socket.on('new-message', (newMessage) {
    //   print(newMessage);
    // });
  }
}
