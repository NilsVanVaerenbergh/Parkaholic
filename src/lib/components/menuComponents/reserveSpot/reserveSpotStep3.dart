import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
        const Text(
          "Confirmation",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
        ),
        const Text("The spot is yours!",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0)),
        const SizedBox(
          height: 20,
        ),
        const Text("This car used the spot before you."),
        const SizedBox(
          height: 20,
        ),
        FutureBuilder<Car?>(
          future: getPreviousCar(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong. No car info available");
            } else if (snapshot.hasData) {
              final car = snapshot.data;
              return car == null
                  ? const Center(child: Text('No car info'))
                  : buildCarInfo(car);
            } else {
              return const Text("Geen informatie over deze auto");
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
    String svgColor = car != null ? "${car.color}" : "Black";

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SvgPicture.asset(
          "${svgColor}_car.svg",
          semanticsLabel: "Car",
          width: 150,
          height: 150,
        ),
        Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              const Text(
                "Model: ",
                style: TextStyle(fontSize: 16.0),
              ),
              Text("${car!.manufacturer} ${car.model}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16.0))
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              const Text("Color: ", style: TextStyle(fontSize: 16.0)),
              Text(car.color.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16.0))
            ]),
          ],
        )
      ],
    );
  }
}
