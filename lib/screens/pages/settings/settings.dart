// ignore_for_file: unused_local_variable

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iaso/screens/pages/settings/change_language.dart';
import 'package:iaso/screens/pages/settings/change_password.dart';
import 'package:iaso/screens/pages/settings/edit_username.dart';
import 'package:iaso/screens/pages/settings/tos.dart';
import 'package:iaso/widgets/appbar_widget.dart';
import 'package:iaso/widgets/outlined_button_widget.dart';
import 'package:iaso/widgets/settings/setting_option_widget.dart';
import 'package:iaso/widgets/toast.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var username = "Felhasználó";
  var notifStateText = "Engedélyezés";
  var notifTextColor = Colors.blue.shade400;
  final bool _isEvent = false;

  getUsername() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final email = user.email;

      // Get the document where email matches current user's email
      final docRef = await FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: email)
          .get()
          .then((snapshot) => snapshot.docs.first);

      if (docRef.exists) {
        // Extract the username from the document
        username = docRef.get("username");
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUsername();
    _isNotificationsEnabled();
  }

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
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(title: "Beállítások"),

      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 90, 15, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Icon(FontAwesomeIcons.userGear, color: Colors.blue.shade400,),
                ),
                Text("Fiók", style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 24,
                ),),
              ],),
              Divider(),
              SizedBox(height: 5,),

              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey.shade900, width: 2.0),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                                backgroundImage: imageProvider,
                                radius: 40,
                            ),
                            Text(username, style: TextStyle( 
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),),
                            EditUsernameModal(),
                          ],
                        ),
                        Text(email, style: TextStyle( 
                          fontSize: 20,
                          color: Theme.of(context).brightness == Brightness.light
                            ? Colors.grey.shade900 // Light theme color
                            : Colors.grey,
                        ),),
                      ],
                    ),
                  ),
                ),
              ),
              
              SettingOption(
                title: "Jelszó módosítása",
                trailing: ChangePasswordModal(),
              ),

              SizedBox(height: 15,),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Icon(FontAwesomeIcons.gears, color: Colors.blue.shade400,),
                ),
                Text("Egyéb beállitások", style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 24,
                ),),
              ],),
              Divider(),
              SizedBox(height: 5,),
              
              SettingOption(
                title: "Nyelv",
                trailing: ChangeLanguageModal(),
              ),

              SettingOption(
                title: "Adatvédelem és biztonság",
                trailing: TOS(),
              ),

              SettingOption(
                title: "Értesítések",
                trailing: GestureDetector(
                  onTap:() => {
                    AwesomeNotifications().requestPermissionToSendNotifications(),
                    _isNotificationsEnabled(),
                  },
                  child: Text(notifStateText, style: TextStyle(
                    color: notifTextColor, 
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),),
                ),
              ),

              SizedBox(height: 35,),

              CustomOutlinedButton(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamed(context, "/login");
                  showToast(message: "Sikeresen kijelentkezve");
                }, 
                text: "Kijelentkezés", 
                progressEvent: _isEvent, 
                outlineColor: Theme.of(context).brightness == Brightness.light
                ? Colors.grey.shade900 // Light theme color
                : Colors.grey,
              ),
              SizedBox(height: 10,),
              CustomOutlinedButton(
                onTap: () {}, 
                text: "Fiók Törlése", 
                progressEvent: _isEvent, 
                outlineColor: Colors.red.shade400,
              ),

              SizedBox(height: 105,),
            ],
          ),
        ),
      ),
    );
  }

   void _isNotificationsEnabled() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        setState(() {
          notifStateText = "Engedélyezés";
          notifTextColor = Colors.blue.shade400; 
        });
      } else {
        setState(() {
          notifStateText = "Engedélyezve";
          notifTextColor = Theme.of(context).brightness == Brightness.light
            ? Colors.green.shade700 // Light theme color
            : Colors.green;
        });
      }
    });


  } 

}