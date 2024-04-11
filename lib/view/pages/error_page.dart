import 'package:flutter/material.dart';
import 'package:flutter_project_skeleton/core/i18n/translations.g.dart';
import 'package:flutter_project_skeleton/view/layouts/default_layout.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({
    required this.title,
    required this.description,
    this.errorDetails,
    super.key,
  });

  final String title;
  final String description;
  final String? errorDetails;

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  bool showDetails = false;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: context.t.app.errorPage.title,
      padding: const EdgeInsets.all(20),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.description,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          if (widget.errorDetails != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                ExpansionPanelList(
                  elevation: 0,
                  expandedHeaderPadding: EdgeInsets.zero,
                  expandIconColor: Colors.green,
                  animationDuration: const Duration(milliseconds: 300),
                  children: [
                    ExpansionPanel(
                      canTapOnHeader: true,
                      isExpanded: showDetails,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 2),
                          child: Text(
                            context.t.app.errorPage.showMoreInfo,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.green,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.green,
                            ),
                          ),
                        );
                      },
                      body: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                          child: Text(
                            widget.errorDetails!,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() => showDetails = !showDetails);
                  },
                )
              ],
            ),
          const Spacer(),
        ],
      ),
    );
  }
}
