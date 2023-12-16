import 'package:flutter/material.dart';
import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/view/popups/default.dart';

class DialogTester extends StatelessWidget {
  const DialogTester({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        runAlignment: WrapAlignment.spaceBetween,
        runSpacing: 8,
        children: [
          MaterialButton(
            height: 50,
            minWidth: 300,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            color: Colors.green,
            textColor: Theme.of(context).colorScheme.background,
            onPressed: () {
              Popup.dialog(
                context,
                title: "Success dialog",
                message: "Toto je success dialog",
                type: DialogType.success,
              );
            },
            child: const Text("Success dialog"),
          ),
          MaterialButton(
            height: 50,
            minWidth: 300,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            color: Colors.orange,
            textColor: Theme.of(context).colorScheme.background,
            onPressed: () {
              Popup.dialog(
                context,
                title: "Warning dialog",
                message: "Toto je warning dialog",
                type: DialogType.warning,
              );
            },
            child: const Text("Warning dialog"),
          ),
          MaterialButton(
            height: 50,
            minWidth: 300,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            color: Colors.red,
            textColor: Theme.of(context).colorScheme.background,
            onPressed: () {
              Popup.dialog(
                context,
                title: "Error dialog",
                message: "Toto je error dialog",
                type: DialogType.error,
              );
            },
            child: const Text("Error dialog"),
          ),
          MaterialButton(
            height: 50,
            minWidth: 300,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            color: Colors.blue,
            textColor: Theme.of(context).colorScheme.background,
            onPressed: () {
              Popup.dialog(
                context,
                title: "Info dialog",
                message: "Toto je info dialog",
                type: DialogType.info,
              );
            },
            child: const Text("Info dialog"),
          ),
        ],
      ),
    );
  }
}
