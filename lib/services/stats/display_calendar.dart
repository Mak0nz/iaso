import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DisplayCalendar extends StatefulWidget {
  const DisplayCalendar({super.key});

  @override
  State<DisplayCalendar> createState() => _DisplayCalendarState();
}

class _DisplayCalendarState extends State<DisplayCalendar> {
  DateTime today = DateTime.now();
  
  late DateTime firstDay;

  late final ValueNotifier<DateTime> _firstDayNotifier =
      ValueNotifier(DateTime.now()); // Initially set to current date

  @override
  void initState() {
    super.initState();
    _retrieveFirstSaveDay();
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
    }
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day; // Update selected day on user interaction
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _retrieveFirstSaveDay(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return TableCalendar(
            locale: "hu_HU",
            headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true),
            availableGestures: AvailableGestures.all,
            selectedDayPredicate: (day) => isSameDay(day, today),
            focusedDay: today,
            firstDay: _firstDayNotifier.value,
            lastDay: DateTime.now(),
            onDaySelected: _onDaySelected,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}