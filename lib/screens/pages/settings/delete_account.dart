// ignore_for_file: use_build_context_synchronously

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iaso/screens/auth/log_in.dart';
import 'package:iaso/widgets/outlined_button_widget.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  bool _isEvent = false;

  @override
  Widget build(BuildContext context) {
    return CustomOutlinedButton(
      onTap: () => showConfirmationDialog(), 
      text: "Fiók Törlése", 
      progressEvent: _isEvent, 
      outlineColor: Colors.red.shade400,
    );
  }

  void showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: const Icon(FontAwesomeIcons.triangleExclamation, size: 44,),
              ),
              const Expanded(child:Text("Biztosan törölni szeretné fiókját?"),),
            ],
          ),
          content: const Text.rich(
            TextSpan(
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              text: "Ez a művelet NEM visszavonható. ",
              children: [
                TextSpan(
                  style: TextStyle(fontWeight: FontWeight.normal),
                  text: "Ezzel véglegesen törli fiókját és annak adatait, beleértve a napi statisztikákat és a gyógyszertárat.",
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Mégsem"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                deleteAccount();
              },
              child: const Text("Törlés", style: TextStyle(color: Colors.red),),
            ),
          ],
        );
      },
    );
  }

  Future deleteAccount() async {

    setState(() {
      _isEvent = true;  
    });

    final docRef = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.email);

    try {
      await docRef.delete();

      CherryToast.success(
        title: Text("Sikeresen törölve",
          style: TextStyle(color: Colors.black),
        ),
      ).show(context);

      LoginPage();
      
    } catch (error) {
      CherryToast.error(
        title: Text(error.toString(),
          style: TextStyle(color: Colors.black),
        ),
      ).show(context);
    }

    setState(() {
      _isEvent = false;  
    });

  }

}