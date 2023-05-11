import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CarsHandler {
  addCarToUser(String userId) {
    throw "Not Implemented yet";
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
