import 'package:http/http.dart' as http;
import 'dart:convert';

class BlogHttp {
  /// Http Get
  static void get(String url, Function(int code, String body) reponse,
      {Map<String, String>? headers}) async {
    var uri = Uri.parse(url);
    if (headers == null) headers = {};
    headers['Content-Type'] = 'application/json';
    var response = await http.get(uri, headers: headers);
    var statusCode = response.statusCode;
    var responseHeaders = response.headers;
    var responseBody = utf8.decode(response.bodyBytes);
    reponse(statusCode, responseBody);
  }

  /// Http Post
  static void post(String url, Function(int code, String body) reponse,
      {Map<String, String>? headers, Object? body}) async {
    var uri = Uri.parse(url);
    if (headers == null) headers = {};
    headers['Content-Type'] = 'application/json';
    var response = await http.post(uri, body: body, headers: headers);
    var statusCode = response.statusCode;
    var responseHeaders = response.headers;
    var responseBody = utf8.decode(response.bodyBytes);
    reponse(statusCode, responseBody);
  }

  /// Http Put
  static void put(String url, Function(int code, String body) reponse,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    var uri = Uri.parse(url);
    if (headers == null) headers = {};
    headers['Content-Type'] = 'application/json';
    var response = await http.put(uri, body: body, headers: headers);
    var statusCode = response.statusCode;
    var responseHeaders = response.headers;
    var responseBody = utf8.decode(response.bodyBytes);
    reponse(statusCode, responseBody);
  }

  /// Http Delete
  static void delete(String url, Function(int code, String body) reponse,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    var uri = Uri.parse(url);
    if (headers == null) headers = {};
    headers['Content-Type'] = 'application/json';
    var response = await http.delete(uri, body: body, headers: headers);
    var statusCode = response.statusCode;
    var responseHeaders = response.headers;
    var responseBody = utf8.decode(response.bodyBytes);
    reponse(statusCode, responseBody);
  }
}
