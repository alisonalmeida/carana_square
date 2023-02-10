// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:carana_square/core.dart';

class ClientConnection {
  ClientConnection();

  Future connect() async {
    String serverIp = '';
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
    for (var i = 0; i < 255; i++) {
      var parts = localAddress.split('.');
      var ip = parts.take(parts.length - 1).join('.');
      try {
        await Socket.connect('$ip.$i', portGameConnection,
            timeout: Duration(milliseconds: 100));
        serverIp = '$ip.$i';

        break;
      } catch (e) {
        print(e);
      }
      /**
       * if (serverIp != '') {
        var socket = await Socket.connect(serverIp, portGameConnection);
        socket.listen((event) {
          print(event);
        });
      }
       */
    }
  }

  Future asd(String serverIp) async {
    /**
         * socket.listen(
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
         */
  }
}

Future<void> sendMessage(Socket socket, String message) async {
  socket.write(message);
}
