// To parse this JSON data, do
//
//     final parkingSpot = parkingSpotFromJson(jsonString);

import 'dart:convert';

ParkingSpot parkingSpotFromJson(String str) => ParkingSpot.fromJson(json.decode(str));

String parkingSpotToJson(ParkingSpot data) => json.encode(data.toJson());

class ParkingSpot {
    bool inUse;
    double lat;
    double lng;
    int size;

    ParkingSpot({
        required this.inUse,
        required this.lat,
        required this.lng,
        required this.size,
    });

    factory ParkingSpot.fromJson(Map<String, dynamic> json) => ParkingSpot(
        inUse: json["InUse"],
        lat: json["Lat"]?.toDouble(),
        lng: json["Lng"]?.toDouble(),
        size: json["Size"],
    );

    Map<String, dynamic> toJson() => {
        "InUse": inUse,
        "Lat": lat,
        "Lng": lng,
        "Size": size,
    };
}
