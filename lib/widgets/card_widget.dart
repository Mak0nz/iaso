// ignore_for_file: unnecessary_new, prefer_typing_uninitialized_variables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final borderColor;
  final leading;
  final title;
  final subtitle;
  final trailing;

  const CustomCard({
    this.borderColor,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  State<CustomCard> createState() => new _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    final borderColor = widget.borderColor ?? Colors.grey.shade900;

    return new Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor, width: 2.0),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: widget.leading,
        title: widget.title,
        subtitle: widget.subtitle,
        trailing: widget.trailing,
      ),
    );
  }
}