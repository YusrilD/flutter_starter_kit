import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

typedef OnSuccess<T> = void Function(T data);

Future<T?> httpRequest<T>(
  String method,
  String url, {
  Map<String, String>? headers,
  dynamic body,
  OnSuccess<T>? onSuccess,
}) async {
  try {
    final response =
        await http.Client().send(http.Request(method, Uri.parse(url))
          ..headers.addAll(headers ?? {})
          ..body = (body is Map || body is List) ? jsonEncode(body) : body);

    final responseBody = await utf8.decoder.bind(response.stream).join();
    final statusCode = response.statusCode;

    if (statusCode == HttpStatus.ok) {
      if (onSuccess != null) {
        onSuccess(jsonDecode(responseBody) as T);
      }
      return jsonDecode(responseBody) as T;
    } else {
      throw http.ClientException(
        'Failed to ${method.toUpperCase()} $url\nStatus code: $statusCode\nResponse: $responseBody',
        Uri.parse(url),
      );
    }
  } on http.ClientException catch (e) {
    // Handle specific HTTP exceptions
    print('HTTP Client Exception: $e');
    // Handle specific logic for HTTP exceptions (e.g., show a snackbar)
    // ...

    // You can also rethrow the exception if necessary
    // rethrow;
  } catch (e) {
    // Handle generic exceptions
    print('Exception: $e');
    // Handle specific logic for generic exceptions (e.g., show a snackbar)
    // ...

    // You can also rethrow the exception if necessary
    // rethrow;
  }

  // You may add a custom response for specific cases or return null as a default
  return null;
}
