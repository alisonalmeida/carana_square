import 'package:carana_square/actors.dart';
import 'package:carana_square/consts.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flame_tiled/flame_tiled.dart';

class CaranaGame extends FlameGame with HasDraggables, HasTappables {
  CaranaGame();
  late Player _player;
  late JoystickComponent joystick;
  late TiledComponent homeMap;
  AttackButton attackButton = AttackButton();
  final Vector2 buttonSize = Vector2.all(50);

  @override
  Future<void> onLoad() async {
    final knobPaint = BasicPalette.black.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.white.withAlpha(160).paint();

    await Flame.images.loadAll([playerBrendaPath, playerHeloizaPath]);

    homeMap = await TiledComponent.load(tileMapPath, Vector2.all(64));

    add(homeMap);

    _player = Player(position: Vector2.all(32));

    add(_player);
    camera.followComponent(_player);

    joystick = JoystickComponent(
      knob: CircleComponent(radius: 20, paint: knobPaint),
      background: CircleComponent(radius: 50, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );

    add(joystick);
    attackButton
      ..sprite = await loadSprite('attack_button_image.png')
      ..size = buttonSize
      ..position = Vector2(_player.x, _player.y);
    add(attackButton);
  }
}

class AttackButton extends SpriteComponent with Tappable {
  @override
  bool onTapDown(TapDownInfo event) {
    try {
      print('object');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
