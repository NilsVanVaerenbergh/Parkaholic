import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:crypt/crypt.dart';
import 'package:src/parkingSpot.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

class DataHandler {
  String hashPassword({required String password}) {
    debugPrint("ran String hashPassword({required String password})");
    String hash = Crypt.sha256(password, salt: 'intr0Mob1l3').hash;
    return hash;
  }

  Future createUser(
      {required String name, required String hashedPassword}) async {
    bool createAccount = await checkIfDocAlreadyExists(
        collectionPath: "Users", key: "name", userName: name);
    if (createAccount) {
      String generatedId = const Uuid().v4();
      DocumentReference docUser =
          FirebaseFirestore.instance.collection("Users").doc(generatedId);
      final user = {
        "id": generatedId,
        "name": name,
        "password": hashedPassword,
        "created-at": DateTime.now().millisecondsSinceEpoch
      };
      docUser.set(user);
      QuerySnapshot userData = await FirebaseFirestore.instance
          .collection("Users")
          .where("id", isEqualTo: generatedId)
          .limit(1)
          .get();
      return userData.docs.first;
    } else {
      throw "Deze gebruikersnaam is al in gebruik!";
    }
  }

  Future<bool> checkIfDocAlreadyExists(
      {required String collectionPath,
      required String key,
      required String userName}) async {
    debugPrint(
        "ran Future<bool> checkIfDocAlreadyExists({required String collectionPath,required String key,required String userName})");
    QuerySnapshot doc = await FirebaseFirestore.instance
        .collection(collectionPath)
        .where(key, isEqualTo: userName)
        .limit(1)
        .get();
    return doc.docs.isEmpty;
  }

  Future checkPassword(
      {required String name, required String hashedPassword}) async {
    bool accountExists = await checkIfDocAlreadyExists(
        collectionPath: "User", key: "name", userName: name);
    // returnt true als het empty is. daarom invert.

    // HERWERKEN!!!!!!!!!!!!!

    if (accountExists) {
      QuerySnapshot userDoc = await FirebaseFirestore.instance
          .collection("Users")
          .where("password", isEqualTo: hashedPassword)
          .where("name", isEqualTo: name)
          .limit(1)
          .get();
      if (userDoc.docs.isNotEmpty) {
        if (userDoc.docs.first.get("password") == hashedPassword) {
          return userDoc.docs.first;
        } else {
          throw "Foutief wachtwoord of gebruikersnaam!";
        }
      } else {
        throw "Geen gebruiker gevonden met deze naam.";
      }
    } else {
      throw "Er ging iets verkeerd! Probeer later opnieuw.";
    }
  }

  List<ParkingSpot> filterParkingSpots(
      List<ParkingSpot> inList, String filterOn) {
    // Verwijder elke parkeer spot die niet van een gebruiker is
    List<ParkingSpot> removedNonUserParkingSpots = List.from(inList);
    removedNonUserParkingSpots
        .removeWhere((element) => element.userId != filterOn);

    // Verwijder elke in gebruik parking spot.
    inList.removeWhere((element) => element.inUse != false);

    debugPrint([...inList, ...removedNonUserParkingSpots].toString());
    // Merge lists samen
    return [...inList, ...removedNonUserParkingSpots];
  }
}
