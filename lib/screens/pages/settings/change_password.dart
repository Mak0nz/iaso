// ignore_for_file: prefer_final_fields, unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iaso/services/firebase_auth.dart';
import 'package:iaso/widgets/animated_button_widget.dart';
import 'package:iaso/widgets/form_container_widget.dart';
import 'package:iaso/widgets/toast.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class ChangePasswordModal extends StatefulWidget {
  const ChangePasswordModal({super.key});

  @override
  State<ChangePasswordModal> createState() => _ChangePasswordModalState();
}

class _ChangePasswordModalState extends State<ChangePasswordModal> {
  bool _isSaving = false;

  final FirebaseAuthService _auth = FirebaseAuthService();
  final currentUser = FirebaseAuth.instance.currentUser;
  final _email = FirebaseAuth.instance.currentUser?.email;

  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();

  changePassword() async {
    setState(() {
      _isSaving = true;  
    });

    final email = _email.toString();
    final oldPassword = _oldPasswordController.toString();
    final newPassword = _newPasswordController.toString();

    final credential = EmailAuthProvider.credential(email: email, password: oldPassword);

    await currentUser!.reauthenticateWithCredential(credential).then((value){
      currentUser!.updatePassword(newPassword);
      setState(() {
        _isSaving = false;  
      });
      showToast(message: "Jelszó sikeresen módosítva");
    }).catchError((error){
      setState(() {
        _isSaving = false;  
      });
      showToast(message: error.toString());
    });

    // ignore: use_build_context_synchronously
    Navigator.pop(context);

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
                  Text("Jelszó módosítása:", style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 24,
                  ),),
                  
                  SizedBox(height: 25,),

                  FormContainerWidget(
                    controller: _oldPasswordController,
                    hintText: "Régi jelszó",
                    isPasswordField: true,
                  ),
                  
                  SizedBox(height: 10,),
                  
                  FormContainerWidget(
                    controller: _newPasswordController,
                    hintText: "Új jelszó",
                    isPasswordField: true,
                  ),

                  SizedBox(height: 15,),

                  AnimatedButton(
                    onTap: () {
                      changePassword();
                    }, 
                    text: "Jelszó módosítása", 
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
      child: Icon(FontAwesomeIcons.chevronRight),
    );
  }
}