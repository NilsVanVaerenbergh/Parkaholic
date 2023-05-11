import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:src/components/button.dart';
import 'package:src/components/textField.dart';
import 'package:src/pages/addCar.dart';

class Cars extends StatefulWidget {
  Cars({super.key, required this.userData});

  QueryDocumentSnapshot userData;
  @override
  State<StatefulWidget> createState() => _Cars();
}

class _Cars extends State<Cars> {
  String errorMessage = "";
  @override
  Widget build(BuildContext context) {
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
            children: [
              const SizedBox(
                height: 50,
              ),
              Text(
                'Welkom ${widget.userData["name"]}',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(
                height: 50,
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
                      })
            ],
          ),
        ),
      ),
    );
  }
}
