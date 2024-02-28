import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:heamed/widgets/toast.dart';

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
      appBar: AppBar(
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.transparent,),
          ),
        ),
        backgroundColor: Colors.white.withAlpha(200),
        automaticallyImplyLeading: false,
        title: 
          Text(greetingText,
            style: TextStyle(fontWeight: FontWeight.bold)
          ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: CircleAvatar(
            backgroundImage: imageProvider,
          ),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, "/login");
              showToast(message: "Sikeresen kijelentkezve");
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.logout, color: Colors.black,),
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 90,), // No content behind appbar on pageload.

              Text("placeholdere"),
              Image.asset('assets/logo.png'),
              Text("placeholdere"),
              Text("placeholdere"),

              SizedBox(height: 30,),
              Text("placeholder"),
              SizedBox(height: 30,),
              Text("placeholder"),
              SizedBox(height: 30,),
              Text("placeholder"),
              SizedBox(height: 30,),
              Text("placeholder"),
              SizedBox(height: 30,),
              Text("placeholder"),
              SizedBox(height: 30,),
              Text("placeholder"),
              SizedBox(height: 30,),
              Text("placeholder"),
              SizedBox(height: 30,),
              Text("placeholder"),
              SizedBox(height: 30,),
              Text("placeholder"),
              SizedBox(height: 30,),
              Text("placeholder"),
              SizedBox(height: 30,),
              Text("placeholder"),
              SizedBox(height: 30,),
              Text("placeholder"),
              SizedBox(height: 30,),
              Text("placeholder"),
              SizedBox(height: 30,),
              Text("placeholder"),
              SizedBox(height: 30,),
              Text("placeholder"),
              SizedBox(height: 30,),

              Center(child: Text("Welcome Home buddy!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19),)),
              SizedBox(height: 30,),
              GestureDetector(
                onTap: (){
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamed(context, "/login");
                  showToast(message: "Sikeresen kijelentkezve");
                },
                child: Container(
                height: 45,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text("Kijelentkezés",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),),
              ),)


            ],
          )
        ),
      ), 

    );
  }
}