import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iaso/services/med/display_meds.dart';
import 'package:iaso/widgets/appbar_widget.dart';
//import 'package:iaso/widgets/toast.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String greetingText = "";

  @override
  void initState() {
    super.initState();
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
          final username = docRef.get("username");
          greetingText = "Helló $username"; // Update greeting text
        } else {
          greetingText = "Helló UserNotFound"; // Update greeting text

        }
      } else {
        greetingText = "Helló UserNotFound"; // Update greeting text
      }
      setState(() {});
    }
    getUsername(); // Call function to fetch username on app launch
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;
    if (FirebaseAuth.instance.currentUser!.photoURL != null) {
      imageProvider = NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!); // No cast needed
    } else {
      imageProvider = AssetImage('assets/logo.png'); 
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: greetingText,
        leading: CircleAvatar(
            backgroundImage: imageProvider,
        ),
      /*actions: Icon(FontAwesomeIcons.rightFromBracket,),
        actionsEvent: () {
          FirebaseAuth.instance.signOut();
          Navigator.pushNamed(context, "/login");
          showToast(message: "Sikeresen kijelentkezve");
        }, */
      ),

      body: Padding(
        padding: const EdgeInsets.all(10), // No content behind appbar on pageload.
        child: Column(
          children: [
            DisplayMeds(showAll: false),
            
          ], 
        ),
      ), 

    );
  }
}