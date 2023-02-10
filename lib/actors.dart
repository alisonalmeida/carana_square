import 'package:carana_square/hbgame.dart';
import 'package:flame/components.dart';

class ServerPlayer extends SpriteAnimationComponent with HasGameRef<HBGame> {
  ServerPlayer({required super.position, required this.playerPath})
      : super(size: Vector2.all(64), anchor: Anchor.center);

  String? playerPath;

  bool isRunning = false;
  List<double> runningStepTimes = [0.05, 0.05, 0.05, 0.05];
  List<double> walkingStepTimes = [0.1, 0.1, 0.1, 0.1];

  double velocity = 200;

  @override
  Future<void> onLoad() async {
    stopedAnimation();
  }

  stopedAnimation() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(playerPath!),
      SpriteAnimationData.range(
        start: 4,
        end: 7,
        stepTimes: [0.05, 0.05, 0.05, 0.05],
        amountPerRow: 4,
        amount: 8, //max32
        textureSize: Vector2.all(32),
        texturePosition: Vector2.all(2),
      ),
    );
  }

  toLeftAnimation(bool isRunning) {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(playerPath!),
      SpriteAnimationData.range(
        start: 24,
        end: 27,
        stepTimes: isRunning ? runningStepTimes : walkingStepTimes,
        amountPerRow: 4,
        amount: 28, //max32
        textureSize: Vector2.all(32),
        texturePosition: Vector2.all(4),
      ),
    );
  }

  toRightAnimation(bool isRunning) {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(playerPath!),
      SpriteAnimationData.range(
        start: 28,
        end: 31,
        stepTimes: isRunning ? runningStepTimes : walkingStepTimes,
        amountPerRow: 4,
        amount: 32, //max32
        textureSize: Vector2.all(32),
        texturePosition: Vector2.all(4),
      ),
    );
  }

  toDownAnimation(bool isRunning) {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(playerPath!),
      SpriteAnimationData.range(
        start: 20,
        end: 23,
        stepTimes: isRunning ? runningStepTimes : walkingStepTimes,
        amountPerRow: 4,
        amount: 24, //max32
        textureSize: Vector2.all(32),
        texturePosition: Vector2.all(4),
      ),
    );
  }

  toUpAnimation(bool isRunning) {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(playerPath!),
      SpriteAnimationData.range(
        start: 16,
        end: 19,
        stepTimes: isRunning ? runningStepTimes : walkingStepTimes,
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
        (gameRef.movementJoystick.relativeDelta * velocity * dt)[0];
    final double playerVectorY =
        (gameRef.movementJoystick.relativeDelta * velocity * dt)[1];
    if (gameRef.movementJoystick.relativeDelta[0] > 0.6 ||
        gameRef.movementJoystick.relativeDelta[0] < -0.6 ||
        gameRef.movementJoystick.relativeDelta[1] > 0.6 ||
        gameRef.movementJoystick.relativeDelta[1] < -0.6) {
      isRunning = true;
    } else {
      isRunning = false;
    }

    switch (gameRef.movementJoystick.direction) {
      case JoystickDirection.idle:
        if (animation!.isLastFrame) {
          stopedAnimation();
        }
        break;
      case JoystickDirection.left:
        if (animation!.isLastFrame) {
          toLeftAnimation(isRunning);
        }

        if (x > 32) {
          x += playerVectorX;
        }

        break;
      case JoystickDirection.downLeft:
        if (animation!.isLastFrame) {
          toLeftAnimation(isRunning);
        }
        if (x > 32) {
          x += playerVectorX;
        }
        if (y < gameRef.homeMap.size.y - 32) {
          y += playerVectorY;
        }

        break;
      case JoystickDirection.upLeft:
        if (animation!.isLastFrame) {
          toLeftAnimation(isRunning);
        }
        if (x > 32) {
          x += playerVectorX;
        }
        if (y > 32) {
          y += playerVectorY;
        }
        break;
      case JoystickDirection.right:
        if (animation!.isLastFrame) {
          toRightAnimation(isRunning);
        }
        if (x < gameRef.homeMap.size.x) {
          x += playerVectorX;
        }
        break;
      case JoystickDirection.upRight:
        if (animation!.isLastFrame) {
          toRightAnimation(isRunning);
        }
        if (x < gameRef.homeMap.size.x) {
          x += playerVectorX;
        }
        if (y > 32) {
          y += playerVectorY;
        }
        break;
      case JoystickDirection.downRight:
        if (animation!.isLastFrame) {
          toRightAnimation(isRunning);
        }
        if (x < gameRef.homeMap.size.x) {
          x += playerVectorX;
        }
        if (y < gameRef.homeMap.size.y - 32) {
          y += playerVectorY;
        }
        break;

      case JoystickDirection.down:
        if (animation!.isLastFrame) {
          toDownAnimation(isRunning);
        }
        if (y < gameRef.homeMap.size.y - 32) {
          y += playerVectorY;
        }

        break;
      case JoystickDirection.up:
        if (animation!.isLastFrame) {
          toUpAnimation(isRunning);
        }

        if (y > 32) {
          y += playerVectorY;
        }
        break;
      default:
    }
  }
}
class ClientPlayer extends SpriteAnimationComponent with HasGameRef<HBGame> {
  ClientPlayer({required super.position, required this.playerPath})
      : super(size: Vector2.all(64), anchor: Anchor.center);

  String? playerPath;

  bool isRunning = false;
  List<double> runningStepTimes = [0.05, 0.05, 0.05, 0.05];
  List<double> walkingStepTimes = [0.1, 0.1, 0.1, 0.1];

  double velocity = 200;

  @override
  Future<void> onLoad() async {
    stopedAnimation();
  }

  stopedAnimation() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(playerPath!),
      SpriteAnimationData.range(
        start: 4,
        end: 7,
        stepTimes: [0.05, 0.05, 0.05, 0.05],
        amountPerRow: 4,
        amount: 8, //max32
        textureSize: Vector2.all(32),
        texturePosition: Vector2.all(2),
      ),
    );
  }

  toLeftAnimation(bool isRunning) {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(playerPath!),
      SpriteAnimationData.range(
        start: 24,
        end: 27,
        stepTimes: isRunning ? runningStepTimes : walkingStepTimes,
        amountPerRow: 4,
        amount: 28, //max32
        textureSize: Vector2.all(32),
        texturePosition: Vector2.all(4),
      ),
    );
  }

  toRightAnimation(bool isRunning) {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(playerPath!),
      SpriteAnimationData.range(
        start: 28,
        end: 31,
        stepTimes: isRunning ? runningStepTimes : walkingStepTimes,
        amountPerRow: 4,
        amount: 32, //max32
        textureSize: Vector2.all(32),
        texturePosition: Vector2.all(4),
      ),
    );
  }

  toDownAnimation(bool isRunning) {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(playerPath!),
      SpriteAnimationData.range(
        start: 20,
        end: 23,
        stepTimes: isRunning ? runningStepTimes : walkingStepTimes,
        amountPerRow: 4,
        amount: 24, //max32
        textureSize: Vector2.all(32),
        texturePosition: Vector2.all(4),
      ),
    );
  }

  toUpAnimation(bool isRunning) {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(playerPath!),
      SpriteAnimationData.range(
        start: 16,
        end: 19,
        stepTimes: isRunning ? runningStepTimes : walkingStepTimes,
        amountPerRow: 4,
        amount: 20, //max32
        textureSize: Vector2.all(32),
        texturePosition: Vector2.all(4),
      ),
    );
  }

  /**
   * @override
  void update(double dt) {
    super.update(dt);

    final double playerVectorX =
        (gameRef.movementJoystick.relativeDelta * velocity * dt)[0];
    final double playerVectorY =
        (gameRef.movementJoystick.relativeDelta * velocity * dt)[1];
    if (gameRef.movementJoystick.relativeDelta[0] > 0.6 ||
        gameRef.movementJoystick.relativeDelta[0] < -0.6 ||
        gameRef.movementJoystick.relativeDelta[1] > 0.6 ||
        gameRef.movementJoystick.relativeDelta[1] < -0.6) {
      isRunning = true;
    } else {
      isRunning = false;
    }

    switch (gameRef.movementJoystick.direction) {
      case JoystickDirection.idle:
        if (animation!.isLastFrame) {
          stopedAnimation();
        }
        break;
      case JoystickDirection.left:
        if (animation!.isLastFrame) {
          toLeftAnimation(isRunning);
        }

        if (x > 32) {
          x += playerVectorX;
        }

        break;
      case JoystickDirection.downLeft:
        if (animation!.isLastFrame) {
          toLeftAnimation(isRunning);
        }
        if (x > 32) {
          x += playerVectorX;
        }
        if (y < gameRef.homeMap.size.y - 32) {
          y += playerVectorY;
        }

        break;
      case JoystickDirection.upLeft:
        if (animation!.isLastFrame) {
          toLeftAnimation(isRunning);
        }
        if (x > 32) {
          x += playerVectorX;
        }
        if (y > 32) {
          y += playerVectorY;
        }
        break;
      case JoystickDirection.right:
        if (animation!.isLastFrame) {
          toRightAnimation(isRunning);
        }
        if (x < gameRef.homeMap.size.x) {
          x += playerVectorX;
        }
        break;
      case JoystickDirection.upRight:
        if (animation!.isLastFrame) {
          toRightAnimation(isRunning);
        }
        if (x < gameRef.homeMap.size.x) {
          x += playerVectorX;
        }
        if (y > 32) {
          y += playerVectorY;
        }
        break;
      case JoystickDirection.downRight:
        if (animation!.isLastFrame) {
          toRightAnimation(isRunning);
        }
        if (x < gameRef.homeMap.size.x) {
          x += playerVectorX;
        }
        if (y < gameRef.homeMap.size.y - 32) {
          y += playerVectorY;
        }
        break;

      case JoystickDirection.down:
        if (animation!.isLastFrame) {
          toDownAnimation(isRunning);
        }
        if (y < gameRef.homeMap.size.y - 32) {
          y += playerVectorY;
        }

        break;
      case JoystickDirection.up:
        if (animation!.isLastFrame) {
          toUpAnimation(isRunning);
        }

        if (y > 32) {
          y += playerVectorY;
        }
        break;
      default:
    }
  }
   */
}
