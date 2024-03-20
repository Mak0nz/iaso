import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:iaso/screens/auth/log_in.dart';
import 'package:iaso/screens/auth/sign_up.dart';
import 'package:iaso/screens/components/navigation_menu.dart';
import 'package:iaso/screens/pages/home.dart';
import 'package:iaso/screens/wrapper.dart';
import 'package:iaso/themes.dart';
import 'package:workmanager/workmanager.dart';
import 'firebase_options.dart';
import 'services/background/calculate_med_quantity.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  await Workmanager().registerPeriodicTask(
    "calculate_med_quantity",
    "CalculateMedQuantity",
    //initialDelay: Duration(seconds: 5),
    frequency: Duration(hours: 6),
    inputData: <String, dynamic>{},
    constraints: Constraints(
      networkType: NetworkType.connected,
      //requiresDeviceIdle: true,
    ),
  );
  runApp(MyApp());
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  // This will be called when a background task is triggered
  Workmanager().executeTask((task, inputData) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    if (task == "CalculateMedQuantity") {
      try {
        await calculateMedQuantities();
        if (kDebugMode) {
          print("Calculate med quantities task ran successfuly");
        }
      } catch (error) {
        if (kDebugMode) {
          print("Error during background task: $error");
        } return Future.value(false);
      }
    } return Future.value(true); // Indicate successful task execution
    // Handle other tasks if any
  });
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

