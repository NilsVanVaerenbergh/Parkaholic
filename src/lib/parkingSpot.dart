// To parse this JSON data, do
//
//     final parkingSpot = parkingSpotFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:src/main.dart';

ParkingSpot parkingSpotFromJson(String str) =>
    ParkingSpot.fromJson(json.decode(str));

String parkingSpotToJson(ParkingSpot data) => json.encode(data.toJson());

class ParkingSpot {
  String id;
  bool inUse;
  double lat;
  double lng;
  String size;
  String car;
  String address;
  int? timeOfLeaving;
  int availableIn;
  String userId;

  ParkingSpot(
      {required this.id,
      required this.inUse,
      required this.lat,
      required this.lng,
      required this.size,
      required this.car,
      required this.address,
      required this.userId,
      required this.availableIn,
      this.timeOfLeaving});

  factory ParkingSpot.fromJson(Map<String, dynamic> json) => ParkingSpot(
      car: json["car"],
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
        "car": car,
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
    DocumentReference parkingSpotDoc =
        FirebaseFirestore.instance.collection("ParkingSpots").doc(id);
    parkingSpotDoc.update({
      "inUse": false,
      "availableIn": leavingIn,
      "timeOfLeaving": DateTime.now().microsecondsSinceEpoch,
    });
  }

  void createParkingSpot(String size, String address, String userId) {
    final doc = FirebaseFirestore.instance.collection("ParkingSpots").doc();
    doc.set({
      "car": "0",
      "inUse": true,
      "lat": positionHandler.location.latitude,
      "lng": positionHandler.location.longitude,
      "size": size,
      "id": doc.id,
      "address": address,
      "availableIn": 0,
      "timeOfLeaving": 0,
      "userId": userId,
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
