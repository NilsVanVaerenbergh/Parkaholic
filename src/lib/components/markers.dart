import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:src/handlers/position.dart';
import 'package:src/components/pull_up_menu.dart';
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

  List<Marker> parkingSpotMarkers(List<ParkingSpot> parkingSpots) {
    return parkingSpots
        .map((parkingSpot) => Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(parkingSpot.lat, parkingSpot.lng),
              builder: (ctx) => GestureDetector(
                onTap: () => pullUpMenu(ctx),
                child: Icon(
                  Icons.local_parking,
                  size: 60,
                  color: parkingSpot.inUse ? Colors.red : Colors.green,
              )),
            ))
        .toList();
  }
}