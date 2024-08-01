import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      title: 'Firebase Integration Test',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firebase Test')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Test Firestore
            try {
              await FirebaseFirestore.instance
                  .collection('test')
                  .add({'timestamp': DateTime.now()});
              print('Document added successfully');
            } catch (e) {
              print('Error adding document: $e');
            }
          },
          child: Text('Test Firestore'),
        ),
      ),
    );
  }
}
