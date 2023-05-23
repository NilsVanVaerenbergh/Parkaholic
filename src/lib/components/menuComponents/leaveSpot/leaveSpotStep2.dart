import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LeaveSpotStep2 extends StatefulWidget {
  const LeaveSpotStep2({super.key, required this.leavingIn});

  final int leavingIn;

  @override
  State<LeaveSpotStep2> createState() => _LeaveSpotStep2State();
}

class _LeaveSpotStep2State extends State<LeaveSpotStep2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 25,),
        Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade400, borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.all(25),
          margin: EdgeInsets.symmetric(horizontal: 50),
          child: Center(
            child: Text.rich(
              TextSpan(
                text: "You will be leaving in ",
                style: TextStyle(fontSize: 15),
                children: <TextSpan>[
                  TextSpan(
                    text: widget.leavingIn.toString() + " minutes",
                    style: TextStyle(fontSize: 15),
                  )
                ]
              ),
            ),
          ),
        ),
        const SizedBox(height: 25,),
      ],
    );
  }
}