import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:src/components/button.dart';
import 'package:src/components/menuComponents/reserveSpot/reserveSpotStep2.dart';
import 'package:src/parkingSpot.dart';

class ReserveSpotStep1 extends StatefulWidget {
  const ReserveSpotStep1({super.key, required this.selectedParkingSpot});

  final ParkingSpot? selectedParkingSpot;

  @override
  State<ReserveSpotStep1> createState() => _ReserveSpotStep1State();
}

class _ReserveSpotStep1State extends State<ReserveSpotStep1> {
  late int leavingInMinutes;
  Timer? timer;
  String leavingString = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTimeOfLeavingString();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      getTimeOfLeavingString();
    });
  }

  getTimeOfLeavingString() {
    int? leavingInMiliseconds = (widget.selectedParkingSpot!.availableIn! -
        DateTime.now().microsecondsSinceEpoch);
    if (leavingInMiliseconds > 0) {
      leavingInMinutes = (leavingInMiliseconds / (1000 * 1000 * 60)).ceil();
      setState(() {
        leavingString = leavingInMinutes.toString() + " minutes";
      });
    } else {
      setState(() {
        leavingString = "NOW";
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String determineCarSize() {
    return widget.selectedParkingSpot!.size;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Information",
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 20,
              ),
              Text.rich(TextSpan(
                  text: "Available in: ",
                  style: TextStyle(fontSize: 20),
                  children: <TextSpan>[
                    TextSpan(
                        text: leavingString,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))
                  ])),
              const SizedBox(
                height: 20,
              ),
              Text.rich(TextSpan(
                  text: "Parking spot size: ",
                  style: TextStyle(fontSize: 20),
                  children: <TextSpan>[
                    TextSpan(
                        text: determineCarSize(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))
                  ])),
              const SizedBox(
                height: 20,
              ),
              Text.rich(TextSpan(
                  text: "address: ",
                  style: TextStyle(fontSize: 20),
                  children: <TextSpan>[
                    TextSpan(
                        text: widget.selectedParkingSpot!.address,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))
                  ])),
              const SizedBox(
                height: 20,
              ),
            ],
          ),

          // SizedBox(
          //   child: MyButton(
          //   onTap: () {
          //     // widget.nextContent();
          //   },
          //   button_text: "Reserve",),
          //   width: 300,
          // )
        ],
      ),
    );
  }
}
