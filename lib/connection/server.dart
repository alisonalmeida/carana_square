// ignore_for_file: prefer_const_constructors

import 'dart:typed_data';
import 'dart:io';

class ServerConnection {
  ServerConnection();

  Future init() async {
    List<NetworkInterface> listNetworkInterface =
        await NetworkInterface.list(); //get list network connections
    var selectedInterface =
        listNetworkInterface.singleWhere((element) => element.name == 'wlan0');
    var localAddress = selectedInterface.addresses.first.address;
    print(selectedInterface.addresses.first.address);
    // bind the socket server to an address and port
    final server = await ServerSocket.bind(localAddress, 4567);

    server.listen((client) {
      handleConnection(client);
    });
  }

  void handleConnection(Socket client) {
    print('Connection from'
        ' ${client.remoteAddress.address}:${client.remotePort}');

    // listen for events from the client
    client.listen(
      // handle data from the client
      (Uint8List data) async {
        await Future.delayed(Duration(seconds: 1));
        final message = String.fromCharCodes(data);
        if (message == 'Knock, knock.') {
          client.write('Who is there?');
        } else if (message.length < 10) {
          client.write('$message who?');
        } else {
          client.write('Very funny.');
          client.close();
        }
      },

      // handle errors
      onError: (error) {
        print(error);
        client.close();
      },

      // handle the client closing the connection
      onDone: () {
        print('Client left');
        client.close();
      },
    );
  }
}
