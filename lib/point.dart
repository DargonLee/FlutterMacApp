import 'dart:math';

class Point {
  final num x;
  final num y;
  final num distance;

  Point(this.x, this.y) : distance = sqrt(x * x + y * y);
}

main(List<String> args) {}
