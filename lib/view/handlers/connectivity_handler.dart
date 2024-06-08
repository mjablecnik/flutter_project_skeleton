import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_project_skeleton/core/i18n/translations.g.dart';

class ConnectivityHandler extends StatelessWidget {
  const ConnectivityHandler({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: OfflineBuilder(
        connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child) {
          if (connectivity == ConnectivityResult.none) {
            return Stack(
              children: [
                Positioned(
                  top: 36,
                  left: 0,
                  right: 0,
                  height: MediaQuery.of(context).size.height - 36,
                  child: child,
                ),
                Column(
                  children: [
                    Container(
                      height: 24,
                      width: double.infinity,
                      color: Colors.orange,
                    ),
                    Container(
                      height: 36,
                      width: double.infinity,
                      color: Colors.orange.shade900,
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        context.t.app.offlineMode,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return child;
          }
        },
        child: child,
      ),
    );
  }
}
