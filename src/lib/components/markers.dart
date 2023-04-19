import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:src/handlers/position.dart';

class Markers {
  Marker currentUserLocation(PositionHandler pos) {
    return Marker(
      width: 80.0,
      height: 80.0,
      point: pos.location,
      builder: (ctx) => const Icon(
        Icons.directions_car_filled,
        color: Colors.blue,
      ),
    );
  }
}
