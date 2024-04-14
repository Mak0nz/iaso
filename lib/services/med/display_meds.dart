// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iaso/services/med/edit_med_modal.dart';
import 'package:iaso/widgets/card_widget.dart';

class DisplayMeds extends StatefulWidget {
  final showAll;

  const DisplayMeds({ 
    super.key,
    required this.showAll,
  });

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
        final Query<Map<String, dynamic>> query;
        if (widget.showAll) {
          query = medsCollectionRef.orderBy('name');
        } else {
          query = medsCollectionRef.where('totalDoses', isLessThan: 14)
            .orderBy('totalDoses');
        }

        final querySnapshot = await query.get();

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
          padding: const EdgeInsets.only(top:85 ,bottom: 170), // No content behind appbar & floatingActionButton.
          child: Column(
            children: [
              widget.showAll == false 
              ? Text("Fogyóban lévő Gyógyszerek:", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,),)
              : Card(),

              widget.showAll == false && _medications.isEmpty
              ? Column(
                  children: [
                    SizedBox(height: 15,),
                    CustomCard(
                      leading:  Icon(FontAwesomeIcons.pills),
                      title: Text("Jelenleg nincs fogyóban levő gyógyszer", style: TextStyle(fontSize: 20,),),
                    ),
                  ],
                )
              : Card(),

              Column(
                children: _medications.map((medication) {
                  final data = medication.data();
                  String name = (data as Map<String, dynamic>)['name'] ?? 'No name';
                  final totalDoses = data['totalDoses'] as int;
              
                  // Calculate border color based on totalDoses
                  final borderColor = totalDoses <= 7
                    ? Colors.red
                    : totalDoses <= 14 ? Colors.orange : Colors.grey.shade900;
              
                  return CustomCard(
                    borderColor: borderColor,
                    leading: data['isInCloud'] ? Icon(FontAwesomeIcons.cloud) : null,
                    title: Text(name, style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text('${data['totalDoses']} napnyi van.'),
                    trailing: medication.exists ? EditMedModal(medication: medication.id,) : null,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}