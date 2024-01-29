import 'package:flutter_starter_kit/connection/main_http_request.dart';

typedef OnSuccess<T> = void Function(T data);

Future<T?> getHttpRequest<T>(
  String url, {
  Map<String, String>? headers,
  OnSuccess<T>? onSuccess,
}) async {
  return await httpRequest<T>('GET', url,
      headers: headers, onSuccess: onSuccess);
}

Future<T?> postHttpRequest<T>(
  String url, {
  Map<String, String>? headers,
  dynamic body,
  OnSuccess<T>? onSuccess,
}) async {
  return await httpRequest<T>('POST', url,
      headers: headers, body: body, onSuccess: onSuccess);
}

Future<T?> putHttpRequest<T>(
  String url, {
  Map<String, String>? headers,
  dynamic body,
  OnSuccess<T>? onSuccess,
}) async {
  return await httpRequest<T>('PUT', url,
      headers: headers, body: body, onSuccess: onSuccess);
}

Future<T?> deleteHttpRequest<T>(
  String url, {
  Map<String, String>? headers,
  OnSuccess<T>? onSuccess,
}) async {
  return await httpRequest<T>('DELETE', url,
      headers: headers, onSuccess: onSuccess);
}

// Add more functions for other HTTP methods as needed...
