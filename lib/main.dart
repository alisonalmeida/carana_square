import 'package:carana_square/carana_square.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  final game = CaranaGame();
  runApp(GameWidget(game: game));
}
