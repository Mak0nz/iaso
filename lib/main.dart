import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:heamed/screens/wrapper.dart';
import 'firebase_options.dart';

void main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Wrapper(),
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
    );
  }
}

