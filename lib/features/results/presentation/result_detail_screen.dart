import 'package:flutter/material.dart';
import 'package:webspark_test_task/features/calculation/models/calculation_result.dart';
import 'package:webspark_test_task/features/results/enums/cell_type.dart';
import 'package:webspark_test_task/models/grid_point.dart';
import 'package:webspark_test_task/features/url_input/models/path_task.dart';

class ResultDetailScreen extends StatelessWidget {
  const ResultDetailScreen({
    super.key,
    required this.result,
    required this.task,
  });

  final CalculationResult result;
  final PathTask task;

  @override
  Widget build(BuildContext context) {
    final rowCount = task.field.length;
    final columnCount = task.field.first.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Preview Screen')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columnCount,
              ),
              itemCount: rowCount * columnCount,
              itemBuilder: (context, index) {
                final x = index % columnCount;
                final y = index ~/ columnCount;

                final point = GridPoint(x: x, y: y);

                return Container(
                  decoration: BoxDecoration(
                    color: _getCellType(point).color,
                    border: Border.all(color: Colors.black),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '($x,$y)',
                    style: TextStyle(
                      color: task.field[y][x] == 'X'
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                result.result.path,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  CellType _getCellType(GridPoint point) {
    switch (true) {
      case true when point == task.start:
        return CellType.start;

      case true when point == task.end:
        return CellType.end;

      case true when task.field[point.y][point.x] == 'X':
        return CellType.blocked;

      case true when result.result.steps.contains(point):
        return CellType.path;

      default:
        return CellType.empty;
    }
  }
}
