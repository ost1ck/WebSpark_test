import './path_task.dart';

class TaskResponse {
  TaskResponse({
    required bool error,
    required String message,
    required List<PathTask> data,
  }) : _error = error,
       _message = message,
       _data = List.unmodifiable(data);

  final bool _error;
  final String _message;
  final List<PathTask> _data;

  bool get error => _error;
  String get message => _message;
  List<PathTask> get data => _data;

  factory TaskResponse.fromJson(Map<String, dynamic> json) {
    return TaskResponse(
      error: json['error'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List)
          .map((item) => PathTask.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  String toString() {
    return '''
    error: \n\n $error \n\n\n message: \n\n $message \n\n\n data:\n\n$data
''';
  }
}
