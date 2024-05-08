// ignore_for_file: unused_field, unused_local_variable

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iaso/widgets/animated_button_widget.dart';
import 'package:iaso/widgets/input_text_form_widget.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class StatsModal extends StatefulWidget {
  const StatsModal({super.key});

  @override
  State<StatsModal> createState() => _StatsModalState();
}

class _StatsModalState extends State<StatsModal> {
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
    List months = 
    ['Január', 'Február', 'Március', 'Április', 'Május','Június','Július','Augusztus','Szeptember','Október','November','December'];
    var currentMon = now.month;
    final honap = months[currentMon-1];
    
    final selectedDate = DateTime.now(); // Initial date set to today

    return Padding(
      padding: const EdgeInsets.only(bottom: 90), // to not hide behind bottom navigation bar
      child: FloatingActionButton(
        onPressed: () {
          WoltModalSheet.show(context: context, pageListBuilder: (context) {
            return [WoltModalSheetPage(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 35),
                child: Column(
                  children: [

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

                    AnimatedButton(
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
                          dateField: selectedDate,
                        );
                        createStatsForUser(stats);
                      },
                      text: "Napi mérés mentése",
                      progressEvent: _isSaving,
                    ),

                  ],
                ),
              ),
              topBarTitle: Text("$honap ${now.day}",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)
              ),
              isTopBarLayerAlwaysVisible: true,
              trailingNavBarWidget: IconButton(
                padding: const EdgeInsets.all(20),
                onPressed: Navigator.of(context).pop, 
                icon: const Icon(FontAwesomeIcons.xmark)
              ),
              enableDrag: false,
              backgroundColor: Theme.of(context).brightness == Brightness.light
                ? Colors.white.withAlpha(200) // Light theme color
                : Colors.blueGrey[900]?.withAlpha(200),
            )
            ];
          },
          );
        },
        child: const Icon(FontAwesomeIcons.plus),
      ),
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

    CherryToast.success(
      title: Text("Elmentve",
        style: TextStyle(color: Colors.black),
      ),
    // ignore: use_build_context_synchronously
    ).show(context);
  
    // ignore: use_build_context_synchronously
    Navigator.pop(context); // close modal
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
  // ignore: prefer_typing_uninitialized_variables
  var dateField;

  Stats({
    this.bpMorningSYS = 0,
    this.bpMorningDIA = 0,
    this.bpMorningPulse = 0,
    this.weight = 0.0,
    this.temp = 0.0,
    this.bpNightSYS = 0,
    this.bpNightDIA = 0,
    this.bpNightPulse = 0,
    this.dateField,
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
    'dateField': dateField,
  };
}