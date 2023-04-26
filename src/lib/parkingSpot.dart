// To parse this JSON data, do
//
//     final parkingSpot = parkingSpotFromJson(jsonString);

import 'dart:convert';

ParkingSpot parkingSpotFromJson(String str) =>
    ParkingSpot.fromJson(json.decode(str));

String parkingSpotToJson(ParkingSpot data) => json.encode(data.toJson());

class ParkingSpot {
  ParkingSpot({
    required this.id,
    required this.inUse,
    required this.location,
    required this.size,
  });

  String id;
  bool inUse;
  List<double> location;
  int size;

  factory ParkingSpot.fromJson(Map<String, dynamic> json) => ParkingSpot(
        id: json["id"],
        inUse: json["inUse"],
        location: List<double>.from(json["location"].map((x) => x?.toDouble())),
        size: json["Size"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "inUse": inUse,
        "location": List<dynamic>.from(location.map((x) => x)),
        "Size": size,
      };
}
