import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:src/car.dart';
import 'package:src/handlers/car_color.dart';
import 'package:uuid/uuid.dart';

class CarsHandler {
  addCarToUser(String userId, String manufacturer, String model, String color) {
    // Generate ID
    String generatedCarId = const Uuid().v4();
    DocumentReference carDoc =
        FirebaseFirestore.instance.collection("Cars").doc(generatedCarId);
    DocumentReference userReference =
        FirebaseFirestore.instance.collection("Users").doc(userId);
    DocumentReference colorReference =
        FirebaseFirestore.instance.collection("Options/Car/Colors/").doc(color);
    Map<String, dynamic> data = {
      "id": generatedCarId,
      "user": userReference,
      "manufacturer": manufacturer,
      "model": model,
      "color": colorReference
    };
    carDoc.set(data);
  }

  Future<List<dynamic>> listManufacturers() async {
    DocumentReference manufacturersDoc =
        FirebaseFirestore.instance.collection("Options").doc("Manufacturer");
    List<dynamic> manufacturerList = [];
    await manufacturersDoc
        .get()
        .then((doc) => {manufacturerList = doc["names"]});
    return manufacturerList;
  }

  Future<List<Car>> fetchUserCars(String userId) async {
    DocumentReference userReference =
        FirebaseFirestore.instance.collection('Users').doc(userId);
    final cars = await FirebaseFirestore.instance
        .collection("Cars")
        .where("user", isEqualTo: userReference)
        .get();
    return await carsQueryToList(cars);
  }

  Future<List<Car>> carsQueryToList(
      QuerySnapshot<Map<String, dynamic>> cars) async {
    final list = cars.docs.map((e) => Car.fromJson(e.data())).toList();
    return list;
  }
}
