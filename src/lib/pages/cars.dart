import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:src/car.dart';
import 'package:src/components/button.dart';
import 'package:src/components/list_item.dart';
import 'package:src/handlers/cars_handler.dart';
import 'package:src/pages/add_car.dart';

class Cars extends StatefulWidget {
  Cars({super.key, required this.userData});

  QueryDocumentSnapshot userData;
  @override
  State<StatefulWidget> createState() => _Cars();
}

class _Cars extends State<Cars> {
  String errorMessage = "";
  List<Car> carList = [];
  List<CarItem> carItemList = [];

  void createInitState() {
    debugPrint("ran void createInitState()");
    CarsHandler().fetchUserCars(widget.userData.id).then((value) => {
          setState(() => carList = value),
          if (carItemList.length < value.length)
            {
              value.forEach((element) {
                carItemList.add(CarItem(
                    manufacturer: element.manufacturer,
                    model: element.model,
                    id: element.id));
              })
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    if (carList.isEmpty && carItemList.isEmpty) {
      createInitState();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Auto's van ${widget.userData['name']}"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.2,
              100.0,
              MediaQuery.of(context).size.width * 0.2,
              100.0), // <-- Add some padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 50,
              ),
              Text(
                'Welkom ${widget.userData["name"]}',
                style: const TextStyle(fontSize: 20),
              ),
              MyButton(
                  button_text: "Voeg toe.",
                  onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddCar(
                                      userData: widget.userData,
                                    )))
                      }),
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(
                height: 50,
              ),
              Expanded(
                  child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 5);
                },
                itemCount: carItemList.length,
                itemBuilder: (context, index) {
                  final item = carItemList[index];
                  return ListTile(
                    title: item.buildTitle(context, widget.userData),
                    subtitle: item.buildSubtitle(context),
                  );
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
