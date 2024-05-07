import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class ChangeLanguageModal extends StatefulWidget {
  const ChangeLanguageModal({super.key});

  @override
  State<ChangeLanguageModal> createState() => _ChangeLanguageModalState();
}

class _ChangeLanguageModalState extends State<ChangeLanguageModal> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WoltModalSheet.show(context: context, pageListBuilder: (context) {
          return [ WoltModalSheetPage(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 35),
              child: Column(
                children: [
                  
                ],
              ),
            ),
            backgroundColor: Theme.of(context).brightness == Brightness.light
                ? Colors.white.withAlpha(200) // Light theme color
                : Colors.blueGrey[900]?.withAlpha(200),
          )];
        });
      },
      child: Icon(FontAwesomeIcons.chevronRight),
    );
  }
}