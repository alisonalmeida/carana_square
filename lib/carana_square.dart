import 'package:carana_square/actors.dart';
import 'package:carana_square/consts.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class CaranaGame extends FlameGame with HasDraggables {
  CaranaGame();
  late Player1 _player;

  @override
  Future<void> onLoad() async {
    final knobPaint = BasicPalette.gray.withAlpha(50).paint();
    final backgroundPaint = BasicPalette.gray.withAlpha(80).paint();

    await Flame.images.loadAll([tileMapPath, playerHeloizaPath]);
    _player = Player1(position: Vector2.all(32));
    add(_player);

    final joystick = JoystickComponent(
      knob: CircleComponent(radius: 20, paint: knobPaint),
      background: CircleComponent(radius: 50, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );
    add(joystick);
  }
}
