import 'package:app/main.dart';
import 'package:app/screens/home_page.dart';
import 'package:app/screens/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    AuthCheck();
  }

  Future<void> AuthCheck() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('accesstoken');

    if (token != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      await prefs.remove('accesstoken');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignUpPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
