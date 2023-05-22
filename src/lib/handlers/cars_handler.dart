import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:src/car.dart';
import 'package:uuid/uuid.dart';

class CarsHandler {
  addCarToUser(String userId, String manufacturer, String model, String color) {
    // Generate ID
    String generatedCarId = const Uuid().v4();
    //
    DocumentReference carDoc =
        FirebaseFirestore.instance.collection("Cars").doc(generatedCarId);
    DocumentReference userReference =
        FirebaseFirestore.instance.collection("Users").doc(userId);
    DocumentReference colorReference =
        FirebaseFirestore.instance.collection("Options/Car/Colors/").doc(color);
    var data = {
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
    final cars = await FirebaseFirestore.instance
        .collection("Cars")
        .where("user", isEqualTo: userId)
        .get();
    return await carsQueryToList(cars);
  }

  Future<List<Car>> carsQueryToList(
      QuerySnapshot<Map<String, dynamic>> cars) async {
    final list = cars.docs.map((e) => e.data() as Car).toList();
    return list;
  }
}
