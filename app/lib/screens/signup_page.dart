import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final usernamecontroller = TextEditingController();
  final useremailcontorller = TextEditingController();
  final userpasswordcontrolller = TextEditingController();

  Future<void> AuthRequest(
    String username,
    String email,
    String password,
  ) async {
    const String url = "http://10.0.2.2:3000/Play-T/register-user";

    final response = await http.post(
      Uri.parse(url),
      headers: {"content-type": "application/json"},
      body: jsonEncode({
        "username": username,
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 201) {
      print("successfully registerd");
    } else {
      print("failed registration try again");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
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
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "email address",
                ),
                controller: useremailcontorller,
              ),
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
                  AuthRequest(
                    usernamecontroller.text,
                    useremailcontorller.text,
                    userpasswordcontrolller.text,
                  );
                },
                child: Text("Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
