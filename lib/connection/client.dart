import 'dart:io';
import 'dart:typed_data';

class ClientConnection {
  ClientConnection();

  Future connect() async {
    List<NetworkInterface> listNetworkInterface =
        await NetworkInterface.list(); //get list network connections
    var selectedInterface =
        listNetworkInterface.singleWhere((element) => element.name == 'wlan0');
    var localAddress = selectedInterface.addresses.first.address;
    for (var i = 0; i < 255; i++) {
      
      
    }
    print(localAddress);

    // connect to the socket server
    final socket = await Socket.connect('192.168.2.192', 4567);
    print('Connected to: ${socket.remoteAddress.address}:${socket.remotePort}');

    // listen for responses from the server
    socket.listen(
      // handle data from the server
      (Uint8List data) {
        final serverResponse = String.fromCharCodes(data);
        print('Server: $serverResponse');
      },

      // handle errors
      onError: (error) {
        print(error);
        socket.destroy();
      },

      // handle server ending connection
      onDone: () {
        print('Server left.');
        socket.destroy();
      },
    );

    // send some messages to the server
    await sendMessage(socket, 'Knock, knock.');
    await sendMessage(socket, 'Banana');
    await sendMessage(socket, 'Banana');
    await sendMessage(socket, 'Banana');
    await sendMessage(socket, 'Banana');
    await sendMessage(socket, 'Banana');
    await sendMessage(socket, 'Orange');
    await sendMessage(socket, "Orange you glad I didn't say banana again?");
  }

  Future<void> sendMessage(Socket socket, String message) async {
    print('Client: $message');
    socket.write(message);
    await Future.delayed(Duration(seconds: 2));
  }
}
