import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> getSignedInUserId(String username, String password) async {
  // URL to your PHP script
  String url = "http://testflutter.felixeladi.co.ke/new_backend/Login/authenticator.php";

  // Make HTTP POST request with username and password
  http.Response response = await http.post(Uri.parse(url), body: {
    'emailAddress': username,
    'password': password,
  });

  // Parse the response
  Map<String, dynamic> data = json.decode(response.body);

  // Check if authentication was successful
  if (data['success']) {
    // Return the user ID
    return data['userId'];
  } else {
    // Authentication failed, handle it accordingly
    throw Exception(data['message']);
  }
}
