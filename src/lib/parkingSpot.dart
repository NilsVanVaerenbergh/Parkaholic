// To parse this JSON data, do
//
//     final parkingSpot = parkingSpotFromJson(jsonString);

import 'dart:convert';

ParkingSpot parkingSpotFromJson(String str) => ParkingSpot.fromJson(json.decode(str));

String parkingSpotToJson(ParkingSpot data) => json.encode(data.toJson());

class ParkingSpot {
    // String id;
    bool inUse;
    double lat;
    double lng;
    int size;
    // String car;
    // int? timeOfLeaving;
    // int? leavingIn;

    ParkingSpot({
        // required this.id,
        required this.inUse,
        required this.lat,
        required this.lng,
        required this.size,
        // required this.car,
    });

    factory ParkingSpot.fromJson(Map<String, dynamic> json) => ParkingSpot(
        // id: json["id"],
        inUse: json["InUse"],
        lat: json["Lat"]?.toDouble(),
        lng: json["Lng"]?.toDouble(),
        size: json["Size"],
        // car: json["Car"],
    );

    Map<String, dynamic> toJson() => {
        // "id": id,
        "InUse": inUse,
        "Lat": lat,
        "Lng": lng,
        "Size": size,
        // "Car": car,
    };

    leaveParkingSpot(ParkingSpot parkingSpot){
      
    }
}
