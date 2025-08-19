import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:stream_nest/features/home/view/home_view.dart';

class LoginService {
  final Storage = FlutterSecureStorage();
  final apiUrl =
      'https://streamnest-880k.onrender.com/api/authentication/login';
  Future<void> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    // String email = _email.text;
    // String password = _password.text;

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode({'email': email, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );
      Navigator.pop(context);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        print('Login successful: ${response.body}');
        String accessToken = responseData["accessToken"];
        String refreshToken = responseData["refreshToken"];

        await Storage.write(key: "accessToken", value: accessToken);
        await Storage.write(key: "refreshToken", value: refreshToken);

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Login success')));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      } else if (response.statusCode == 401) {
        // Unauthorized
        print('Invalid username or password');

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Invalid username or password')));
      } else {
        print('An error occurred: ${response.statusCode}');

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Login Failed')));
      }
    } catch (e) {
      print('An error occurred: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login Failed')));
    }
  }
}
