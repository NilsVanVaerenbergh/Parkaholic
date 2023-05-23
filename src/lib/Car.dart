import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Car carFromJson(String str) => Car.fromJson(json.decode(str));

String carToJson(Car data) => json.encode(data.toJson());

class Car {
  String id;
  DocumentReference user;
  String manufacturer;
  String model;
  String color;

  Car({
    required this.id,
    required this.user,
    required this.manufacturer,
    required this.model,
    required this.color,
  });

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: json["id"],
        user: json["user"],
        manufacturer: json["manufacturer"],
        model: json["model"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "manufacturer": manufacturer,
        "model": model,
        "color": color,
      };
}
