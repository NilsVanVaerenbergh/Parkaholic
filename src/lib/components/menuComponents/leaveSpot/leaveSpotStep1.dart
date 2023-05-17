import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:src/components/textField.dart';

class LeaveSpotStep1 extends StatefulWidget {
  const LeaveSpotStep1({super.key,required this.timeInputController});

  final TextEditingController timeInputController;

  @override
  State<LeaveSpotStep1> createState() => _LeaveSpotStep1State();
}



class _LeaveSpotStep1State extends State<LeaveSpotStep1> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children:  [
        const Text(
              "Leave this spot",
              style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
              ),
        const Text(
              "Leaving in",
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              ),
        // MyTextField(controller: widget.timeInputController, hintText: "Time", obscureText: false),
        TextField(
          keyboardType: TextInputType.number,
          controller: widget.timeInputController,
          decoration: InputDecoration(
            hintText: "Time"
          ),
          )
      ],
    );
  }
}