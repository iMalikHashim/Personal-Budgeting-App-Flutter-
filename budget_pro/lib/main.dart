import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'budget.dart';
import 'splashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyA-Rv4MpRic-sOhdLqEDzszbLIsbUOfVsI',
      appId: '1:430214389103:android:b2e02f0343c114d8ad5c9a',
      messagingSenderId: 'your-messaging-sender-id',
      projectId: 'budgetpro-25955',
      storageBucket: 'budgetpro-25955.appspot.com',
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Pro',
      home: SplashScreen(),
    );
  }
}
