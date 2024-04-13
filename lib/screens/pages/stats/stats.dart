import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iaso/screens/pages/stats/create_daily_stats_modal_sheet.dart';
import 'package:iaso/services/stats/display_stats_page.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Container(color: Colors.transparent,),
          ),
        ),
        automaticallyImplyLeading: false,
        title: Text("Napi mérések",
            style: TextStyle(fontWeight: FontWeight.bold)
          ),
        centerTitle: true,
      ),

      floatingActionButton: CreateDailyStatsModalSheet(),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top:75 ,bottom: 170), // No content behind appbar & floatingActionButton.
            child: DisplayStatsPage(),
          ),
        ),
      ),
    );
  }

}