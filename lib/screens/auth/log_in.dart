// ignore_for_file: use_build_context_synchronously, avoid_print, no_leading_underscores_for_local_identifiers, prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iaso/screens/auth/sign_up.dart';
import 'package:iaso/services/firebase_auth.dart';
import 'package:iaso/widgets/form_container_widget.dart';
import 'package:iaso/widgets/toast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isSigning = false;

  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
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
                SizedBox(height: 45,),
              // Email form
                FormContainerWidget(
                  controller: _emailController,
                  hintText: "email",
                  isPasswordField: false,
                ),
                SizedBox(height: 10,),
              // Password form
                FormContainerWidget(
                  controller: _passwordController,
                  hintText: "jelszó",
                  isPasswordField: true,
                ),
                SizedBox(height: 15,),
              // Login button
                GestureDetector(
                  onTap: _signIn,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade400,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center( child: _isSigning ? CircularProgressIndicator(color: Colors.white,):
                      Text("Bejelentkezés", 
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
              // or continue with
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey.shade500,
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text('Vagy jelentkezzen be google-al',),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey.shade500,
                      )
                    ),
                  ],
                ),
                SizedBox(height: 15,),
              // login using google
                GestureDetector(
                  onTap: _signInWithGoogle,
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black12,
                    ),
                    child: Image.asset('assets/google.png', height: 40,),
                  ),
                ),
              // Don't have an account? Register
                SizedBox(height: 15),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children : [
                    Text("Nincs fiókod?"),
                    SizedBox(width: 5,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignUpPage()), (route) => false);
                      },
                      child: Text("Regisztrálj",style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                    ),
                  ]),
              ],
            ),
          ),
        ),
      ), 
    );
  }

  void _signIn() async {

    setState(() {
      _isSigning = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      showToast(message: "A felhasználó sikeresen bejelentkezve");
      Navigator.pushNamed(context, "/navigationMenu");
    } else {
      showToast(message: "Hiba történt.");
    }
  }

  _signInWithGoogle () async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      if(googleSignInAccount != null ){
        final GoogleSignInAuthentication googleSignInAuthentication = await
        googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await _firebaseAuth.signInWithCredential(credential);
        Navigator.pushNamed(context, "/navigationMenu");
      }

    } catch (e) {
      showToast(message: "some error occured $e");
    }
  }

}