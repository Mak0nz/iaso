// ignore_for_file: unnecessary_new, avoid_unnecessary_containers, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class InputMedFormWidget extends StatefulWidget {
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType? textInputType;

  const InputMedFormWidget({
    this.labelText,
    this.controller,
    this.textInputType,
  }
  );

  @override
  // ignore: library_private_types_in_public_api
  _InputMedFormState createState() => new _InputMedFormState();
}

class _InputMedFormState extends State<InputMedFormWidget> {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.all(4.0), // Adjust padding as needed
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text("  ${widget.labelText ?? "labeltext null"}:",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(height: 2,),
          SizedBox(
            width: double.infinity,
            child: TextFormField(
              controller: widget.controller,
              keyboardType: widget.textInputType,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0,),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15.0,),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(15.0,),
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}