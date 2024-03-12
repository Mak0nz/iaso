import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iaso/screens/pages/meds/create_new_med_modal.dart';

class MedsPage extends StatelessWidget {
  const MedsPage({super.key});

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
        title: Text("Gyógyszerek",
            style: TextStyle(fontWeight: FontWeight.bold)
          ),
        centerTitle: true,
      ),

      floatingActionButton: CreateNewMedModal(),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 95,), // No content behind appbar on pageload.

            ],
          ),
        ),
      ),
    );
  }
}