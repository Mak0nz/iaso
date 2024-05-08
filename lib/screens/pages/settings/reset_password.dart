// ignore_for_file: prefer_final_fields, unused_field, use_build_context_synchronously

import 'package:cherry_toast/cherry_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iaso/widgets/animated_button_widget.dart';
import 'package:iaso/widgets/form_container_widget.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class ResetPasswordModal extends StatefulWidget {
  const ResetPasswordModal({super.key});

  @override
  State<ResetPasswordModal> createState() => _ResetPasswordModalState();
}

class _ResetPasswordModalState extends State<ResetPasswordModal> {
  bool _isSaving = false;

  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
      CherryToast.success(
        title: Text("Jelszó-visszaállítási link elküldve! Ellenőrizze az e-mailjét.",
          style: TextStyle(color: Colors.black),
        ),
      ).show(context);

    } on FirebaseAuthException catch (error) {
      CherryToast.error(
        title: Text(error.message.toString(),
          style: TextStyle(color: Colors.black),
        ),
      ).show(context);
    } 
    
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WoltModalSheet.show(context: context, pageListBuilder: (context) {
          return [ WoltModalSheetPage(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 65),
              child: Column(
                children: [
                  Text("Elfelejtette a jelszavát?", style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 24,
                  ),),

                  SizedBox(height: 10,),

                  Text("Adja meg e-mail címét, és küldünk egy jelszó-visszaállítási linket.",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 25,),

                  FormContainerWidget(
                    controller: _emailController,
                    hintText: "email",
                    isPasswordField: false,
                  ),

                  SizedBox(height: 15,),

                  AnimatedButton(
                    onTap: () {
                      resetPassword();
                    }, 
                    text: "Jelszó visszaállítása", 
                    progressEvent: _isSaving
                  ),
                ],
              ),
            ),
            backgroundColor: Theme.of(context).brightness == Brightness.light
                ? Colors.white.withAlpha(200) // Light theme color
                : Colors.blueGrey[900]?.withAlpha(200),
          )];
        });
      },
      child: Text("Elfelejtette a jelszavát?",style: TextStyle(color: Colors.blue.shade400, fontWeight: FontWeight.bold)),
    );
  }
}