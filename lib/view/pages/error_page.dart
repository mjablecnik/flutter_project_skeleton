import 'package:flutter/material.dart';
import 'package:flutter_project_skeleton/core/i18n/translations.g.dart';
import 'package:flutter_project_skeleton/core/theme/app.dart';
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
          Text(widget.title, style: context.appTheme.errorPage.titleText),
          const SizedBox(height: 16),
          Text(widget.description, style: context.appTheme.errorPage.descriptionText),
          if (widget.errorDetails != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                ExpansionPanelList(
                  elevation: 0,
                  expandedHeaderPadding: EdgeInsets.zero,
                  expandIconColor: context.appTheme.errorPage.detailTextButtonIcon,
                  animationDuration: const Duration(milliseconds: 300),
                  children: [
                    ExpansionPanel(
                      backgroundColor: context.appTheme.layout.backgroundColor,
                      canTapOnHeader: true,
                      isExpanded: showDetails,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 2),
                          child: Text(
                            context.t.app.errorPage.showMoreInfo,
                            textAlign: TextAlign.left,
                            style: context.appTheme.errorPage.detailTextButton,
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
                            style: context.appTheme.errorPage.detailText,
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
