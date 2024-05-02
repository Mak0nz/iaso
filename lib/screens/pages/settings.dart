import 'package:flutter/material.dart';
import 'package:iaso/widgets/appbar_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(title: "Beállítások"),

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