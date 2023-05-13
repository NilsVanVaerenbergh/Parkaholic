import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:src/components/button.dart';
import 'package:src/components/textField.dart';
import 'package:src/handlers/car_color.dart';
import 'package:src/handlers/cars_handler.dart';

class AddCar extends StatefulWidget {
  AddCar({super.key, required this.userData});
  QueryDocumentSnapshot userData;
  String dropDownValue = "BMW";
  String colorDropDownValue = "black";
  @override
  State<StatefulWidget> createState() => _AddCar();
}

class _AddCar extends State<AddCar> {
  List<String> manufacturersList = [];
  final carModelController = TextEditingController();

  CarColor defaultColor = CarColor.black;
  @override
  Widget build(BuildContext context) {
    CarsHandler().listManufacturers().then((list) => {
          if (manufacturersList != List<String>.from(list))
            {
              setState(() => {manufacturersList = List<String>.from(list)})
            }
        });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Voeg een nieuwe auto toe"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.2,
              100.0,
              MediaQuery.of(context).size.width * 0.2,
              100.0), // <-- Add some padding
          child: Column(
            children: [
              const SizedBox(
                height: 50,
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
                },
              ),
              const SizedBox(
                height: 50,
              ),
              MyTextField(
                  controller: carModelController,
                  hintText: "Model",
                  obscureText: false),
              const SizedBox(
                height: 50,
              ),
              DropdownButton(
                items: defaultColor.asList,
                icon: const Icon(Icons.arrow_downward),
                isExpanded: true,
                value: widget.colorDropDownValue,
                hint: const Text("Kies je merk"),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    widget.colorDropDownValue = value!;
                  });
                },
              ),
              const SizedBox(
                height: 50,
              ),
              MyButton(onTap: () => {}, button_text: "Voeg auto toe")
            ],
          ),
        ),
      ),
    );
  }
}
