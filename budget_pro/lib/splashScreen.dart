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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Budget Pro',
              style: TextStyle(
                fontSize: 46.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF055B5C),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Icon(
              Icons.calculate_rounded,
              size: 200,
              color: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }
}
