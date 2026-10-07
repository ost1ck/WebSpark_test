import './path_result.dart';

class CalculationResult {
  CalculationResult({required String id, required PathResult result})
    : _id = id,
      _result = result;

  final String _id;
  final PathResult _result;

  String get id => _id;
  PathResult get result => _result;

  Map<String, dynamic> toJson() {
    return {'id': id, 'result': result.toJson()};
  }
}
