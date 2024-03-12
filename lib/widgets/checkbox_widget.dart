// Separate reusable Checkbox widget
// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';

class CheckboxWidget extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;
  final String label;

  const CheckboxWidget({
    Key? key,
    required this.initialValue,
    required this.onChanged,
    required this.label,
  }) : super(key: key);

  @override
  _CheckboxWidgetState createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "   ${widget.label}:",
            style: TextStyle(fontSize: 19),
          ),
        ),
        Checkbox.adaptive(
          value: _value,
          shape: OvalBorder(),
          onChanged: (newValue) {
            setState(() {
              _value = newValue!; // Use the non-null assertion operator
              widget.onChanged(newValue);
            });
          },
        ),
      ],
    );
  }
}