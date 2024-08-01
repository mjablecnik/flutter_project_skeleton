import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project_skeleton/core/app/popup.dart';

class BackButtonHandler extends StatefulWidget {
  const BackButtonHandler({super.key, required this.child, this.onBack});

  final Function()? onBack;
  final Widget child;

  @override
  State<BackButtonHandler> createState() => _BackButtonHandlerState();
}

class _BackButtonHandlerState extends State<BackButtonHandler> {

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) return;
        if (Navigator.of(context).canPop()) {
          widget.onBack?.call();
          Navigator.of(context).pop(true);
        } else {
          final bool shouldPop = await Popup.showCloseDialog(context);
          if (shouldPop) {
            SystemNavigator.pop();
          }
        }
      },
      child: widget.child,
    );
  }
}
