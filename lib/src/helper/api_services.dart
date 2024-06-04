import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:okexpress/src/utils/api_urls.dart';

class ApiServices extends GetxController {
  static ApiServices instance = Get.find();
  Future<http.Response> getResponse({
    bool isAuthToken = false,
    Map<String, dynamic> requestBody = const {},
    required String endpoint,
  }) async {
    final url = Uri.parse(zApiDomain + endpoint);
    print(url);
    final Map<String, String> headers;
    String authToken = '';
    headers = {
      'Accept': '*/*',
      'Content-Type': 'text/plain',
    };

    try {
      print(jsonEncode(requestBody));
      print(headers);
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(requestBody),
      );
      debugPrint(response.body);
      return response;
    } catch (e) {
      final responseBody = {
        "error": {"message": e.toString(), "code": 404}
      };
      final response = http.Response(
        jsonEncode(responseBody),
        500,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      return response;
    }
  }
}
