import 'package:flutter/material.dart';

class ModalLayout extends StatelessWidget {
  const ModalLayout({
    super.key,
    required this.title,
    required this.body,
    this.backButtonText,
    this.maxWidth,
    this.padding = EdgeInsets.zero,
    this.isScrollable = false,
  });

  final Widget body;
  final String? backButtonText;
  final double? maxWidth;
  final String title;
  final EdgeInsetsGeometry padding;
  final bool isScrollable;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: padding,
        child: ListView(
          physics: isScrollable ? const ScrollPhysics() : const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            body,
          ],
        ),
      ),
    );
  }
}
