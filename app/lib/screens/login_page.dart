import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernamecontroller = TextEditingController();
  final userpasswordcontrolller = TextEditingController();

  Future<void> loginAuth(String username, String password) async {
    const String url = "http://10.0.2.2:3000/Play-T/login-user";

    final response = await http.post(
      Uri.parse(url),
      headers: {"content-type": "application/json"},
      body: jsonEncode({"username": username, "password": password}),
    );

    if (response.statusCode == 201) {
      AlertDialog(title: Text("succesfully login..."));
    } else {
      AlertDialog(title: Text("login failed..."));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.all(15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Username",
                ),
                controller: usernamecontroller,
              ),
              SizedBox(height: 40),
              SizedBox(height: 40),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Please enter your password",
                ),
                controller: userpasswordcontrolller,
              ),

              SizedBox(height: 60),
              ElevatedButton(
                onPressed: () {
                  loginAuth(
                    usernamecontroller.text,
                    userpasswordcontrolller.text,
                  );
                },
                child: Text("Log In"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
