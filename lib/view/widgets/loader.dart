import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({
    super.key,
    this.padding = const EdgeInsets.all(40.0),
    this.size,
    this.strokeWidth,
  });

  final EdgeInsets padding;
  final double? size;
  final double? strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding,
        child: SizedBox(
          height: size,
          width: size,
          child: CircularProgressIndicator(
            strokeWidth: strokeWidth ?? 4.0,
          ),
        ),
      ),
    );
  }
}
