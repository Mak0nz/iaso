import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                              child: Text("  Kell bevenni:",
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: 10), // Adjust padding as needed
                              child: Row(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text("  Hétfő",
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.normal
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  CheckboxWidget(
                                    initialValue: controllerTakeMonday,
                                    onChanged: (newValue) => setState(() => controllerTakeMonday = newValue),
                                  ),
                                ]
                              ),
                            ),
                            
                            Padding(
                              padding: EdgeInsets.only(left: 10), // Adjust padding as needed
                              child: Row(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text("  Kedd",
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.normal
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  CheckboxWidget(
                                    initialValue: controllerTakeTuesday,
                                    onChanged: (newValue) => setState(() => controllerTakeTuesday = newValue),
                                  ),
                                ]
                              ),
                            ),

                          ],
                        ),
                      ),

                      InputMedFormWidget(
                        labelText: "Mennyi db van",
                        controller: controllerCurrentQuantity,
                        textInputType: TextInputType.number,
                      ),

                      InputMedFormWidget(
                        labelText: "Kivel kell föliratni",
                        controller: controllerOrderedBy,
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
                          createNewMed(info);
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
                              Text("Új gyógyszer mentése", 
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
      child: const Icon(FontAwesomeIcons.plus),
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


// Separate StatefulWidget for the checkbox
class CheckboxWidget extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  // ignore: use_super_parameters
  const CheckboxWidget({
    Key? key,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CheckboxWidgetState createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox.adaptive(
      value: _value,
      shape: OvalBorder(),
      onChanged: (newValue) {
        setState(() {
          _value = newValue!;
          widget.onChanged(newValue);
        });
      },
    );
  }
}