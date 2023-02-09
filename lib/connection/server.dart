// ignore_for_file: prefer_const_constructors

import 'dart:typed_data';
import 'dart:io';
import 'package:carana_square/core.dart';

class ServerConnection {
  ServerConnection();

  Future init() async {
    List<NetworkInterface> listNetworkInterface =
        await NetworkInterface.list(); //get list network connections

    NetworkInterface selectedInterface;
    if (Platform.isAndroid) {
      selectedInterface = listNetworkInterface
          .singleWhere((element) => element.name == 'wlan0');
    } else {
      selectedInterface = listNetworkInterface
          .singleWhere((element) => element.name == 'Ethernet');
    }

    var localAddress = selectedInterface.addresses.first.address;
    // bind the socket server to an address and port
    final server = await ServerSocket.bind(localAddress, portGameConnection);
    print('server in: $localAddress');

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
      (Uint8List data) async {},

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
