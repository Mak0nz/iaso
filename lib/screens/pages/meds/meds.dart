import 'package:flutter/material.dart';
import 'package:iaso/screens/pages/meds/create_new_med_modal.dart';
import 'package:iaso/services/med/display_meds.dart';
import 'package:iaso/widgets/appbar_widget.dart';

class MedsPage extends StatelessWidget {
  const MedsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(title: "Gyógyszerek"),

      floatingActionButton: CreateNewMedModal(),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            DisplayMeds(showAll: true),
          ],
        ),
      ),
    );
  }
}