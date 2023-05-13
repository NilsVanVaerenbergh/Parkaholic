import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:src/handlers/car_color.dart';
import 'package:uuid/uuid.dart';

class CarsHandler {
  addCarToUser(
      String userId, String manufacturer, String model, CarColor color) {
    String generatedCarId = const Uuid().v4();
    //DocumentReference docUser = FirebaseFirestore.instance.collection("Cars")
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
}
