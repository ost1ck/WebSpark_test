import '../../../models/grid_point.dart';

class PathTask {
  PathTask({
    required String id,
    required List<String> field,
    required GridPoint start,
    required GridPoint end,
  }) : _id = id,
       _field = List.unmodifiable(field),
       _start = start,
       _end = end;

  final String _id;
  final List<String> _field;
  final GridPoint _start;
  final GridPoint _end;

  String get id => _id;
  List<String> get field => _field;
  GridPoint get start => _start;
  GridPoint get end => _end;

  factory PathTask.fromJson(Map<String, dynamic> json) {
    return PathTask(
      id: json['id'] as String,
      field: (json['field'] as List).map((item) => item as String).toList(),
      start: GridPoint.fromJson(json['start'] as Map<String, dynamic>),
      end: GridPoint.fromJson(json['end'] as Map<String, dynamic>),
    );
  }

  @override
  String toString() {
    return '''
    id: $id \n
    field: \n $field \n
    start: \n $start \n
    end: \n $end
''';
  }
}
