import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DisplayStats extends StatefulWidget {
  const DisplayStats({
    super.key,
    required this.selectedDay
  });

  final DateTime selectedDay;

  @override
  State<DisplayStats> createState() => _DisplayStatsState();
}

class _DisplayStatsState extends State<DisplayStats> {
  // Define variables to hold fetched stats
  DocumentSnapshot? statsSnapshot;

  @override
  void initState() {
    super.initState();
    fetchStats();
  }

  Future<void> fetchStats() async {
    // Retrieve stats for the selected day from Firebase
    try {
      final userDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email);

      final selectedDate = widget.selectedDay;
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
              title: Text("Reggeli vérnyomás: ${data['bpMorningSYS']}"),
            ),
          ),
          
          // Add more widgets for other stats
        ],
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildStatsIfAvailable();
  }
}