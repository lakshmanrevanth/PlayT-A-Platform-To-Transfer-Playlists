import 'dart:convert';
import 'package:app/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> loginAuth(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      showMessage("Please enter both username and password.");
      return;
    }

    setState(() => isLoading = true);

    const String url = "http://10.0.2.2:3000/Play-T/auth/login-user";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"username": username, "password": password}),
      );

      setState(() => isLoading = false);

      if (response.statusCode == 200) {
        // final accesstoken = jsonDecode(response.body)['token'];
        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setString('accesstoken', accesstoken);
        // print("login token is : $accesstoken");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        showMessage("Successfully logged in!");
      }
      // else if (response.statusCode == 400) {
      //   print("missing fields");
      // }
      else if (response.statusCode == 404) {
        print("user not found with that username");
      } else if (response.statusCode == 401) {
        print("wrong password");
      } else if (response.statusCode == 500) {
        print("server is down");
      }
    } catch (e) {
      setState(() => isLoading = false);
      showMessage("Error: Unable to connect to the server.");
    }
  }

  void showMessage(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Login Status"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Welcome Back!",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Username",
                    prefixIcon: Icon(Icons.person),
                  ),
                  controller: usernameController,
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock),
                  ),
                  controller: passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          loginAuth(
                            usernameController.text.trim(),
                            passwordController.text.trim(),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 16,
                          ),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        child: const Text("Log In"),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
