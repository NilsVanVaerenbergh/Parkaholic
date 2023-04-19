import 'package:flutter/material.dart';
import 'package:src/handlers/position.dart';
import 'pull_up_menu.dart';

class AppIcons {
  Positioned park(BuildContext inContext) {
    return Positioned(
        bottom: 80.0,
        right: 20.0,
        child: FloatingActionButton(
          onPressed: () {
            pullUpMenu(inContext);
          },
          child: const Icon(Icons.local_parking),
        ));
  }

  Positioned centerPosition(PositionHandler pos) {
    return Positioned(
      bottom: 20.0,
      right: 20.0,
      child: FloatingActionButton(
        onPressed: () {
          pos.updateMapCenter = true;
        },
        child: const Icon(Icons.adjust),
      ),
    );
  }
}
