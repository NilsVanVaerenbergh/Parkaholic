import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:src/components/button.dart';
import 'package:src/handlers/cars_handler.dart';
import 'package:src/handlers/cars_handler.dart';
import 'package:src/car.dart';
import 'dart:async';

class ReserveSpotStep2 extends StatefulWidget {
  ReserveSpotStep2({super.key, required this.userData, required this.listOfCars, required this.selectedCarId, required this.onCarSelected});

  final QueryDocumentSnapshot userData;
  final Future<List<Car>> listOfCars;
  String selectedCarId;
  final Function(String) onCarSelected;

  @override
  State<ReserveSpotStep2> createState() => _ReserveSpotStep2State();
}
class _ReserveSpotStep2State extends State<ReserveSpotStep2> {
  
  //!!!De init waarde van _dropdownValue moet aanwezig zijn in de lijst met keuzes van de dropdownbutton
  late String _dropdownValue;
  late List<Car> _carlist;
  @override
  void initState() {
    super.initState();
  } 

  //TODO nullcheck does op lijst van autos. Als null is text weergeven dat men auto moet toevoegen.
  @override
  Widget build(BuildContext context) {  
    return Container(
      child: Column(
        children: [
        Column(
          children:  [
            const Text(
              "Reserve this spot",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20,),

            const Text(
              "Select the car you want to park",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10,),

            FutureBuilder<List<Car>>(
              future: CarsHandler().fetchUserCars(widget.userData.id),
             builder: (BuildContext context, AsyncSnapshot<List<Car>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting){
                return CircularProgressIndicator();
              } else if (snapshot.hasError){
                return Text('Error: ${snapshot.error}');
              } else {
                _dropdownValue = snapshot.data!.first.id;
                return DropdownButton(
                  value: _dropdownValue,
                  onChanged: dropdownCallBack,
                  items: snapshot.data!
                      .map<DropdownMenuItem<String>>((Car item){
                        return DropdownMenuItem<String>(
                          value: item.id.toString(),
                          child: Text("${item.manufacturer.toString()} ${item.model.toString()}"),
                        );
                      }).toList(),
                );
              }
             }
            )
          ],
        ),
      ]),
    );
  }

  void dropdownCallBack(String? selectedValue){
    if(selectedValue is String){
      setState(() {
        widget.selectedCarId = selectedValue;
        print(widget.selectedCarId);
        widget.onCarSelected(widget.selectedCarId);
      });
    }
  }
}