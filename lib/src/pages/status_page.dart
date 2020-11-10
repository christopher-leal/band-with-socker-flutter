import 'package:band_names/src/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.message),
          onPressed: () {
            socketService.socket.emit('new-message', {
              'name': 'flutter',
              'mesage': 'hello from flutter',
            });
          },
        ),
        body: Container(
          child: Center(
            child: Text('Server Status ${socketService.serverStatus}'),
          ),
        ));
  }
}
