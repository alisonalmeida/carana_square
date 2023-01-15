import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';

class CaranaGame extends FlameGame {
  String tileMapPath = 'tilemap.png';
  @override
  Future onLoad() async {
    await Flame.images.load(tileMapPath);
  }

  Sprite mapSprite(double x, double y, double width, double height) {
    return Sprite(Flame.images.fromCache(tileMapPath),
        srcPosition: Vector2(x, y), srcSize: Vector2(width, height));
  }
}
