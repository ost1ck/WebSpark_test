import 'package:flutter/material.dart';
import 'package:webspark_test_task/features/calculation/models/calculation_result.dart';
import 'package:webspark_test_task/features/results/presentation/result_detail_screen.dart';
import 'package:webspark_test_task/features/url_input/models/path_task.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key, required this.results, required this.tasks});

  final List<CalculationResult> results;
  final List<PathTask> tasks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Results Screen')),
      body: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final result = results[index];
          final task = tasks[index];

          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: ListTile(
              title: Text(result.result.path, textAlign: TextAlign.center),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ResultDetailScreen(result: result, task: task),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
