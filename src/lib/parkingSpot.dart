// To parse this JSON data, do
//
//     final parkingSpot = parkingSpotFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ParkingSpot parkingSpotFromJson(String str) => ParkingSpot.fromJson(json.decode(str));

String parkingSpotToJson(ParkingSpot data) => json.encode(data.toJson());

class ParkingSpot {
    String id;
    bool inUse;
    double lat;
    double lng;
    int size;
    DocumentReference carId;
    String address;
    int? timeOfLeaving;
    int? availableIn;

    ParkingSpot({
        required this.id,
        required this.inUse,
        required this.lat,
        required this.lng,
        required this.size,
        required this.carId,
        required this.address,
        this.availableIn,
        this.timeOfLeaving
    });

    factory ParkingSpot.fromJson(Map<String, dynamic> json) => ParkingSpot(
        carId: json["car"],
        inUse: json["inUse"],
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
        size: json["size"],
        id: json["id"],
        address: json["address"],
        availableIn: json["availableIn"],
        timeOfLeaving: json["timeOfLeaving"]
    );

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
    };

    void leaveParkingSpot(int leavingIn) {
      DocumentReference docUser = FirebaseFirestore.instance.collection("ParkingSpots").doc(id);
        docUser.update({
          "inUse": false,
          "availableIn": leavingIn,
          "timeOfLeaving": DateTime.now().microsecondsSinceEpoch,
        }).then((_) {
        // Update completed
        print("Parking spot updated successfully.");
        }).catchError((error) {
        // Error occurred while updating
      print("Error updating parking spot: $error");
  });
}
}
