import 'package:webspark_test_task/models/grid_point.dart';

class PathResult {
  PathResult({required List<GridPoint> steps, required String path})
    : _steps = List.unmodifiable(steps),
      _path = path;

  final List<GridPoint> _steps;
  final String _path;

  List<GridPoint> get steps => _steps;
  String get path => _path;

  Map<String, dynamic> toJson() {
    return {
      'steps': steps.map((point) => point.toJson()).toList(),
      'path': path,
    };
  }
}
