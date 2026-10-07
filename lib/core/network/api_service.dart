import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webspark_test_task/core/exceptions/api_exception.dart';
import 'package:webspark_test_task/features/calculation/models/calculation_result.dart';
import 'package:webspark_test_task/features/url_input/models/task_response.dart';

class ApiService {
  static const _requestTimeout = Duration(seconds: 30);

  Future<TaskResponse> getTasks(String url) async {
    try {
      final uri = Uri.parse(url);
      final response = await http.get(uri).timeout(_requestTimeout);

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
    } on TimeoutException {
      throw const ApiException(message: 'Request timed out. Please try again.');
    } on FormatException {
      throw const ApiException(message: 'Invalid response from server');
    } on TypeError {
      throw const ApiException(message: 'Invalid response from server');
    }
  }

  Future<void> sendResults(String url, List<CalculationResult> results) async {
    try {
      final resultJson = results.map((result) => result.toJson()).toList();

      final body = jsonEncode(resultJson);

      final response = await http
          .post(
            Uri.parse(url),
            headers: {'Content-Type': 'application/json'},
            body: body,
          )
          .timeout(_requestTimeout);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;

        final hasError = json['error'] as bool;
        final message = json['message'] as String;

        if (hasError) {
          throw ApiException(message: message);
        }
        return;
      }

      throw ApiException(
        message: 'Failed to send results',
        statusCode: response.statusCode,
      );
    } on ApiException {
      rethrow;
    } on http.ClientException catch (e) {
      throw ApiException(message: 'Network error: ${e.message}');
    } on TimeoutException {
      throw const ApiException(message: 'Request timed out. Please try again.');
    } on FormatException {
      throw const ApiException(message: 'Invalid response from server');
    } on TypeError {
      throw const ApiException(message: 'Invalid response from server');
    }
  }
}
