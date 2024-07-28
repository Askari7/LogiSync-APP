import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/main/main_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: _passwordController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                _login();
              }
            },
            child: Text(
              "Login".toUpperCase(),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _login() async {
    try {
      await Future.delayed(Duration(milliseconds: 100)); // Ensure the engine is ready
      final response = await AuthService().login(
        _emailController.text.toString(),
        _passwordController.text.toString(),
      );
      if (response != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', response['access_token']);
        await prefs.setString('refreshToken', response['refresh_token']);
        await prefs.setString('rider_id', response['_id']);

        print('Tokens saved');
        
        // Navigate to MainScreen upon successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainScreen(),
          ),
        );
      }
    } catch (e) {
      // Handle login failure
      print(e);
    }
  }
}

class AuthService {
  final String baseUrl = "http://127.0.0.1:8000";

  Future<Map<String, dynamic>?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print('Login successful: $responseData');
      return {
        'access_token': responseData['data'][0]['access_token'],
        'refresh_token': responseData['data'][0]['refresh_token'],
        '_id': responseData['data'][0]['user']['_id']

      }; // Return response data to be handled in _login
    } else {
      throw Exception('Failed to log in');
    }
  }
}
