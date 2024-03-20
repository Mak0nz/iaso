// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iaso/services/med/edit_med_modal.dart';

class DisplayMeds extends StatefulWidget {

  const DisplayMeds({ super.key});

  @override
  State<DisplayMeds> createState() => _DisplayMedsState();
}

class _DisplayMedsState extends State<DisplayMeds> {
  List<DocumentSnapshot> _medications = [];
  String? _currentUserEmail;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    // Retrieve the current user's email
    _currentUserEmail = FirebaseAuth.instance.currentUser?.email;

    if (_currentUserEmail != null) {
      try {
        // Get a reference to the MedsForUser subcollection for the current user
        final medsCollectionRef = FirebaseFirestore.instance
            .collection('users')
            .doc(_currentUserEmail)
            .collection('MedsForUser');

        // Query the subcollection, order by a specific field (e.g., 'name')
        final querySnapshot = await medsCollectionRef.orderBy('name').get();

        // Update state with the retrieved medications
        setState(() {
          _medications = querySnapshot.docs;
        });
      } on FirebaseException catch (e) {
        // Handle errors (e.g., display an error message)
        print("Error fetching medications: ${e.message}");
      }
    } else {
      // Handle the case where there's no current logged-in user
    }
  }
  
  @override
  Widget build(BuildContext context){
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:95 ,bottom: 80), // No content behind appbar & floatingActionButton.
          child: Column(
            children: _medications.map((medication) {
              final data = medication.data();
              String name = (data as Map<String, dynamic>)['name'] ?? 'No name';
              final totalDoses = data['totalDoses'] as int;

              // Calculate border color based on totalDoses
              final borderColor = totalDoses <= 7
                ? Colors.red
                : totalDoses <= 14 ? Colors.orange : Colors.grey.shade900;

              return Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: borderColor, width: 2.0),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: data['isInCloud'] ? Icon(FontAwesomeIcons.cloud) : null,
                  title: Text(name, style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text('${data['totalDoses']} napnyi van.'),
                  trailing: medication.exists ? EditMedModal(medication: medication.id,) : null,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}