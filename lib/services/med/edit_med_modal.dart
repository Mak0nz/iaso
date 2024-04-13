import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iaso/widgets/checkbox_widget.dart';
import 'package:iaso/widgets/input_med_form_widget.dart';
import 'package:iaso/widgets/toast.dart';

class EditMedModal extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final medication;

  const EditMedModal({
    super.key,
    this.medication,
  });

  @override
  State<EditMedModal> createState() => _EditMedModalState();
}

class _EditMedModalState extends State<EditMedModal> {
  bool _isSaving = false;

  final controllerName = TextEditingController();
  final controllerActiveAgent = TextEditingController();
  final controllerUseCase = TextEditingController();
  final controllerSideEffect = TextEditingController();
  final controllerTakeQuantityPerDay = TextEditingController();
  bool controllerTakeMonday = false;
  bool controllerTakeTuesday = false;
  bool controllerTakeWednesday = false;
  bool controllerTakeThursday = false;
  bool controllerTakeFriday = false;
  bool controllerTakeSaturday = false;
  bool controllerTakeSunday = false;
  final controllerCurrentQuantity = TextEditingController();
  final controllerOrderedBy = TextEditingController();
  bool controllerIsInCloud = false;

  @override
  void initState() {
    super.initState();
    fetchExistingStats();
  }

  Future fetchExistingStats() async {
    final user = FirebaseAuth.instance.currentUser;

    final docRef = FirebaseFirestore.instance
      .collection('users').doc(user?.email)
        .collection('MedsForUser').doc(widget.medication);

    final docSnapshot = await docRef.get();
    if (docSnapshot.exists) {
      final data = docSnapshot.data();
        controllerName.text = data!['name'].toString();
        controllerActiveAgent.text = data['activeAgent'].toString();
        controllerUseCase.text = data['useCase'].toString();
        controllerSideEffect.text = data['sideEffect'].toString();
        controllerTakeQuantityPerDay.text = data['takeQuantityPerDay'].toString();
        controllerTakeMonday = data['takeMonday'];
        controllerTakeTuesday = data['takeTuesday'];
        controllerTakeWednesday = data['takeWednesday'];
        controllerTakeThursday = data['takeThursday'];
        controllerTakeFriday = data['takeFriday'];
        controllerTakeSaturday = data['takeSaturday'];
        controllerTakeSunday = data['takeSunday'];
        controllerCurrentQuantity.text = data['currentQuantity'].toString();
        controllerOrderedBy.text = data['orderedBy'].toString();
        controllerIsInCloud = data['isInCloud'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white.withAlpha(200) // Light theme color
          : Colors.blueGrey[900]?.withAlpha(200), // Dark theme color
        builder: (context) => (
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 35, 10, 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AppBar(
                        backgroundColor: Colors.transparent,
                        centerTitle: true,
                        title: Text("Gyógyszer",
                          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)
                        ),
                      ),
                      SizedBox(height: 9,),

                      InputMedFormWidget(
                        labelText: "Gyógyszer neve",
                        controller: controllerName,
                      ),

                      InputMedFormWidget(
                        labelText: "Hatóanyag",
                        controller: controllerActiveAgent,
                      ),

                      InputMedFormWidget(
                        labelText: "Hatás",
                        controller: controllerUseCase,
                      ),

                      InputMedFormWidget(
                        labelText: "Mellékhatás",
                        controller: controllerSideEffect,
                      ),

                      InputMedFormWidget(
                        labelText: "Napi mennyiség",
                        controller: controllerTakeQuantityPerDay,
                        textInputType: TextInputType.number,
                      ),

                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("  Mely napokon kell bevenni:",
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),

                            CheckboxWidget(
                              label: "Hétfő",
                              initialValue: controllerTakeMonday,
                              onChanged: (newValue) => setState(() => controllerTakeMonday = newValue),
                            ),

                            CheckboxWidget(
                              label: "Kedd",
                              initialValue: controllerTakeTuesday,
                              onChanged: (newValue) => setState(() => controllerTakeTuesday = newValue),
                            ),

                            CheckboxWidget(
                              label: "Szerda",
                              initialValue: controllerTakeWednesday,
                              onChanged: (newValue) => setState(() => controllerTakeWednesday = newValue),
                            ),

                            CheckboxWidget(
                              label: "Csütörtök",
                              initialValue: controllerTakeThursday,
                              onChanged: (newValue) => setState(() => controllerTakeThursday = newValue),
                            ),

                            CheckboxWidget(
                              label: "Péntek",
                              initialValue: controllerTakeFriday,
                              onChanged: (newValue) => setState(() => controllerTakeFriday = newValue),
                            ),

                            CheckboxWidget(
                              label: "Szombat",
                              initialValue: controllerTakeSaturday,
                              onChanged: (newValue) => setState(() => controllerTakeSaturday = newValue),
                            ),

                            CheckboxWidget(
                              label: "Vasárnap",
                              initialValue: controllerTakeSunday,
                              onChanged: (newValue) => setState(() => controllerTakeSunday = newValue),
                            ),
                          ],
                        ),
                      ),

                      InputMedFormWidget(
                        labelText: "Hány darab van",
                        controller: controllerCurrentQuantity,
                        textInputType: TextInputType.number,
                      ),

                      InputMedFormWidget(
                        labelText: "Kivel kell feliratni",
                        controller: controllerOrderedBy,
                      ),

                      CheckboxWidget(
                        label: "Van-e a felhőben",
                        initialValue: controllerIsInCloud,
                        onChanged: (newValue) => setState(() => controllerIsInCloud = newValue),
                      ),

                      SizedBox(height: 16,),
                      GestureDetector(
                        onTap: () {
                          final info = Info(
                            name: controllerName.text,
                            activeAgent: controllerActiveAgent.text,
                            useCase: controllerUseCase.text,
                            sideEffect: controllerSideEffect.text,
                            takeQuantityPerDay: int.parse(controllerTakeQuantityPerDay.text),
                            takeMonday: controllerTakeMonday,
                            takeTuesday: controllerTakeTuesday,
                            takeWednesday: controllerTakeWednesday,
                            takeThursday: controllerTakeThursday,
                            takeFriday: controllerTakeFriday,
                            takeSaturday: controllerTakeSaturday,
                            takeSunday: controllerTakeSunday,
                            currentQuantity: int.parse(controllerCurrentQuantity.text),
                            orderedBy: controllerOrderedBy.text,
                            isInCloud: controllerIsInCloud,
                          );
                          editMed(info);
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
                              Text("Gyógyszer mentése", 
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
            ),
          )
        ),
      ),
      child: const Icon(FontAwesomeIcons.penToSquare),
    );
  }

  Future editMed(Info info) async{
    setState(() {
      _isSaving = true;  
    });

    final user = FirebaseAuth.instance.currentUser;

    final docRef = FirebaseFirestore.instance.collection('users').doc(user?.email)
        .collection('MedsForUser').doc(widget.medication);
    await docRef.update(info.toJson());

    // Calculate the estimated last days ignoring non-take days
    final docSnapshot = await docRef.get();
    final data = docSnapshot.data();
    final currentQuantity = data!['currentQuantity'];
    final takeQuantityPerDay = data['takeQuantityPerDay'];

    final totalDoses = currentQuantity ~/ takeQuantityPerDay;
    // Ensure lastDays is not negative
    final updatedTotalDoses = totalDoses > 0 ? totalDoses : 0;

    // update date to be today
    final lastUpdatedDate = DateTime.now();

    await docRef.update({'totalDoses': updatedTotalDoses, 'lastUpdatedDate': lastUpdatedDate});

    setState(() {
      _isSaving = false;  
    });
    showToast(message: "Elmentve");
    // ignore: use_build_context_synchronously
    Navigator.pop(context); // close modal
  }

}

class Info {
  String name;
  String activeAgent;
  String useCase;
  String sideEffect;
  int takeQuantityPerDay;
  bool takeMonday;
  bool takeTuesday;
  bool takeWednesday;
  bool takeThursday;
  bool takeFriday;
  bool takeSaturday;
  bool takeSunday;
  int currentQuantity;
  String orderedBy;
  bool isInCloud;

  Info ({
    this.name = 'null',
    this.activeAgent = 'null',
    this.useCase = 'null',
    this.sideEffect = '',
    this.takeQuantityPerDay = 0,
    this.takeMonday = false,
    this.takeTuesday = false,
    this.takeWednesday = false,
    this.takeThursday = false,
    this.takeFriday = false,
    this.takeSaturday = false,
    this.takeSunday = false,
    this.currentQuantity = 0,
    this.orderedBy = 'null',
    this.isInCloud = false,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'activeAgent': activeAgent,
    'useCase': useCase,
    'sideEffect': sideEffect,
    'takeQuantityPerDay': takeQuantityPerDay,
    'takeMonday': takeMonday,
    'takeTuesday': takeTuesday,
    'takeWednesday': takeWednesday,
    'takeThursday': takeThursday,
    'takeFriday': takeFriday,
    'takeSaturday': takeSaturday,
    'takeSunday': takeSunday,
    'currentQuantity': currentQuantity,
    'orderedBy': orderedBy,
    'isInCloud': isInCloud,
  };
}