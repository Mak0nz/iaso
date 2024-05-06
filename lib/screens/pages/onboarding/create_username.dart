// ignore_for_file: unused_field, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iaso/screens/pages/onboarding/enable_notifications.dart';
import 'package:iaso/services/firebase_auth.dart';
import 'package:iaso/widgets/animated_button_widget.dart';
import 'package:iaso/widgets/form_container_widget.dart';
import 'package:iaso/widgets/toast.dart';

class CreateUsername extends StatefulWidget {
  const CreateUsername({super.key});

  @override
  State<CreateUsername> createState() => _CreateUsernameState();
}

class _CreateUsernameState extends State<CreateUsername> {
  bool _isCreatingUsername = false;

  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;
    if (FirebaseAuth.instance.currentUser!.photoURL != null) {
      imageProvider = NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!); // No cast needed
    } else {
      imageProvider = AssetImage('assets/logo.png'); 
    }
    final email = FirebaseAuth.instance.currentUser?.email ?? "";

    return Scaffold(
      extendBody: true,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(35),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                    backgroundImage: imageProvider,
                    radius: 60,
                ),
                SizedBox(height: 15,),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Email:", style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 24,
                  ),),
                ),
                Text(email, style: TextStyle( 
                  fontSize: 20,
                ),),
                SizedBox(height: 25,),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Felhasználónév:", style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 24,
                  ),),
                ),
                FormContainerWidget(
                  controller: _usernameController,
                  hintText: "",
                  isPasswordField: false,
                ),
                SizedBox(height: 10,),
                AnimatedButton(
                  onTap: _saveUsername,
                  text: "Elmentés",
                  progressEvent: _isCreatingUsername,
                ),
                SizedBox(height: 40,),

              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.bottomRight,
        margin: const EdgeInsets.only(left: 20,right: 20,bottom: 12),
        child: GestureDetector(
          child: Text("Tovább", style: TextStyle(color: Colors.blue.shade400, fontWeight: FontWeight.bold, fontSize: 22),),
          onTap:() => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => EnableNotifications()), (route) => true),
        ),
        
      ),
    );
  }

  void _saveUsername() async {
    setState(() {
      _isCreatingUsername = true;
    });

    String username = _usernameController.text;
    String? email = FirebaseAuth.instance.currentUser!.email;

    // add username to db
    FirebaseFirestore.instance.collection("users")
      .doc(email)
      .set({
        "username": username
      });

    setState(() {
      _isCreatingUsername = false;
    });
    showToast(message: "A felhasználónév sikeresen elmentve");
  }

}