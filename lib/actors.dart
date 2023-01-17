import 'package:carana_square/carana_square.dart';
import 'package:carana_square/consts.dart';
import 'package:flame/components.dart';

class Player extends SpriteAnimationComponent with HasGameRef<CaranaGame> {
  Player({
    required super.position,
  }) : super(size: Vector2.all(64), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(playerHeloizaPath),
      SpriteAnimationData.sequenced(
        amountPerRow: 4,
        amount: 4, //max32
        stepTime: 0.2,
        textureSize: Vector2.all(32),
        texturePosition: Vector2.all(4),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    final bool moveLeft = gameRef.joystick.direction == JoystickDirection.left;
    final bool moveRight =
        gameRef.joystick.direction == JoystickDirection.right;
    final bool moveUp = gameRef.joystick.direction == JoystickDirection.up;
    final bool moveDown = gameRef.joystick.direction == JoystickDirection.down;
    final bool moveDownLeft = gameRef.joystick.direction == JoystickDirection.downLeft;
    final bool moveUpLeft =
        gameRef.joystick.direction == JoystickDirection.upLeft;
        final bool moveDownRight =
        gameRef.joystick.direction == JoystickDirection.downRight;
    final bool moveUpRight =
        gameRef.joystick.direction == JoystickDirection.upRight;


    final double playerVectorX =
        (gameRef.joystick.relativeDelta * 300 * dt)[0];
    final double playerVectorY =
        (gameRef.joystick.relativeDelta * 300 * dt)[1];


    //  is moving left
    if (moveLeft && x > 0) {
      x += playerVectorX;
    }
//  is moving right
    if (moveRight && x < gameRef.size[0]) {
      x += playerVectorX;
    }

    // s moving up
    if (moveUp && y > 0) {
      y += playerVectorY;
    }

    //  moving down
    if (moveDown && y < gameRef.size[1] - height) {
      y += playerVectorY;
    }
    
  }
}
