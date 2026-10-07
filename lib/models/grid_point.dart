class GridPoint {
  const GridPoint({required int x, required int y}) : _x = x, _y = y;

  final int _x;
  final int _y;

  int get x => _x;
  int get y => _y;

  factory GridPoint.fromJson(Map<String, dynamic> json) {
    return GridPoint(x: json['x'] as int, y: json['y'] as int);
  }

  Map<String, dynamic> toJson() {
    return {'x': x, 'y': y};
  }

  @override
  bool operator ==(Object other) {
    return other is GridPoint && other.x == x && other.y == y;
  }

  @override
  int get hashCode => Object.hash(x, y);

  @override
  String toString() {
    return '''
    x: $x,\ny: $y
''';
  }
}
