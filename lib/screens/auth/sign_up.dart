// ignore_for_file: avoid_print, use_build_context_synchronously, prefer_final_fields

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iaso/screens/auth/log_in.dart';
import 'package:iaso/screens/pages/onboarding/enable_notifications.dart';
import 'package:iaso/services/firebase_auth.dart';
import 'package:iaso/widgets/animated_button_widget.dart';
import 'package:iaso/widgets/form_container_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  bool _isSigningUp = false;

  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              // logo
                Container( 
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration( 
                    image: DecorationImage(
                      image: AssetImage('assets/logo.png')
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                SizedBox(height: 5,),
                Text("IASO", style: TextStyle(
                  fontSize: 40,
                  letterSpacing: 4,
                  fontFamily: 'LilitaOne',
                ),),
                SizedBox(height: 25,),
              // username field
                FormContainerWidget(
                  controller: _usernameController,
                  hintText: "felhasználónév",
                  isPasswordField: false,
                ),
                SizedBox(height: 10,),
              // email field
                FormContainerWidget(
                  controller: _emailController,
                  hintText: "email",
                  isPasswordField: false,
                ),
                SizedBox(height: 10,),
              // password field
                FormContainerWidget(
                  controller: _passwordController,
                  hintText: "jelszó",
                  isPasswordField: true,
                ),
                SizedBox(height: 10,),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Checkbox(value: true, onChanged: (value) {},),
                    Expanded(
                      child: TextButton(
                        onPressed: () async {
                          launchUrl(
                            Uri.parse(''),
                            mode: LaunchMode.inAppBrowserView,
                          );
                        }, 
                        child: Text("Elolvastam és elfogadtam az adatvédelmi szabályzatot"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15,),
              // signup button
                AnimatedButton(
                  onTap: _signUp,
                  text: "Feliratkozás",
                  progressEvent: _isSigningUp,
                ),
                SizedBox(height: 15),
              // already have an account? login
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children : [
                    Text("Már van fiókod?"),
                    SizedBox(width: 5,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
                      },
                      child: Text("Bejelentkezés",style: TextStyle(color: Colors.blue.shade400, fontWeight: FontWeight.bold)),
                    ),
                  ]),
              ],
            ),
          ),
        ),
      ), 
    );
  }

  void _signUp() async {

    setState(() {
      _isSigningUp = true;
    });

    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    // add username to db
    FirebaseFirestore.instance.collection("users")
      .doc(email)
      .set({
        "email": email,
        "username": username
      });

    setState(() {
      _isSigningUp = false;
    });

    if (user != null) {
      CherryToast.success(
        title: Text("A felhasználó létrehozása sikeresen megtörtént",
          style: TextStyle(color: Colors.black),
        ),
      ).show(context);

      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => EnableNotifications()), (route) => false);
    } else {
      CherryToast.error(
        title: Text("Hiba történt.",
          style: TextStyle(color: Colors.black),
        ),
      ).show(context);
    }
  }

}