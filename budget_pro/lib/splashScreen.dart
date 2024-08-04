import 'package:flutter/material.dart';
import 'budget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Budget()),
      );
    });

    return const Scaffold(
      // backgroundColor: Color(0xFF055B5C),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Text(
          'Budget Pro',
          style: TextStyle(
            fontSize: 46.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF055B5C),
          ),
        ),
      ),
    );
  }
}
