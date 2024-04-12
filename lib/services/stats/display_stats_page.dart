import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DisplayStatsPage extends StatefulWidget {
  const DisplayStatsPage({super.key});

  @override
  State<DisplayStatsPage> createState() => _DisplayStatsPageState();
}

class _DisplayStatsPageState extends State<DisplayStatsPage> {
  DateTime today = DateTime.now();
  
  late DateTime firstDay;
  bool firstSaveDayRetrieved = false; // Flag to track retrieval

  late final ValueNotifier<DateTime> _firstDayNotifier =
      ValueNotifier(DateTime.now()); // Initially set to current date

  late final ValueNotifier<DateTime> _onDaySelectedEvent = ValueNotifier(DateTime.now());

  DocumentSnapshot? statsSnapshot;

  @override
  void initState() {
    super.initState();
    _retrieveFirstSaveDay();
    _fetchStats(today);
  }

  Future<void> _retrieveFirstSaveDay() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      if (kDebugMode) {
        print("There is currently no logged in user");
      }
      return; // Handle the case where there's no logged-in user
    }

    final userDoc = FirebaseFirestore.instance
    .collection('users')
    .doc(user.email);

    final snapshot = await userDoc.get();

    if (snapshot.exists) {
      final data = snapshot.data()!;
      if (data.containsKey('firstSaveDay')) {
        final firstSaveDayTimestamp = data['firstSaveDay'] as Timestamp;
        firstDay = firstSaveDayTimestamp.toDate();
        if (kDebugMode) {
          print("user has a firstSaveDay field $firstDay");
        }
      } else {
        // Handle the case where 'firstSaveDay' doesn't exist
        final oldestDocRef =
          await FirebaseFirestore.instance
          .collection('users')
          .doc(user.email)
          .collection('StatsForUser')
          .orderBy('dateField', descending: false)
          .limit(1).get();
        if (kDebugMode) {
          print("ordering StatsForuser");
        }
        if (oldestDocRef.docs.isNotEmpty) {
          if (kDebugMode) {
            print("found StatsForUser");
          }
          final oldestDateString = oldestDocRef.docs.first.id;
          final oldestDateParts = oldestDateString.split('.');
          firstDay = DateTime(int.parse(oldestDateParts[0]), int.parse(oldestDateParts[1]), int.parse(oldestDateParts[2]));
          await userDoc.set({'firstSaveDay': Timestamp.fromDate(firstDay)}, SetOptions(merge: true));
          if (kDebugMode) {
            print("Saved firstDay as: $firstDay");
          }
        } else {
          firstDay = DateTime(today.year, today.month, 1); // First day of current month
          if (kDebugMode) {
            print("cannot find StatsForUser $firstDay");
          }
        }
      }
    } else {
      // Handle the case where the user document doesn't exist
      if (kDebugMode) {
        firstDay = DateTime(today.year, today.month, 1); // First day of current month
        if (kDebugMode) {
          print("cannot find StatsForUser $firstDay");
        }
      }
    }

    if (_firstDayNotifier.value != firstDay) {
      _firstDayNotifier.value = firstDay;
      setState(() {}); // Trigger rebuild if firstDay changed
    }

    firstSaveDayRetrieved = true; // Mark retrieval as done
  }

  Future<void> _fetchStats(DateTime selectedDay) async {
    // Retrieve stats for the selected day from Firebase
    try {
      final userDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email);

      final selectedDate = selectedDay;
      final formattedDate = DateFormat('yyyy.M.d').format(selectedDate);

      statsSnapshot = await userDoc
        .collection('StatsForUser')
        .doc(formattedDate)
        .get();
      setState(() {}); // Trigger rebuild to display fetched stats
      if (kDebugMode) {
        print("Selected Date: $formattedDate");
      }
    } catch (error) {
      // Handle errors gracefully
      if (kDebugMode) {
        print("Error fetching stats: $error");
      }
    }
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) async {
    setState(() {
      today = day; // Update selected day on user interaction
      if (!firstSaveDayRetrieved) {
        _retrieveFirstSaveDay(); // Retrieve if not done yet
      }
      _onDaySelectedEvent.value = day;
      _fetchStats(day);
    });


  }
  
  Widget _buildStatsIfAvailable() {
    if (statsSnapshot != null) {
      // Map the data from statsSnapshot to individual stats widgets
      // Example:
      Map<String, dynamic> data = statsSnapshot!.data()! as Map<String, dynamic>;
      return Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey.shade900, width: 2.0),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Súly:   ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
                  Text("${data['weight']}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  const Text(" Kg", style: TextStyle(fontSize: 18),),
                ],
              ),
            ),
          ),

          SizedBox(height: 5,),

          Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey.shade900, width: 2.0),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Hőmérséklet:   ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
                  Text("${data['temp']}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  const Text(" °C", style: TextStyle(fontSize: 18),),
                ],
              ),
            ),
          ),

          SizedBox(height: 5,),

          Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey.shade900, width: 2.0),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              title: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Reggeli vérnyomás:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),)
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${data['bpMorningSYS']}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      const Text(" / ", style: TextStyle(fontSize: 18),),
                      Text("${data['bpMorningDIA']}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      const Text(" mmHg", style: TextStyle(fontSize: 18),),
                      const SizedBox(width: 25,),
                      Text("${data['bpMorningPulse']}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      const Text(" bpm", style: TextStyle(fontSize: 18),),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 5,),

          Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey.shade900, width: 2.0),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              title: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Esti vérnyomás:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),)
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${data['bpNightSYS']}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      const Text(" / ", style: TextStyle(fontSize: 18),),
                      Text("${data['bpNightDIA']}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      const Text(" mmHg", style: TextStyle(fontSize: 18),),
                      const SizedBox(width: 25,),
                      Text("${data['bpNightPulse']}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      const Text(" bpm", style: TextStyle(fontSize: 18),),
                    ],
                  ),
                ],
              ),
            ),
          ),

        ],
      );
    } else {
      return const Center(child: Text("Nincs adat a jelen napra.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),));
    }
  }

  @override
  Widget build(BuildContext context) {
    return firstSaveDayRetrieved
    ? Column(
      children: [
        TableCalendar(
          locale: "hu_HU",
          headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true),
          availableGestures: AvailableGestures.all,
          startingDayOfWeek: StartingDayOfWeek.monday,
          selectedDayPredicate: (day) => isSameDay(day, today),
          focusedDay: today,
          firstDay: _firstDayNotifier.value,
          lastDay: DateTime.now(),
          onDaySelected: _onDaySelected,
        ),
        ValueListenableBuilder(
          valueListenable: _onDaySelectedEvent, 
          builder: (context, value, _) {
            return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: _buildStatsIfAvailable(),
                ),
            );
          }
        )
      ],
    )
    : const Center(child: CircularProgressIndicator());
  }
}