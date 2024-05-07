// ignore_for_file: use_key_in_widget_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatefulWidget {
  final onTap;
  final text;
  final progressEvent;
  final outlineColor;

  const CustomOutlinedButton({
    required this.onTap,
    required this.text,
    required this.progressEvent,
    required this.outlineColor,
  });

  @override
  State<CustomOutlinedButton> createState() => _CustomOutlinedButtonState();
}

class _CustomOutlinedButtonState extends State<CustomOutlinedButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: widget.onTap,
      style: OutlinedButton.styleFrom(
        minimumSize: Size.fromHeight(55),
        side: BorderSide(width: 3, color: widget.outlineColor,), 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Center( child: widget.progressEvent ? CircularProgressIndicator(color: Colors.white,):
        Text(widget.text, 
          style: TextStyle(color: widget.outlineColor, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}