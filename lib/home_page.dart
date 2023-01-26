import 'package:audioplayers/audioplayers.dart';
import 'package:carana_square/carana_square.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

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
    if (Platform.isWindows) {
      String audioasset = 'assets/audio/intro_background_audio.ogg';
      ByteData bytes = await rootBundle.load(audioasset);

      AudioPlayer player = AudioPlayer();

      Uint8List audiobytes =
          bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);

      await player.play(BytesSource(audiobytes));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameWidget<CaranaGame>.controlled(
                      loadingBuilder: (p0) =>
                          Center(child: CircularProgressIndicator()),
                      gameFactory: CaranaGame.new),
                )),
            child: Text('vai')),
      ),
    );
  }
}
