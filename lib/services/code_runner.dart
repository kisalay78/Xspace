import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart'; // for kIsWeb
import 'dart:io'; // for Platform

Future<String> runPythonCode(String code, String input) async {

  print("SENDING REQUEST...");
  print("CODE: $code");
  print("INPUT: $input");

  String baseUrl;

  if (kIsWeb) {
    // 🌐 Web (Chrome)
    baseUrl = "http://localhost:5000";
  } else if (Platform.isAndroid) {
    // 🤖 Android Emulator
    baseUrl = "http://10.0.2.2:5000";
  } else {
    // 💻 Windows / Linux / Mac
    baseUrl = "http://127.0.0.1:5000";
  }

  final url = Uri.parse("$baseUrl/run");

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "code": code,
        "input": input
      }),
    );

    print("RESPONSE STATUS: ${response.statusCode}");
    print("RESPONSE BODY: ${response.body}");

    final data = jsonDecode(response.body);

    return data["output"] ?? "";

  } catch (e) {
    print("ERROR: $e");
    return "Server Error";
  }
}