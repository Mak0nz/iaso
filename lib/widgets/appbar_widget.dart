// ignore_for_file: unnecessary_new, use_key_in_widget_constructors, prefer_typing_uninitialized_variables

import 'dart:ui';

import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final title;
  final leading;
  final actions;
  final actionsEvent;

  const CustomAppBar({
    required this.title,
    this.leading,
    this.actions,
    this.actionsEvent,
  });
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  State<CustomAppBar> createState() => new _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return new AppBar(
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Container(color: Colors.transparent,),
        ),
      ),
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: 
        Text(widget.title,
          style: TextStyle(fontWeight: FontWeight.bold)
        ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: widget.leading,
      ),
      actions: <Widget>[
        GestureDetector(
          onTap: widget.actionsEvent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: widget.actions,
          ),
        ),
      ],
    );
  }
}