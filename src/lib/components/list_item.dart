import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../pages/cars.dart';

abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context, QueryDocumentSnapshot userData);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);
}

class CarItem implements ListItem {
  final String manufacturer;
  final String model;
  final String id;

  CarItem({required this.manufacturer, required this.model, required this.id});

  @override
  Widget buildTitle(BuildContext context, QueryDocumentSnapshot userData) {
    return Row(children: [
      Text(manufacturer),
      const Spacer(),
      IconButton(
          color: Colors.red,
          onPressed: () => {
                FirebaseFirestore.instance.collection("Cars").doc(id).delete(),
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Cars(
                              userData: userData,
                            ))),
              },
          icon: const Icon(Icons.remove_circle))
    ]);
  }

  @override
  Widget buildSubtitle(BuildContext context) {
    return Text(model);
  }
}
