import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_project_skeleton/view/widgets/loader.dart';

class Reloader extends StatefulWidget {
  const Reloader({
    super.key,
    required this.scrollController,
    required this.child,
    required this.onReload,
  });

  final Widget child;
  final Function() onReload;
  final ScrollController scrollController;

  @override
  State<Reloader> createState() => _ReloaderState();
}

class _ReloaderState extends State<Reloader> {
  double? startPositionY;
  double? startPositionX;
  bool reload = false;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 11,
      children: [
        if (reload) const Loader(size: 24, padding: EdgeInsets.only(top: 12), strokeWidth: 2.5),
        Listener(
          onPointerDown: (PointerDownEvent event) => setState(() {
            startPositionX = event.position.dx;
            startPositionY = event.position.dy;
          }),
          onPointerUp: (PointerUpEvent event) {
            //print("$startPositionY < ${event.position.dy}");
            //print("$startPositionX > ${event.position.dx} - 50");
            //print("$startPositionX < ${event.position.dx} + 50");

            if (startPositionY! < event.position.dy &&
                startPositionX! > (event.position.dx - 50) &&
                startPositionX! < (event.position.dx + 50) &&
                widget.scrollController.offset == 0) {
              setState(() => reload = true);
              Timer(const Duration(seconds: 1), () async {
                setState(() => reload = false);
                await widget.onReload.call();
              });
            }
          },
          child: widget.child,
        ),
      ],
    );
  }
}
