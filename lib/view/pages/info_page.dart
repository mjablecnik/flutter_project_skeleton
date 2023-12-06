import 'package:flutter/material.dart';
import 'package:flutter_project_skeleton/core/i18n/translations.g.dart';
import 'package:flutter_project_skeleton/core/singletons/getter.dart';
import 'package:flutter_project_skeleton/view/layouts/default_layout.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: context.t.about.title,
      body: Table(
        border: TableBorder.all(),
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(),
          1: FlexColumnWidth(),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: <TableRow>[
          TableRow(
            children: <Widget>[
              TableCell(
                child: Container(
                  height: 24,
                  width: 32,
                  color: Colors.white,
                  child: Text("Jméno aplikace:", textAlign: TextAlign.center),
                ),
              ),
              TableCell(
                child: Container(
                  height: 24,
                  width: 32,
                  color: Colors.white,
                  child: Text(Get.cached.appName, textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
          TableRow(
            children: <Widget>[
              TableCell(
                child: Container(
                  height: 24,
                  width: 32,
                  color: Colors.white,
                  child: Text("Verze:", textAlign: TextAlign.center),
                ),
              ),
              TableCell(
                child: Container(
                  height: 24,
                  width: 32,
                  color: Colors.white,
                  child: Text(Get.cached.appVersion, textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
