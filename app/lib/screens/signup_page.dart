import 'dart:convert';

import 'package:app/components/auth_alert_dialog.dart';
import 'package:app/screens/home_page.dart';
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

  Future<void> CreateUserRequest(
    String username,
    String email,
    String password,
  ) async {
    const String url = "http://10.0.2.2:3000/Play-T/auth/create-user";

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
      final responsedata = jsonDecode(response.body);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(username: responsedata['username']),
        ),
      );
      print("successfully registerd");
    } else if (response.statusCode == 409) {
      print("user already exists with this email");
      showAlertDialog(
        context,
        "User Already Exists with this username or email",
      );
    } else if (response.statusCode == 400) {
      print("invalid details ");
    } else if (response.statusCode == 500) {
      print("server is down");

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
                  CreateUserRequest(
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
