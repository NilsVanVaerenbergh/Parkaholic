import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:src/handlers/position.dart';
import 'package:latlong2/latlong.dart';
import 'package:src/ParkingSpot.dart';

class Markers {
  Marker currentUserLocation(PositionHandler pos) {
    return Marker(
      width: 80.0,
      height: 80.0,
      point: pos.location,
      builder: (ctx) => GestureDetector(
          onTap: () {
            print('test');
          },
          child: Icon(
            Icons.directions_car_filled,
            color: Colors.blue,
          )),
    );
  }

  // List<Marker> parkingSpotMarkers(List<ParkingSpot> parkingSpots) {
  //   return parkingSpots
  //       .map((parkingSpot) => Marker(
  //             width: 80.0,
  //             height: 80.0,
  //             point: LatLng(parkingSpot.location[0], parkingSpot.location[1]),
  //             builder: (ctx) => Icon(
  //               parkingSpot.inUse ? Icons.car_repair : Icons.local_parking,
  //               size: 60,
  //               color: parkingSpot.inUse ? Colors.red : Colors.green,
  //             ),
  //           ))
  //       .toList();
  // }
}
