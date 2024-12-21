import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _obscureText = true;

  Future<void> login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // calling the API
    final url = Uri.parse('https://reqres.in/api/login');
    final body = {
      "email": _emailController.text.trim(),
      "password": _passwordController.text.trim(),
    };

    try {
      final response = await http.post(url,
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});
      // checking response
      if (response.statusCode == 200) {
        final authBox = Hive.box('authBox');
        authBox.put('isLoggedIn', true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      } else {
        final error = jsonDecode(response.body)['error'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error ?? "LoginIn failed!"),
          ),
        );
      }
    } catch (e) {
      print("ERROR: ${e}");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred!')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Prevents bottom overflow
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Image.asset(
                  "assets/images/login.png",
                  height: 200, // Adjust height as needed
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
                // Login form fields
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        cursorColor: Colors.blue,
                        controller: _emailController,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          hintText: "Email",
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Icon(Icons.alternate_email_rounded),
                          ),
                        ),
                        validator: (value) =>
                            value!.isEmpty || !value.contains('@')
                                ? 'Invalid email'
                                : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        cursorColor: Colors.blue,
                        controller: _passwordController,
                        autocorrect: false,
                        decoration: InputDecoration(
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          hintText: "Password",
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Icon(Icons.lock_outline_rounded),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                        obscureText: _obscureText,
                        validator: (value) =>
                            value!.isEmpty ? 'Password is required' : null,
                      ),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _isLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: login,
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                    Colors.blue, // Button background
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 120, vertical: 12), // Padding
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("New User? "),
                          Text(
                            "Register",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
