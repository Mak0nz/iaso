// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:heamed/screens/auth/log_in.dart';
import 'package:heamed/services/firebase_auth.dart';
import 'package:heamed/widgets/form_container_widget.dart';
import 'package:heamed/widgets/toast.dart';

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
                Text("HEAMED", style: TextStyle(
                  fontSize: 40,
                  letterSpacing: 5,
                  fontWeight: FontWeight.w900,
                ),),
                SizedBox(height: 45,),
                FormContainerWidget(
                  controller: _usernameController,
                  hintText: "Felhasználónév",
                  isPasswordField: false,
                ),
                SizedBox(height: 10,),
                FormContainerWidget(
                  controller: _emailController,
                  hintText: "email",
                  isPasswordField: false,
                ),
                SizedBox(height: 10,),
                FormContainerWidget(
                  controller: _passwordController,
                  hintText: "jelszó",
                  isPasswordField: true,
                ),
                SizedBox(height: 30,),
                GestureDetector(
                  onTap: _signUp,
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center( child: _isSigningUp ? CircularProgressIndicator(color: Colors.white,):
                      Text("Feliratkozás", 
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children : [
                    Text("Már van fiókod?"),
                    SizedBox(width: 5,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
                      },
                      child: Text("Bejelentkezés",style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
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

    // ignore: unused_local_variable
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
      showToast(message: "A felhasználó létrehozása sikeresen megtörtént");
      Navigator.pushNamed(context, "/home");
    } else {
      showToast(message: "Hiba történt.");
    }
  }

}