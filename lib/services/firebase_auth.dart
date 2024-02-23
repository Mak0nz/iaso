import 'package:firebase_auth/firebase_auth.dart';
import 'package:heamed/widgets/toast.dart';

class FirebaseAuthService{

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(message: 'Az e-mail cím már használatban van.');
      } else if (e.code == 'channel-error') {
        showToast(message: 'Minden mező szükséges.');
      } else if (e.code == 'weak-password') {
        showToast(message: 'Gyenge jelszó.');
      } else {
        showToast(message: 'Hiba lépett fel: ${e.code}');
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
        showToast(message: 'Rossz email cím vagy jelszó.');
      } else if (e.code == 'channel-error') {
        showToast(message: 'Minden mező szükséges.');
      } else {
        showToast(message: 'Hiba lépett fel: ${e.code}');
      }
    }
    return null;
  }

}