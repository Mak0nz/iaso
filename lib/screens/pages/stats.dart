import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iaso/widgets/toast.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.transparent,),
          ),
        ),
        automaticallyImplyLeading: false,
        title: Text("Napi mérés     ${now.day}/${now.month}",
            style: TextStyle(fontWeight: FontWeight.bold)
          ),
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 95,), // No content behind appbar on pageload.
              Text("Reggeli vérnyomás:", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.0), // Adjust padding as needed
                    child: SizedBox(
                      width: 60.0, // Set a fixed width for better layout control
                      child: TextFormField(
                        controller: controllerBpMorningSYS,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0,),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15.0,),
                          ),
                          labelText: 'SYS',
                        ),
                      ),
                    ),
                  ),
                  const Text("/", style: TextStyle(fontSize: 20),),
                  Padding(
                    padding: EdgeInsets.all(4.0), // Adjust padding as needed
                    child: SizedBox(
                      width: 60.0, // Set a fixed width for better layout control
                      child: TextFormField(
                        controller: controllerBpMorningDIA,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15.0,),
                          ),
                          labelText: 'DIA',
                        ),
                      ),
                    ),
                  ),

                  const Text("mmHg", style: TextStyle(fontSize: 20),),
                  SizedBox(
                    width: 10.0, // Add horizontal spacing between the fields
                  ),

                  Padding(
                    padding: EdgeInsets.all(4.0), // Adjust padding as needed
                    child: SizedBox(
                      width: 80.0, // Set a fixed width for better layout control
                      child: TextFormField(
                        controller: controllerBpMorningPulse,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15.0,),
                          ),
                          labelText: 'Pulzus',
                        ),
                      ),
                    ),
                  ),
                  const Text("bpm", style: TextStyle(fontSize: 20),),

                ],
              ), 
              
              SizedBox(height: 22,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Hőmérséklet:   ", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),),

                  Padding(
                    padding: EdgeInsets.all(4.0), // Adjust padding as needed
                    child: SizedBox(
                      width: 80.0, // Set a fixed width for better layout control
                      child: TextFormField(
                        controller: controllerTemp,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15.0,),
                          ),
                          labelText: '00.0',
                        ),
                      ),
                    ),
                  ),
                  const Text("°C", style: TextStyle(fontSize: 20),),
                ],
              ),
              
              SizedBox(height: 22,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Súly:   ", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),),

                  Padding(
                    padding: EdgeInsets.all(4.0), // Adjust padding as needed
                    child: SizedBox(
                      width: 80.0, // Set a fixed width for better layout control
                      child: TextFormField(
                        controller: controllerWeight,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15.0,),
                          ),
                          labelText: '00.0',
                        ),
                      ),
                    ),
                  ),
                  const Text("Kg", style: TextStyle(fontSize: 20),),
                ],
              ),
              
              SizedBox(height: 22,),

              Text("Esti vérnyomás:", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.0), // Adjust padding as needed
                    child: SizedBox(
                      width: 60.0, // Set a fixed width for better layout control
                      child: TextFormField(
                        controller: controllerBpNightSYS,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0,),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15.0,),
                          ),
                          labelText: 'SYS',
                        ),
                      ),
                    ),
                  ),
                  const Text("/", style: TextStyle(fontSize: 20),),
                  Padding(
                    padding: EdgeInsets.all(4.0), // Adjust padding as needed
                    child: SizedBox(
                      width: 60.0, // Set a fixed width for better layout control
                      child: TextFormField(
                        controller: controllerBpNightDIA,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15.0,),
                          ),
                          labelText: 'DIA',
                        ),
                      ),
                    ),
                  ),

                  const Text("mmHg", style: TextStyle(fontSize: 20),),
                  SizedBox(
                    width: 10.0, // Add horizontal spacing between the fields
                  ),

                  Padding(
                    padding: EdgeInsets.all(4.0), // Adjust padding as needed
                    child: SizedBox(
                      width: 80.0, // Set a fixed width for better layout control
                      child: TextFormField(
                        controller: controllerBpNightPulse,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15.0,),
                          ),
                          labelText: 'Pulzus',
                        ),
                      ),
                    ),
                  ),
                  const Text("bpm", style: TextStyle(fontSize: 20),),

                ],
              ),
              SizedBox(height: 22,),

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