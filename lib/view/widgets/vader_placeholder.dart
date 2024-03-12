import 'package:flutter/material.dart';

class VaderPlaceholder extends StatelessWidget {
  const VaderPlaceholder({
    super.key,
    this.text,
    this.width,
    this.height,
  });

  final String? text;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Placeholder(
        strokeWidth: 1,
        child: Center(
          child: Text(
            text ?? "",
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
