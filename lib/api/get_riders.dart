// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class AuthService {
//   final String baseUrl = "http://127.0.0.1:8000";

  // Future<void> riders() async {
  //   final response = await http.get(
  //     Uri.parse('$baseUrl/riders'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     final responseData = jsonDecode(response.body);
  //     print('Login successful: $responseData');
  //     // Handle the response data as needed
  //   } else {
  //     throw Exception('Failed to log in');
  //   }
  // }

  // 

// //   Future<void> get_current_user(String token) async {
// //     final response = await http.get(
// //       Uri.parse('$baseUrl/get_current_user'),
// //       headers: <String, String>{
// //         'Content-Type': 'application/json; charset=UTF-8',
// //         'Authorization': "Bearer ${token}",
// //       },
// //     );

// //     if (response.statusCode == 200) {
// //       final responseData = jsonDecode(response.body);
// //       print('Login successful: $responseData');
// //       // Handle the response data as needed
// //     } else {
// //       throw Exception('Failed to log in');
// //     }
// //   }
// }

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = "http://127.0.0.1:8000";

  Future<void> riders() async {
    final token = await getAccessToken();
    if (token == null) {
      throw Exception('No access token found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/riders'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print('API call successful: $responseData');
      // Handle the response data as needed
    } else {
      throw Exception('Failed to call API');
    }
  }

  Future<void> rider_all_journeys(String rider_id) async {
    final token = await getAccessToken();

    final response = await http.get(

      Uri.parse('$baseUrl/rider/${rider_id}/journeys'),
      
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print('API call successful for rider journey: $responseData');
      // Handle the response data as needed
    } else {
      throw Exception('Failed to log in');
    }
  }


  Future<void> start_journey() async {
    final token = await getAccessToken();
    final response = await http.post(
      Uri.parse('$baseUrl/start_journey'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',

      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print('API call for starting rider journey: $responseData');
      // Handle the response data as needed
    } else {
      throw Exception('Failed to log in');
    }
  }

  Future<void> gps_ping(String journey_id, String latitude, String longitude) async {
    final token = await getAccessToken();
    final response = await http.post(
      Uri.parse('$baseUrl/gps_pings'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print('API call for rider journey gps point: $responseData');
      // Handle the response data as needed
    } else {
      throw Exception('Failed to log in');
    }
  }

  Future<void> end_journey(String journey_id) async {
    final token = await getAccessToken();
    final response = await http.post(
      Uri.parse('$baseUrl/end_journey'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print('API call for ending rider journey: $responseData');
      // Handle the response data as needed
    } else {
      throw Exception('Failed to log in');
    }
  }

  Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }
}
