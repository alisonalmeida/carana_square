import 'package:carana_square/carana_square.dart';
import 'package:carana_square/consts.dart';
import 'package:flame/components.dart';

class Player extends SpriteAnimationComponent with HasGameRef<CaranaGame> {
  Player({required super.position})
      : super(size: Vector2.all(64), anchor: Anchor.center);
  List<double> stepTimes = [0.05, 0.05, 0.05, 0.05];
  double velocity = 200;

  @override
  Future<void> onLoad() async {
    stopedAnimation();
  }

  stopedAnimation() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(playerHeloizaPath),
      SpriteAnimationData.range(
        start: 4,
        end: 7,
        stepTimes: stepTimes,
        amountPerRow: 4,
        amount: 8, //max32
        textureSize: Vector2.all(32),
        texturePosition: Vector2.all(4),
      ),
    );
  }

  walkLeftAnimation() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(playerHeloizaPath),
      SpriteAnimationData.range(
        start: 24,
        end: 27,
        stepTimes: stepTimes,
        amountPerRow: 4,
        amount: 28, //max32
        textureSize: Vector2.all(32),
        texturePosition: Vector2.all(4),
      ),
    );
  }

  walkRightAnimation() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(playerHeloizaPath),
      SpriteAnimationData.range(
        start: 28,
        end: 31,
        stepTimes: stepTimes,
        amountPerRow: 4,
        amount: 32, //max32
        textureSize: Vector2.all(32),
        texturePosition: Vector2.all(4),
      ),
    );
  }

  walkDownAnimation() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(playerHeloizaPath),
      SpriteAnimationData.range(
        start: 20,
        end: 23,
        stepTimes: stepTimes,
        amountPerRow: 4,
        amount: 24, //max32
        textureSize: Vector2.all(32),
        texturePosition: Vector2.all(4),
      ),
    );
  }

  walkUpAnimation() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(playerHeloizaPath),
      SpriteAnimationData.range(
        start: 16,
        end: 19,
        stepTimes: stepTimes,
        amountPerRow: 4,
        amount: 20, //max32
        textureSize: Vector2.all(32),
        texturePosition: Vector2.all(4),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    final double playerVectorX =
        (gameRef.joystick.relativeDelta * velocity * dt)[0];
    final double playerVectorY =
        (gameRef.joystick.relativeDelta * velocity * dt)[1];

    switch (gameRef.joystick.direction) {
      case JoystickDirection.idle:
        if (animation!.isLastFrame) {
          stopedAnimation();
        }
        break;
      case JoystickDirection.left:
        if (animation!.isLastFrame) {
          walkLeftAnimation();
        }
        x += playerVectorX;
        break;
      case JoystickDirection.downLeft:
        if (animation!.isLastFrame) {
          walkLeftAnimation();
        }
        x += playerVectorX;
        y += playerVectorY;
        break;
      case JoystickDirection.upLeft:
        if (animation!.isLastFrame) {
          walkLeftAnimation();
        }
        x += playerVectorX;
        break;
      case JoystickDirection.right:
        if (animation!.isLastFrame) {
          walkRightAnimation();
        }
        x += playerVectorX;
        break;
      case JoystickDirection.upRight:
        if (animation!.isLastFrame) {
          walkRightAnimation();
        }
        x += playerVectorX;
        y += playerVectorY;
        break;
      case JoystickDirection.downRight:
        if (animation!.isLastFrame) {
          walkRightAnimation();
        }
        x += playerVectorX;
        y += playerVectorY;
        break;

      case JoystickDirection.down:
        if (animation!.isLastFrame) {
          walkDownAnimation();
        }
        y += playerVectorY;
        break;
      case JoystickDirection.up:
        if (animation!.isLastFrame) {
          walkUpAnimation();
        }
        y += playerVectorY;
        break;
      default:
    }
  }
}
