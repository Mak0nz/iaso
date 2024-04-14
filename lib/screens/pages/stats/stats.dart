import 'package:flutter/material.dart';
import 'package:iaso/screens/pages/stats/create_daily_stats_modal_sheet.dart';
import 'package:iaso/services/stats/display_stats_page.dart';
import 'package:iaso/widgets/appbar_widget.dart';

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
      appBar: CustomAppBar(title: "Napi mérések"),

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