import 'package:flutter/material.dart';
import 'package:src/handlers/position.dart';

class AppIcons {
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
