import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:src/components/textField.dart';

class AddParkingSpot extends StatefulWidget {
  const AddParkingSpot(
      {super.key,
      required this.userData,
      required this.dropDownController,
      required this.addressController});

  final QueryDocumentSnapshot userData;
  final TextEditingController dropDownController;
  final TextEditingController addressController;

  @override
  State<AddParkingSpot> createState() => _AddParkingSpotState();
}

class _AddParkingSpotState extends State<AddParkingSpot> {
  List<String> sizes = ["large", "medium", "small"];
  String dropdownValue = "large";
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const Text(
              "Create a parking spot",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButton(
              items: sizes.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                    value: value, child: Text(value));
              }).toList(),
              icon: const Icon(Icons.arrow_downward),
              isExpanded: true,
              value: dropdownValue,
              hint: const Text("Kies je merk"),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  dropdownValue = value!;
                  widget.dropDownController.text = value;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
                controller: widget.addressController,
                hintText: "What is the address you are at right now?",
                obscureText: false)
          ],
        ));
  }
}
