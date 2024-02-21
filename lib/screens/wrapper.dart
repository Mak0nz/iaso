import 'package:flutter/material.dart';
import 'package:heamed/screens/auth/sign_in.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // return either home or authenticate widget
    return LoginPage();
  }
}