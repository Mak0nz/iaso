import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:iaso/screens/auth/log_in.dart';
import 'package:iaso/screens/auth/sign_up.dart';
import 'package:iaso/screens/components/navigation_menu.dart';
import 'package:iaso/screens/pages/home.dart';
import 'package:iaso/screens/wrapper.dart';
import 'package:iaso/themes.dart';
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
      themeMode: ThemeMode.system,
      theme: ThemeClass.lightTheme,
      darkTheme: ThemeClass.darkTheme,
      routes: {
        '/navigationMenu': (context) => NavigationMenu(),
        '/home': (context) => Home(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
      }
    );
  }
}

