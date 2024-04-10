import 'package:flutter/material.dart';
import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/view/layouts/default_layout.dart';
import 'package:vader_popup/vader_popup.dart';

class DialogTester extends StatelessWidget {
  const DialogTester({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "Test popups",
      body: Center(
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
                popup.success(
                  context: context,
                  title: "Success dialog",
                  message: "Toto je success dialog",
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
                popup.warning(
                  context: context,
                  title: "Warning dialog",
                  message: "Toto je warning dialog",
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
                popup.error(
                  context: context,
                  title: "Error dialog",
                  message: "Toto je error dialog",
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
                popup.info(
                  context: context,
                  title: "Info dialog",
                  message: "Toto je info dialog",
                );
              },
              child: const Text("Info dialog"),
            ),
            MaterialButton(
              height: 50,
              minWidth: 300,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              color: Colors.purpleAccent,
              textColor: Theme.of(context).colorScheme.background,
              onPressed: () {
                popup.question(
                  context: context,
                  title: "Question dialog",
                  message: "Toto je question dialog",
                  icon: const Icon(Icons.question_mark, color: Colors.purpleAccent, size: 70),
                  confirmButton: const PopupButton(label: "Yes", color: Colors.purpleAccent)
                );
              },
              child: const Text("Question dialog"),
            ),
          ],
        ),
      ),
    );
  }
}
