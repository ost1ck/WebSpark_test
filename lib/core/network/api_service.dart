import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webspark_test_task/core/exceptions/api_exception.dart';
import 'package:webspark_test_task/features/url_input/models/task_response.dart';

class ApiService {
  Future<TaskResponse> getTasks(String url) async {
    try {
      final uri = Uri.parse(url);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final taskResponse = TaskResponse.fromJson(jsonDecode(response.body));
        if (taskResponse.error) {
          throw ApiException(message: taskResponse.message);
        }

        if (taskResponse.data.isEmpty) {
          throw const ApiException(message: 'No tasks received from server');
        }

        return taskResponse;
      }

      throw ApiException(
        message: 'Failed to load tasks',
        statusCode: response.statusCode,
      );
    } on ApiException {
      rethrow;
    } on http.ClientException catch (e) {
      throw ApiException(message: 'Network error: ${e.message}');
    } on FormatException {
      throw const ApiException(message: 'Invalid response from server');
    }
  }
}
