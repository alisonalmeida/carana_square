import 'package:carana_square/carana_square.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await Flame.device.setLandscape();

  runApp(
    const GameWidget<CaranaGame>.controlled(gameFactory: CaranaGame.new),
  );
}
