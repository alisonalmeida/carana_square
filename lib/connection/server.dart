import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class ServerConnection {
  ServerConnection();

  Future init() async {
    var channel = IOWebSocketChannel.connect('ws://192.168.2.142:8080');

     channel.stream.listen((message) {
      channel.sink.add('received!');
      channel.sink.close(status.goingAway);
    });
     
  }
}
