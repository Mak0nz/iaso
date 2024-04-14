import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iaso/widgets/animated_button_widget.dart';
import 'package:iaso/widgets/checkbox_widget.dart';
import 'package:iaso/widgets/input_med_form_widget.dart';
import 'package:iaso/widgets/toast.dart';

class CreateNewMedModal extends StatefulWidget {
  const CreateNewMedModal({super.key});

  @override
  State<CreateNewMedModal> createState() => _CreateNewMedModalState();
}

class _CreateNewMedModalState extends State<CreateNewMedModal> {
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 90),
      child: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          enableDrag: true,
          isScrollControlled: true,
          backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white.withAlpha(200) // Light theme color
            : Colors.blueGrey[900]?.withAlpha(200), // Dark theme color
          builder: (context) => (
            ClipRRect(
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 35, 10, 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AppBar(
                        backgroundColor: Colors.transparent,
                        centerTitle: true,
                        title: Text("Új gyógyszer",
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
    
                      SizedBox(height: 5,),

                      AnimatedButton(
                        onTap: () {
                          final totalDoses = int.parse(controllerCurrentQuantity.text) ~/ int.parse(controllerTakeQuantityPerDay.text);
                          // Ensure lastDays is not negative
                          final updatedTotalDoses = totalDoses > 0 ? totalDoses : 0;
    
                          // update date to be today
                          final lastUpdatedDate = DateTime.now();
    
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
                            totalDoses: updatedTotalDoses,
                            lastUpdatedDate: lastUpdatedDate,
                          );
                          createNewMed(info);
                        },
                        text: "Új gyógyszer mentése", 
                        progressEvent: _isSaving,
                      ),
    
                      SizedBox(height: 10,),

                    ],
                  ),
                ),
              ),
            )
          ),
        ),
        child: const Icon(FontAwesomeIcons.plus),
      ),
    );
  }

  Future createNewMed(Info info) async{
    setState(() {
      _isSaving = true;  
    });

    final user = FirebaseAuth.instance.currentUser;

    final docRef = FirebaseFirestore.instance.collection('users').doc(user?.email);
    final subcollectiondocumentRef = docRef.collection('MedsForUser').doc();

    final json = info.toJson();
    await subcollectiondocumentRef.set(json);

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
  int totalDoses;
  // ignore: prefer_typing_uninitialized_variables
  var lastUpdatedDate;

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
    this.totalDoses = 0,
    this.lastUpdatedDate = '',
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
    'totalDoses': totalDoses,
    'lastUpdatedDate': lastUpdatedDate,
  };
}