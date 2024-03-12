// ignore_for_file: avoid_unnecessary_containers

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iaso/widgets/input_text_form_widget.dart';
import 'package:iaso/widgets/toast.dart';

class CreateDailyStatsModalSheet extends StatefulWidget {
  const CreateDailyStatsModalSheet({super.key});

  @override
  State<CreateDailyStatsModalSheet> createState() => _CreateDailyStatsModalSheetState();
}

class _CreateDailyStatsModalSheetState extends State<CreateDailyStatsModalSheet> {
  bool _isSaving = false;
  final now = DateTime.now();

  final controllerBpMorningSYS = TextEditingController();
  final controllerBpMorningDIA = TextEditingController();
  final controllerBpMorningPulse = TextEditingController();
  final controllerWeight= TextEditingController();
  final controllerTemp = TextEditingController();
  final controllerBpNightSYS = TextEditingController();
  final controllerBpNightDIA = TextEditingController();
  final controllerBpNightPulse = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchExistingStats();
  }

  Future fetchExistingStats() async {
    final user = FirebaseAuth.instance.currentUser;
    final now = DateTime.now();
    final formattedDate = "${now.year}.${now.month}.${now.day}";

    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user?.email)
        .collection('StatsForUser')
        .doc(formattedDate);

    final docSnapshot = await docRef.get();
    if (docSnapshot.exists) {
      final data = docSnapshot.data();
      // Check for non-zero fields and update controllers
      if (data!['bpMorningSYS'] != 0) {
        controllerBpMorningSYS.text = data['bpMorningSYS'].toString();
      }
      if (data['bpMorningDIA'] != 0) {
        controllerBpMorningDIA.text = data['bpMorningDIA'].toString();
      }
      if (data['bpMorningPulse'] != 0) {
        controllerBpMorningPulse.text = data['bpMorningPulse'].toString();
      }
      if (data['weight'] != 0) {
        controllerWeight.text = data['weight'].toString();
      }
      if (data['temp'] != 0) {
        controllerTemp.text = data['temp'].toString();
      }
      if (data['bpNightSYS'] != 0) {
        controllerBpNightSYS.text = data['bpNightSYS'].toString();
      }
      if (data['bpNightDIA'] != 0) {
        controllerBpNightDIA.text = data['bpNightDIA'].toString();
      }
      if (data['bpNightPulse'] != 0) {
        controllerBpNightPulse.text = data['bpNightPulse'].toString();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context, 
          enableDrag: true,
          isScrollControlled: true,
          backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white.withAlpha(200) // Light theme color
            : Colors.blueGrey[900]?.withAlpha(200), // Dark theme color
          builder: (context) => (
            ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 35, 10, 10),
                  child: Column(
                    children: [
                      AppBar(
                        backgroundColor: Colors.transparent,
                        centerTitle: true,
                        title: Text("${now.month} / ${now.day}",
                          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)
                        ),
                      ),
                      
                      SizedBox(height: 9,),
                      Text("Reggeli vérnyomás:", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),),
                      SizedBox(height: 2,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InputTextFormWidget(
                            width: 60.0,
                            controller: controllerBpMorningSYS,
                            labelText: 'SYS',
                          ),
                          const Text("/", style: TextStyle(fontSize: 16),),
                          InputTextFormWidget(
                            width: 60.0,
                            controller: controllerBpMorningDIA,
                            labelText: 'DIA',
                          ),
                          const Text("mmHg", style: TextStyle(fontSize: 16),),
                          SizedBox(
                            width: 10.0, // Add horizontal spacing between the fields
                          ),
                          InputTextFormWidget(
                            width: 80.0,
                            controller: controllerBpMorningPulse,
                            labelText: 'Pulzus',
                          ),
                          const Text("bpm", style: TextStyle(fontSize: 16),),
                        ],
                      ), 
                      
                      SizedBox(height: 22,),
                  
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Hőmérséklet:   ", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),),
                          InputTextFormWidget(
                            width: 80.0,
                            controller: controllerTemp,
                            labelText: '00.0',
                          ),
                          const Text("°C", style: TextStyle(fontSize: 16),),
                        ],
                      ),
                      
                      SizedBox(height: 22,),
                  
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Súly:   ", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),),
                          InputTextFormWidget(
                            width: 80.0,
                            controller: controllerWeight,
                            labelText: '00.0',
                          ),
                          const Text("Kg", style: TextStyle(fontSize: 16),),
                        ],
                      ),
                      
                      SizedBox(height: 22,),
                  
                      Text("Esti vérnyomás:", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),),
                      SizedBox(height: 2,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InputTextFormWidget(
                            width: 60.0,
                            controller: controllerBpNightSYS,
                            labelText: 'SYS',
                          ),
                          const Text("/", style: TextStyle(fontSize: 16),),
                          InputTextFormWidget(
                            width: 60.0,
                            controller: controllerBpNightDIA,
                            labelText: 'DIA',
                          ),
                          const Text("mmHg", style: TextStyle(fontSize: 16),),
                          SizedBox(
                            width: 10.0, // Add horizontal spacing between the fields
                          ),
                          InputTextFormWidget(
                            width: 80.0,
                            controller: controllerBpNightPulse,
                            labelText: 'Pulzus',
                          ),
                          const Text("bpm", style: TextStyle(fontSize: 16),),
                        ],
                      ),
                      SizedBox(height: 16,),
                  
                      GestureDetector(
                        onTap: () {
                          final stats = Stats(
                            bpMorningSYS: int.tryParse(controllerBpMorningSYS.text) ?? 0,
                            bpMorningDIA: int.tryParse(controllerBpMorningDIA.text) ?? 0,
                            bpMorningPulse: int.tryParse(controllerBpMorningPulse.text) ?? 0,
                            weight: double.tryParse(controllerWeight.text) ?? 0,
                            temp: double.tryParse(controllerTemp.text) ?? 0,
                            bpNightSYS: int.tryParse(controllerBpNightSYS.text) ?? 0,
                            bpNightDIA: int.tryParse(controllerBpNightDIA.text) ?? 0,
                            bpNightPulse: int.tryParse(controllerBpNightPulse.text) ?? 0,
                          );
                          createStatsForUser(stats);
                          Navigator.pop(context); // close modal
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade400,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Center( child: _isSaving ? CircularProgressIndicator(color: Colors.white,):
                              Text("Napi mérés mentése", 
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),  
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ),
        ),
      child: const Icon(FontAwesomeIcons.plus),
    );
  }

  Future createStatsForUser(Stats stats) async {
    setState(() {
      _isSaving = true;  
    });

    final user = FirebaseAuth.instance.currentUser;
    
    final now = DateTime.now();
    final formattedDate = "${now.year}.${now.month}.${now.day}";

    final docRef = FirebaseFirestore.instance.collection('users').doc(user?.email);
    final subcollectiondocumentRef = docRef.collection('StatsForUser').doc(formattedDate);

    final json = stats.toJson();
    await subcollectiondocumentRef.set(json);

    setState(() {
      _isSaving = false;  
    });
    showToast(message: "Elmentve");
  }
  
}

class Stats {
  int bpMorningSYS;
  int bpMorningDIA;
  int bpMorningPulse;
  double weight;
  double temp;
  int bpNightSYS;
  int bpNightDIA;
  int bpNightPulse;

  Stats({
    this.bpMorningSYS = 0,
    this.bpMorningDIA = 0,
    this.bpMorningPulse = 0,
    this.weight = 0.0,
    this.temp = 0.0,
    this.bpNightSYS = 0,
    this.bpNightDIA = 0,
    this.bpNightPulse = 0,
  });

  Map<String, dynamic> toJson() => {
    'bpMorningSYS': bpMorningSYS,
    'bpMorningDIA': bpMorningDIA,
    'bpMorningPulse': bpMorningPulse,
    'weight': weight,
    'temp': temp,
    'bpNightSYS': bpNightSYS,
    'bpNightDIA': bpNightDIA,
    'bpNightPulse': bpNightPulse,
  };
}