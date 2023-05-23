import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:src/components/button.dart';
import 'package:src/components/textField.dart';
import 'package:src/handlers/car_color.dart';
import 'package:src/handlers/cars_handler.dart';
import 'package:src/handlers/cars_handler.dart';
import 'package:src/car.dart';
import 'dart:async';

class ReserveSpotStep2AddCar extends StatefulWidget {
  ReserveSpotStep2AddCar({
    super.key,
    required this.userData,
    required this.selectedCarId,
    required this.onCarSelected,
  });

  final QueryDocumentSnapshot userData;
  String selectedCarId;
  final Function(String) onCarSelected;

  String dropDownValue = "BMW";
  DropdownMenuItem colorDropDownValue = DropdownMenuItem<String>(
      value: CarColor.black.name, child: Text(CarColor.black.name));
  String currentId = "0";

  @override
  State<ReserveSpotStep2AddCar> createState() => _ReserveSpotStep2AddCarState();
}

class _ReserveSpotStep2AddCarState extends State<ReserveSpotStep2AddCar> {
  List<String> manufacturersList = [];
  final carModelController = TextEditingController();
  CarColor defaultColor = CarColor.black;
  @override
  void initState() {
    super.initState();
    onChangeCreateCar(carModelController.text);
  }

  @override
  Widget build(BuildContext context) {
    CarsHandler().listManufacturers().then((list) => {
          if (manufacturersList != List<String>.from(list))
            {
              setState(() => {manufacturersList = List<String>.from(list)})
            }
        });
    return Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            DropdownButton(
              items: manufacturersList
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                    value: value, child: Text(value));
              }).toList(),
              icon: const Icon(Icons.arrow_downward),
              isExpanded: true,
              value: widget.dropDownValue,
              hint: const Text("Kies je merk"),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  widget.dropDownValue = value!;
                });
                onChangeCreateCar(carModelController.text);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
                controller: carModelController,
                hintText: "Model",
                obscureText: false),
            const SizedBox(
              height: 20,
            ),
            DropdownButton(
              items: defaultColor.asList,
              icon: const Icon(Icons.arrow_downward),
              isExpanded: true,
              value: widget.colorDropDownValue.value,
              hint: const Text("Kies je merk"),
              onChanged: (Object? value) {
                // This is called when the user selects an item.
                setState(() {
                  if (value != null) {
                    debugPrint(value.toString());
                    widget.colorDropDownValue = DropdownMenuItem(
                        value: value,
                        child: Text(StupidFixForFlutterBeingDumb()
                            .nameFromReference(value.toString())));
                  }
                });
                onChangeCreateCar(carModelController.text);
              },
            ),
          ],
        ));
  }

  void onChangeCreateCar(String model) {
    if (widget.currentId == "0") {
      widget.currentId = CarsHandler().addCarToUser(widget.userData.id,
          widget.dropDownValue, model, widget.colorDropDownValue.value);
      dropdownCallBack(widget.currentId);
    } else {
      final doc =
          FirebaseFirestore.instance.collection("Cars").doc(widget.currentId);
      doc.update({
        "manufacturer": widget.dropDownValue,
        "model": model,
        "color": widget.colorDropDownValue.value
      }).then((value) => dropdownCallBack(widget.currentId));
    }
  }

  void dropdownCallBack(String? selectedValue) {
    debugPrint("ran callback");
    if (selectedValue is String) {
      setState(() {
        widget.selectedCarId = selectedValue;
        widget.onCarSelected(widget.selectedCarId);
      });
    }
  }
}
