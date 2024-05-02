import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iaso/widgets/input_text_form_widget.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class StatsModal extends StatefulWidget {
  const StatsModal({super.key});

  @override
  State<StatsModal> createState() => _StatsModalState();
}

class _StatsModalState extends State<StatsModal> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 90), // to not hide behind bottom navigation bar
      child: FloatingActionButton(
        onPressed: () {
          WoltModalSheet.show(context: context, pageListBuilder: (context) {
            return [WoltModalSheetPage(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text("text"),
                    InputTextFormWidget(
                      labelText: "hello",
                      width: 100,
                      controller: TextEditingController(),
                    ),
                    
                  ],
                ),
              ),
              topBarTitle: Text("data",),
              isTopBarLayerAlwaysVisible: true,

            )
            ];
          },
          );
        },
        child: const Icon(FontAwesomeIcons.plus),
      ),
    );
  }
}