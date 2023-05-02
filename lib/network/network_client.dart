import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

typedef Json = Map<String, dynamic>;

abstract class NetworkRequest {
  String get url;
  String get method;

  final Map<String, String>? headers;
  final Map<String, dynamic>? body;

  NetworkRequest({this.headers, this.body});
}

class NetworkClient {
  final http.Client httpClient;

  const NetworkClient({required this.httpClient});

  Future<Json> send(NetworkRequest request) async {
    print("Calling ${request.url}");
    final response = await httpClient.get(Uri.parse(request.url));
    if (response.statusCode != 200) {
      throw Exception("Unexpected server response");
    }
    return jsonDecode(response.body);
    /*var result = await rootBundle.loadString('assets/sample.json');
    return jsonDecode(result);*/
  }
}
