// import 'package:flutter/material.dart';

// import '../../../components/already_have_an_account_acheck.dart';
// import '../../../constants.dart';
// import '../../Login/login_screen.dart';

// class SignUpForm extends StatelessWidget {
  
//   const SignUpForm({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: defaultPadding),
//             child: TextFormField(
//               keyboardType: TextInputType.emailAddress,
//               textInputAction: TextInputAction.next,
//               cursorColor: kPrimaryColor,
//               onSaved: (email) {},
//               decoration: const InputDecoration(
//                 hintText: "Your Full Name",
//                 prefixIcon: Padding(
//                   padding: EdgeInsets.all(defaultPadding),
//                   child: Icon(Icons.person),
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: defaultPadding),
//             child: TextFormField(
//               keyboardType: TextInputType.emailAddress,
//               textInputAction: TextInputAction.next,
//               cursorColor: kPrimaryColor,
//               onSaved: (email) {},
//               decoration: const InputDecoration(
//                 hintText: "Your Email",
//                 prefixIcon: Padding(
//                   padding: EdgeInsets.all(defaultPadding),
//                   child: Icon(Icons.person),
//                 ),
//               ),
//             ),
//           ),
          
          
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: defaultPadding),
//             child: TextFormField(
//               textInputAction: TextInputAction.done,
//               obscureText: true,
//               cursorColor: kPrimaryColor,
//               decoration: const InputDecoration(
//                 hintText: "Your password",
//                 prefixIcon: Padding(
//                   padding: EdgeInsets.all(defaultPadding),
//                   child: Icon(Icons.lock),
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: defaultPadding),
//             child: TextFormField(
//               keyboardType: TextInputType.emailAddress,
//               textInputAction: TextInputAction.next,
//               cursorColor: kPrimaryColor,
//               onSaved: (email) {},
//               decoration: const InputDecoration(
//                 hintText: "Your Phone",
//                 prefixIcon: Padding(
//                   padding: EdgeInsets.all(defaultPadding),
//                   child: Icon(Icons.person),
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: defaultPadding),
//             child: DropdownButtonFormField<String>(
//               value: _selectedRole,
//               onChanged: (String? newValue) {
//                 setState(() {
//                   _selectedRole = newValue;
//                 });
//               },
//               items: <String>['Rider', 'Admin']
//                   .map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//               decoration: const InputDecoration(
//                 hintText: "Select Role",
//                 prefixIcon: Padding(
//                   padding: EdgeInsets.all(defaultPadding),
//                   child: Icon(Icons.person_outline),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: defaultPadding / 2),
//           ElevatedButton(
//             onPressed: () {},
//             child: Text("Sign Up".toUpperCase()),
//           ),
//           const SizedBox(height: defaultPadding),
//           AlreadyHaveAnAccountCheck(
//             login: false,
//             press: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) {
//                     return const LoginScreen();
//                   },
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Import fluttertoast
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? _selectedRole;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: _fullNameController,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Your Full Name",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your full name';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Your Email",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.email),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: _passwordController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Your Password",
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Your Phone",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.phone),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: DropdownButtonFormField<String>(
              value: _selectedRole,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedRole = newValue;
                });
              },
              items: <String>['rider', 'admin']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(
                hintText: "Select Role",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person_outline),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a role';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                // Call the register function
                _register();
              }
            },
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _register() async {
    try {
      await Future.delayed(Duration(milliseconds: 100)); // Ensure the engine is ready
      final response = await AuthService().register(
        _fullNameController.text.toString(),
        _emailController.text.toString(),
        _passwordController.text.toString(),
        _phoneController.text.toString(),
        _selectedRole!.toString(),
      );
      print("Response $response");
      // Handle successful registration
      
      // Navigate to login or home screen
    } catch (e) {
      // Handle registration failure
      print(e);
    }
  }
}

class AuthService {
  final String baseUrl = "http://127.0.0.1:8000";

  Future<Map<String, dynamic>> register(String fullname, String email, String password, String phone, String role) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'fullname': fullname,
        'email': email,
        'password': password,
        'phone': phone,
        'role': role,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register user');
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
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
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to log in');
    }
  }
}

