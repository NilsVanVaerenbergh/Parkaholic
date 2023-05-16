import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:src/handlers/position.dart';
import 'package:src/components/slide_up_menu.dart';
import 'package:latlong2/latlong.dart';
import 'package:src/parkingSpot.dart';

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
          child: const Icon(
            Icons.directions_car_filled,
            color: Colors.blue,
          )),
    );
  }

  List<Marker> parkingSpotMarkers(
      List<ParkingSpot> parkingSpots, PanelController panelController, Function(ParkingSpot) onMarkerTap) {
    return parkingSpots
        .map((parkingSpot) => Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(parkingSpot.lat, parkingSpot.lng),
              builder: (ctx) => GestureDetector(
                  //adv parkingSpot.inUse meegeven of men reserveSpot of leaveSpot mee moet geven
                  onTap: ()  {
                    panelController.open();
                    onMarkerTap(parkingSpot);
                    },
                  child: Icon(
                    Icons.local_parking,
                    size: 60,
                    color: parkingSpot.inUse ? Colors.red : Colors.green,
                  )),
            ))
        .toList();
  }
}
