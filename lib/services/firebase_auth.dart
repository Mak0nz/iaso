// ignore_for_file: use_build_context_synchronously, prefer_final_fields, recursive_getters

import 'package:cherry_toast/cherry_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService{

  FirebaseAuth _auth = FirebaseAuth.instance;
  
  BuildContext get context => context;

  Future<User?> signUpWithEmailAndPassword(String email, String password,) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        CherryToast.error(
          title: Text("Az e-mail cím már használatban van.",
            style: TextStyle(color: Colors.black),
          ),
        ).show(context);
      } else if (e.code == 'channel-error') {
        CherryToast.error(
          title: Text("Minden mező szükséges.",
            style: TextStyle(color: Colors.black),
          ),
        ).show(context);
      } else if (e.code == 'weak-password') {
        CherryToast.error(
          title: Text("Gyenge jelszó.",
            style: TextStyle(color: Colors.black),
          ),
        ).show(context);
      } else {
        CherryToast.error(
          title: Text("Hiba lépett fel: ${e.code}",
            style: TextStyle(color: Colors.black),
          ),
        ).show(context);
      }
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        CherryToast.error(
          title: Text("Rossz email cím vagy jelszó.",
            style: TextStyle(color: Colors.black),
          ),
        ).show(context);
      } else if (e.code == 'channel-error') {
        CherryToast.error(
          title: Text("Minden mező szükséges.",
            style: TextStyle(color: Colors.black),
          ),
        ).show(context);
      } else {
        CherryToast.error(
          title: Text("Hiba lépett fel: ${e.code}",
            style: TextStyle(color: Colors.black),
          ),
        ).show(context);
      }
    }
    return null;
  }

}