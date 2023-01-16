import 'package:carana_square/carana_square.dart';
import 'package:carana_square/consts.dart';
import 'package:flame/components.dart';

class Player1 extends SpriteAnimationComponent with HasGameRef<CaranaGame> {
  Player1({
    required super.position,
  }) : super(size: Vector2.all(64), anchor: Anchor.center);

  void move(Vector2 delta) {
    position.add(delta);
  }

  @override
  Future<void> onLoad() async {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(playerHeloizaPath),
      SpriteAnimationData.sequenced(
        amountPerRow: 4,
        amount: 32,
        stepTime: 0.2,
        textureSize: Vector2.all(32),
        texturePosition: Vector2.all(4),
      ),
    );
  }
}
