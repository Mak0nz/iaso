import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:iaso/screens/auth/log_in.dart';
import 'package:iaso/screens/auth/sign_up.dart';
import 'package:iaso/screens/pages/home.dart';
import 'package:iaso/screens/wrapper.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
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
      routes: {
        '/home': (context) => Home(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
      }
    );
  }
}

