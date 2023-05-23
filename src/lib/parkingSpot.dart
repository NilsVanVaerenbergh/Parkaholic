// To parse this JSON data, do
//
//     final parkingSpot = parkingSpotFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ParkingSpot parkingSpotFromJson(String str) =>
    ParkingSpot.fromJson(json.decode(str));

String parkingSpotToJson(ParkingSpot data) => json.encode(data.toJson());

class ParkingSpot {
  String id;
  bool inUse;
  double lat;
  double lng;
  int size;
  String carId;
  String address;
  int? timeOfLeaving;
  int? availableIn;
  String userId;

  ParkingSpot(
      {required this.id,
      required this.inUse,
      required this.lat,
      required this.lng,
      required this.size,
      required this.carId,
      required this.address,
      required this.userId,
      this.availableIn,
      this.timeOfLeaving});

  factory ParkingSpot.fromJson(Map<String, dynamic> json) => ParkingSpot(
      carId: json["car"],
      inUse: json["inUse"],
      lat: json["lat"]?.toDouble(),
      lng: json["lng"]?.toDouble(),
      size: json["size"],
      id: json["id"],
      address: json["address"],
      availableIn: json["availableIn"],
      timeOfLeaving: json["timeOfLeaving"],
      userId: json["userId"]);

  Map<String, dynamic> toJson() => {
        "car": carId,
        "inUse": inUse,
        "lat": lat,
        "lng": lng,
        "size": size,
        "id": id,
        "address": address,
        "availableIn": availableIn,
        "timeOfLeaving": timeOfLeaving,
        "userId": userId,
      };

  void leaveParkingSpot(int leavingIn) {
    int timeOfLeavingEpoch =
        DateTime.now().add(Duration(minutes: leavingIn)).microsecondsSinceEpoch;
    DocumentReference parkingSpotDoc =
        FirebaseFirestore.instance.collection("ParkingSpots").doc(id);
    parkingSpotDoc.update({
      "inUse": false,
      "availableIn": timeOfLeavingEpoch,
      "timeOfLeaving": DateTime.now().microsecondsSinceEpoch,
    });
  }

  void reserveParkingSpot(String NewCarId, String newUserId) {
    DocumentReference parkingSpotDoc =
        FirebaseFirestore.instance.collection("ParkingSpots").doc(id);
    parkingSpotDoc.update({
      "inUse": true,
      "car": NewCarId,
      "userId": newUserId,
    });
  }
}
