import 'package:flutter/material.dart';
import 'package:webspark_test_task/features/calculation/models/calculation_result.dart';
import 'package:webspark_test_task/features/calculation/services/path_calculator.dart';
import 'package:webspark_test_task/features/url_input/models/path_task.dart';
import 'package:webspark_test_task/core/exceptions/calculation_exception.dart';

class CalculationScreen extends StatefulWidget {
  const CalculationScreen({
    super.key,
    required this.tasks,
    required this.apiUrl,
  });

  final List<PathTask> tasks;
  final String apiUrl;

  @override
  State<CalculationScreen> createState() => _CalculationScreenState();
}

class _CalculationScreenState extends State<CalculationScreen> {
  double _progress = 0;
  int _completedTasks = 0;

  final List<CalculationResult> _results = [];

  bool _isCalculated = false;

  final _pathCalculator = PathCalculator();

  String? _calculationError;

  @override
  void initState() {
    super.initState();
    _calculatePaths();
  }

  Future<void> _calculatePaths() async {
    if (widget.tasks.isEmpty) {
      return;
    }

    try {
      for (final task in widget.tasks) {
        final result = _pathCalculator.calculate(task);

        _results.add(result);
        _completedTasks++;

        if (!mounted) return;

        setState(() {
          _progress = _completedTasks / widget.tasks.length;
        });

        await Future<void>.delayed(Duration.zero);
      }

      if (!mounted) return;

      setState(() {
        _isCalculated = true;
      });
    } on CalculationException catch (e) {
      if (!mounted) return;

      setState(() {
        _calculationError = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Process Screen')),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_calculationError != null)
                Text(
                  _calculationError!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                )
              else ...[
                if (_isCalculated) ...[
                  const Text(
                    'All calculations have finished',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 24),
                ],

                SizedBox(
                  width: 100,
                  height: 100,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: _isCalculated
                            ? const CircularProgressIndicator(
                                value: 1,
                                strokeWidth: 8,
                                color: Colors.blue,
                              )
                            : const CircularProgressIndicator(
                                strokeWidth: 8,
                                color: Colors.blue,
                              ),
                      ),
                      Text(
                        _isCalculated
                            ? '100%'
                            : '${(_progress * 100).toInt()}%',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
