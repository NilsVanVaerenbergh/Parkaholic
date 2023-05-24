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
  
  String leavingString = "";

  @override
  void initState() {
     super.initState();
    DateTime leavingDate = DateTime.fromMicrosecondsSinceEpoch(widget.leavingIn);
    leavingString = "${twoDigits(leavingDate.day)}/${twoDigits(leavingDate.month)}/${leavingDate.year} ${twoDigits(leavingDate.hour)}:${twoDigits(leavingDate.minute)}";
  }
  
  String twoDigits(int n) {
    if (n >= 10) {
      return "$n";
    }
    return "0$n";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20,),
        Text(
          "Drive safe!",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20,),
        Container(
          padding: EdgeInsets.all(25),
          margin: EdgeInsets.symmetric(horizontal: 50),
          child: Center(
            child: Text.rich(
              TextSpan(
                text: "You will be leaving on ",
                style: TextStyle(fontSize: 15),
                children: <TextSpan>[
                  TextSpan(
                    text: leavingString,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )
                ]
              ),
            ),
          ),
        ),
        const SizedBox(height: 20,),
      ],
    );
  }
}