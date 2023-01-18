import 'package:carana_square/actors.dart';
import 'package:carana_square/consts.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class CaranaGame extends FlameGame with HasDraggables {
  CaranaGame();
  late Player _player;
  late JoystickComponent joystick;
  late SpriteComponent background;

  @override
  Future<void> onLoad() async {
    final knobPaint = BasicPalette.black.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.white.withAlpha(160).paint();

    await Flame.images.loadAll([tileMapPath, playerBrendaPath]);

    background = SpriteComponent()
      ..sprite = await loadSprite(tileMapPath)
      ..size = size;
    add(background);

    _player = Player(position: Vector2.all(32));

    add(_player);

    joystick = JoystickComponent(
      knob: CircleComponent(radius: 20, paint: knobPaint),
      background: CircleComponent(radius: 50, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );

    add(joystick);
  }
}
