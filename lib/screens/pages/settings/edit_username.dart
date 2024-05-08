// ignore_for_file: unused_field, prefer_final_fields, prefer_typing_uninitialized_variables

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iaso/services/firebase_auth.dart';
import 'package:iaso/widgets/animated_button_widget.dart';
import 'package:iaso/widgets/form_container_widget.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class EditUsernameModal extends StatefulWidget {
  const EditUsernameModal({super.key});

  @override
  State<EditUsernameModal> createState() => _EditUsernameModalState();
}

class _EditUsernameModalState extends State<EditUsernameModal> {
  bool _isSaving = false;

  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchExistingUsername();
  }

  Future fetchExistingUsername() async {
    final user = FirebaseAuth.instance.currentUser;
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user?.email);
        
    final docSnapshot = await docRef.get();
    if (docSnapshot.exists) {
      final data = docSnapshot.data();
      // Check for non-zero fields and update controllers
      if (data!['username'] != 0) {
        _usernameController.text = data['username'].toString();
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WoltModalSheet.show(context: context, pageListBuilder: (context) {
          return [ WoltModalSheetPage(
            isTopBarLayerAlwaysVisible: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 65),
              child: Column(
                children: [
                  Text("Felhasználónév módosítása:", style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 24,
                  ),),
                  
                  SizedBox(height: 25,),

                  FormContainerWidget(
                    controller: _usernameController,
                    hintText: "",
                    isPasswordField: false,
                  ),

                  SizedBox(height: 15,),

                  AnimatedButton(
                    onTap: () {
                      final username = Username(
                        username: _usernameController.text
                      );
                      saveUsername(username);
                    }, 
                    text: "Mentés", 
                    progressEvent: _isSaving,
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
      child: Icon(FontAwesomeIcons.penToSquare),
    );
  }

  Future saveUsername(Username username) async {
    setState(() {
      _isSaving = true;  
    });

    final user = FirebaseAuth.instance.currentUser;
    final docRef = FirebaseFirestore.instance.collection('users').doc(user?.email);
    final json = username.toJson();
    await docRef.update(json);
    
    setState(() {
      _isSaving = false;  
    });

    CherryToast.success(
      title: Text("Elmentve",
        style: TextStyle(color: Colors.black),
      ),
    // ignore: use_build_context_synchronously
    ).show(context);
    
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

}

class Username {
  var username;

  Username({
    this.username
  });

  Map<String, dynamic> toJson() => {
    'username': username,
  };
}