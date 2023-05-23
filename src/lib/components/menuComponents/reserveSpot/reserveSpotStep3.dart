import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:src/car.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReserveSpotStep3 extends StatefulWidget {
  const ReserveSpotStep3({super.key, required this.carId});

  final String carId;

  @override
  State<ReserveSpotStep3> createState() => _ReserveSpotStep3State();
}

class _ReserveSpotStep3State extends State<ReserveSpotStep3> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Confirmation"),
        const Text("The spot is yours!"),
        SizedBox(
          height: 20,
        ),
        Text("This car used the spot before you."),
        FutureBuilder<Car?>(
          future: getPreviousCar(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong. No car info available");
            } else if (snapshot.hasData) {
              final car = snapshot.data;
              return car == null
                  ? Center(child: Text('No car info'))
                  : buildCarInfo(car);
            } else {
              return Text("Geen informatie over deze auto");
            }
          },
        )
      ],
    );
  }

  Future<Car?> getPreviousCar() async {
    final carDoc =
        FirebaseFirestore.instance.collection("Cars").doc(widget.carId);
    final snapshot = await carDoc.get();
    if (snapshot.exists) {
      return Car.fromJson(snapshot.data()!);
    }
  }

  Widget buildCarInfo(Car? car) {
    return Row(
      children: [
        SvgPicture.asset(
          "car.svg",
          semanticsLabel: "Car",
          width: 100,
          height: 100,
        ),
        Column(
          children: [
            Text("Model: ${car!.manufacturer} ${car.model}"),
            Text("Color: ${car.color}")
          ],
        )
      ],
    );
  }
}
