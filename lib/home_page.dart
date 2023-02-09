// ignore_for_file: prefer_const_constructors

import 'package:audioplayers/audioplayers.dart';
import 'package:carana_square/actors.dart';
import 'package:carana_square/connection/client.dart';
import 'package:carana_square/connection/server.dart';
import 'package:carana_square/hbgame.dart';
import 'package:carana_square/consts.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    playAudio();

    super.initState();
  }

  Future playAudio() async {
    /**
     * String audioasset = 'assets/audio/intro_background_audio.ogg';
    ByteData bytes = await rootBundle.load(audioasset);

    AudioPlayer player = AudioPlayer();

    Uint8List audiobytes =
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);

    await player.play(BytesSource(audiobytes));
     */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HBGame'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () async {
                  var v = ServerConnection();
                  await v.init();
                  if (mounted) {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        Player player = Player(
                            position: Vector2.all(32),
                            playerPath: playerHeloizaPath);
                        return GameWidget(
                            loadingBuilder: (p0) => Center(
                                  child: CircularProgressIndicator(),
                                ),
                            game: HBGame(player: player));
                      },
                    ));
                  }
                },
                child: Text('Criar')),
            ElevatedButton(
                onPressed: () async {
                  var client = ClientConnection();
                  var serverIp = await client.searchServer();
                  await client.connect(serverIp);
                  if (mounted) {
                    print(playerBrendaPath);
                    Player player = Player(
                        position: Vector2.all(32),
                        playerPath: playerBrendaPath);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return GameWidget(
                            loadingBuilder: (p0) => Center(
                                  child: CircularProgressIndicator(),
                                ),
                            game: HBGame(player: player));
                      },
                    ));
                  }
                },
                child: Text('Entrar')),
          ],
        ),
      ),
    );
  }
}
