import 'package:flutter/material.dart';

enum CarColor {
  blue,
  red,
  white,
  grey,
  black,
}

extension CarColorHandler on CarColor {
  /*
    baseReferencePath verwijst naar de collectie in firestore.

    pathReference kan gecalled worden op een variabele met type CarColor. 
    Dit geeft ons dan de volledige path reference terug als string om mee op te slaan in firestore. (./cars_handler.dart)
  */
  static String baseReferencePath = "Options/Car/Colors/";
  String get pathReference {
    switch (this) {
      case CarColor.black:
        return baseReferencePath + "black";
      case CarColor.grey:
        return baseReferencePath + "grey";
      case CarColor.blue:
        return baseReferencePath + "blue";
      case CarColor.red:
        return baseReferencePath + "red";
      case CarColor.white:
        return baseReferencePath + "white";
      default:
        return baseReferencePath + "black";
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
