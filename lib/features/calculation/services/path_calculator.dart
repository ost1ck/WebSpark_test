import 'dart:collection';

import 'package:webspark_test_task/core/exceptions/calculation_exception.dart';
import 'package:webspark_test_task/models/grid_point.dart';
import 'package:webspark_test_task/features/url_input/models/path_task.dart';
import 'package:webspark_test_task/features/calculation/models/calculation_result.dart';
import 'package:webspark_test_task/features/calculation/models/path_result.dart';

class PathCalculator {
  List<GridPoint> findShortestPath(PathTask task) {
    final queue = Queue<GridPoint>();
    final visited = <GridPoint>{};
    final Map<GridPoint, GridPoint> cameFrom = {};

    final directions = <GridPoint>[
      GridPoint(x: -1, y: -1),
      GridPoint(x: 0, y: -1),
      GridPoint(x: 1, y: -1),
      GridPoint(x: -1, y: 0),
      GridPoint(x: 1, y: 0),
      GridPoint(x: -1, y: 1),
      GridPoint(x: 0, y: 1),
      GridPoint(x: 1, y: 1),
    ];

    queue.add(task.start);
    visited.add(task.start);

    while (queue.isNotEmpty) {
      final current = queue.removeFirst();

      if (current == task.end) {
        final path = <GridPoint>[];

        var point = current;
        path.add(point);

        while (point != task.start) {
          point = cameFrom[point]!;
          path.add(point);
        }

        return path.reversed.toList();
      }

      for (final direction in directions) {
        final newX = current.x + direction.x;
        final newY = current.y + direction.y;

        if (newY < 0 || newY >= task.field.length) {
          continue;
        }

        if (newX < 0 || newX >= task.field[newY].length) {
          continue;
        }

        if (task.field[newY][newX] == 'X') {
          continue;
        }

        final neighbor = GridPoint(x: newX, y: newY);

        if (visited.contains(neighbor)) {
          continue;
        }

        cameFrom[neighbor] = current;
        visited.add(neighbor);
        queue.add(neighbor);
      }
    }

    return [];
  }

  CalculationResult calculate(PathTask task) {
    final steps = findShortestPath(task);
    if (steps.isEmpty) {
      throw CalculationException('Path not found for task ${task.id}');
    }

    final pathString = steps
        .map((point) => '(${point.x},${point.y})')
        .join('->');

    final pathResult = PathResult(steps: steps, path: pathString);

    return CalculationResult(id: task.id, result: pathResult);
  }
}
