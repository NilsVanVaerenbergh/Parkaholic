import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum CarColor {
  blue,
  red,
  white,
  grey,
  black,
  green,
}

extension CarColorHandler on CarColor {
  /*
    baseReferencePath verwijst naar de collectie in firestore.

    pathReference kan gecalled worden op een variabele met type CarColor. 
    Dit geeft ons dan de volledige path reference terug als string om mee op te slaan in firestore. (./cars_handler.dart)
  */
  String get name {
    switch (this) {
      case CarColor.black:
        return "Black";
      case CarColor.grey:
        return "Grey";
      case CarColor.blue:
        return "Blue";
      case CarColor.red:
        return "Red";
      case CarColor.white:
        return "White";
      case CarColor.green:
        return "Green";
      default:
        return "Black";
    }
  }
}

extension CarColorList on CarColor {
  List<DropdownMenuItem<String>> get asList {
    return CarColor.values.map<DropdownMenuItem<String>>((value) {
      return DropdownMenuItem<String>(
          value: value.name, child: Text(value.name));
    }).toList();
  }
}

// Dit is nodig om een nieuwe DropDownMenuItem in add_car.dart te creeëren.
// Omdat onchange bij een dropdown alleen de value terug geeft en niet heel de Item....
class StupidFixForFlutterBeingDumb {
  String nameFromReference(String reference) {
    switch (reference) {
      case "Options/Car/Colors/black":
        return "black";
      case "Options/Car/Colors/grey":
        return "grey";
      case "Options/Car/Colors/blue":
        return "blue";
      case "Options/Car/Colors/red":
        return "red";
      case "Options/Car/Colors/white":
        return "white";
      default:
        return "black";
    }
  }
}
