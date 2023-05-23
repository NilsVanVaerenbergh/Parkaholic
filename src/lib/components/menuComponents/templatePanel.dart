import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:src/components/button.dart';
import 'package:src/components/menuComponents/reserveSpot/reserveSpotStep1.dart';
import 'package:src/components/menuComponents/reserveSpot/reserveSpotStep2.dart';
import 'package:src/components/menuComponents/reserveSpot/reserveSpotStep3.dart';
import 'package:src/components/menuComponents/leaveSpot/leaveSpotStep1.dart';
import 'package:src/components/menuComponents/leaveSpot/leaveSpotStep2.dart';
import 'package:src/parkingSpot.dart';
import 'dart:async';
import 'package:src/car.dart';
import 'package:src/handlers/cars_handler.dart';

class TemplatePanel extends StatefulWidget {
  const TemplatePanel({super.key, required this.selectedParkingSpot, required this.panelController, required this.userData});

  final QueryDocumentSnapshot userData;
  final PanelController panelController;
  final ParkingSpot? selectedParkingSpot;

  @override
  State<TemplatePanel> createState() => _TemplatePanelState();
}
    
class _TemplatePanelState extends State<TemplatePanel> {
  
  Timer? timer;
  String _button_text = "Confirm";
  late Widget _currentContent;
  int leavingIn = 0;
  final timeInputController = TextEditingController();
  late Future<List<Car>> listOfCars;
  late String selectedCarId = "";
  String? previousCarReference;
  
  void handleCarSelected(String carId) {
    setState(() {
      selectedCarId = carId;
    });
  }

  @override
  void initState() {
    super.initState();
    updateCurrentContent();
    listOfCars = CarsHandler().fetchUserCars(widget.userData.id);
  }

  @override
  void didUpdateWidget(TemplatePanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedParkingSpot != oldWidget.selectedParkingSpot) {
      updateCurrentContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        _currentContent,
      MyButton(
        onTap: (){
          setState(() {
            if (_currentContent is ReserveSpotStep1) {
              listOfCars.then((List<Car> list) {
                if (list.isEmpty){
                  _currentContent = const Text("U heeft nog geen auto op dit accout. Klik rechtsboven op het account icon om auto's toe te voegen.");
                } else {  
                  _currentContent = ReserveSpotStep2(userData: widget.userData,listOfCars: listOfCars,selectedCarId:selectedCarId,onCarSelected: handleCarSelected,);
                _button_text = "Reserve";
                }
                });
              }
               else if (_currentContent is ReserveSpotStep2) {
                previousCarReference = widget.selectedParkingSpot!.carId;
                widget.selectedParkingSpot!.reserveParkingSpot(selectedCarId, widget.userData.id);
                _currentContent = ReserveSpotStep3();
                _button_text = "Awsome!";
              }
               else if(_currentContent is ReserveSpotStep3){
                _currentContent = Text("Klik op een marker");
                widget.panelController.close();
              }
              else if(_currentContent is LeaveSpotStep1){
                leavingIn = int.parse(timeInputController.text);
                if (widget.selectedParkingSpot != null) {
                  widget.selectedParkingSpot!.leaveParkingSpot(leavingIn);
                 }
                timeInputController.text = "";
                _currentContent = LeaveSpotStep2(leavingIn: leavingIn,);
              }
               else if(_currentContent is LeaveSpotStep2){
                _currentContent = Text("Klik op een marker");
                widget.panelController.close();
              } 
              
          });
        },
        button_text: _button_text,
        )
      ],
      
    );
  }

  void updateCurrentContent() {
    if (widget.selectedParkingSpot != null) {
      if (widget.selectedParkingSpot!.inUse == true) {
        _currentContent = LeaveSpotStep1(timeInputController: timeInputController,);
      } else {
        _currentContent = ReserveSpotStep1(selectedParkingSpot: widget.selectedParkingSpot,);
      }
    } else {
      _currentContent = Text("Klik op een marker");
    }
  }
}
