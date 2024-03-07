import 'dart:ui';

import 'package:flutter/material.dart';

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
        title: Text("Gyógyszer",
            style: TextStyle(fontWeight: FontWeight.bold)
          ),
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 90,), // No content behind appbar on pageload.

            ],
          ),
        ),
      ),
    );
  }
}