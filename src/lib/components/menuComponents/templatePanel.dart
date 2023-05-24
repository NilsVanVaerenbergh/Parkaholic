import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:src/components/button.dart';
import 'package:src/components/menuComponents/addParkingSpot.dart';
import 'package:src/components/menuComponents/reserveSpot/reserveSpotStep1.dart';
import 'package:src/components/menuComponents/reserveSpot/reserveSpotStep2.dart';
import 'package:src/components/menuComponents/reserveSpot/reserveSpotStep2AddCar.dart';
import 'package:src/components/menuComponents/reserveSpot/reserveSpotStep3.dart';
import 'package:src/components/menuComponents/leaveSpot/leaveSpotStep1.dart';
import 'package:src/components/menuComponents/leaveSpot/leaveSpotStep2.dart';
import 'package:src/main.dart';
import 'package:src/parkingSpot.dart';
import 'dart:async';
import 'package:src/car.dart';
import 'package:src/handlers/cars_handler.dart';

class TemplatePanel extends StatefulWidget {
  TemplatePanel({
    super.key,
    required this.selectedParkingSpot,
    required this.panelController,
    required this.userData,
  });

  final QueryDocumentSnapshot userData;
  final PanelController panelController;
  ParkingSpot? selectedParkingSpot;
  Widget initContent = const Text("home");

  set context(Widget inContect) {
    initContent = inContect;
  }

  @override
  State<TemplatePanel> createState() => _TemplatePanelState();
}

class _TemplatePanelState extends State<TemplatePanel> {
  Timer? timer;
  String _button_text = "Confirm";
  late Widget _currentContent = widget.initContent;
  int leavingIn = 0;
  final timeInputController = TextEditingController();
  TextEditingController parkingSpotSizeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  late Future<List<Car>> listOfCars;
  late String selectedCarId = "";
  late String previousCarId;
  DateTime leavingDate = DateTime.now();

  void handleCarSelected(String carId) {
    setState(() {
      selectedCarId = carId;
    });
  }

  void handleDateSelected(DateTime date) {
    setState(() {
      leavingDate = date;
      print(leavingDate);
      print(leavingDate.microsecondsSinceEpoch);
    });
  }

  @override
  void initState() {
    setState(() {
      listOfCars = CarsHandler().fetchUserCars(widget.userData.id.toString());
    });
    super.initState();
    updateCurrentContent();
    // timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    //   if (_currentContent is ReserveSpotStep2 && mounted) {
    //     setState(() {
    //       listOfCars =
    //           CarsHandler().fetchUserCars(widget.userData.id.toString());
    //     });
    //   }
    // });
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
    setState(() {
      listOfCars = CarsHandler().fetchUserCars(widget.userData.id.toString());
    });
    return Column(
      children: [
        _currentContent,
        MyButton(
          onTap: () {
            setState(() {
              if (_currentContent is ReserveSpotStep1) {
                listOfCars.then((List<Car> list) {
                  if (list.isEmpty) {
                    _currentContent = ReserveSpotStep2AddCar(
                      userData: widget.userData,
                      onCarSelected: handleCarSelected,
                      selectedCarId: selectedCarId,
                    );
                    _button_text = "Reserve";
                  } else {
                    _currentContent = ReserveSpotStep2(
                      userData: widget.userData,
                      listOfCars: listOfCars,
                      selectedCarId: selectedCarId,
                      onCarSelected: handleCarSelected,
                    );
                    _button_text = "Reserve";
                  }
                });
              } else if (_currentContent is ReserveSpotStep2 ||
                  _currentContent is ReserveSpotStep2AddCar) {
                previousCarId = widget.selectedParkingSpot!.car;
                widget.selectedParkingSpot!
                    .reserveParkingSpot(selectedCarId, widget.userData.id);
                _currentContent = ReserveSpotStep3(
                  carId: previousCarId,
                );
                _button_text = "Awesome!";
              } else if (_currentContent is ReserveSpotStep3) {
                _currentContent = const Text("Click on a marker");
                widget.panelController.close();
              } else if (_currentContent is LeaveSpotStep1) {
                leavingIn = leavingDate.microsecondsSinceEpoch;
                if (widget.selectedParkingSpot != null) {
                  widget.selectedParkingSpot!.leaveParkingSpot(leavingIn);
                }
                _currentContent = LeaveSpotStep2(
                  leavingIn: leavingIn,
                );
              } else if (_currentContent is LeaveSpotStep2) {
                _currentContent = const Text("Click on a marker");
                widget.panelController.close();
              } else if (_currentContent is AddParkingSpot) {
                widget.panelController.close();
                final doc =
                    FirebaseFirestore.instance.collection("ParkingSpots").doc();
                positionHandler.getCurrentLocation();
                doc.set({
                  "car": "0",
                  "inUse": true,
                  "lat": positionHandler.location.latitude,
                  "lng": positionHandler.location.longitude,
                  "size": parkingSpotSizeController.text == ""
                      ? "medium"
                      : parkingSpotSizeController.text,
                  "id": doc.id,
                  "address": addressController.text,
                  "availableIn": 0,
                  "timeOfLeaving": 0,
                  "userId": widget.userData.id,
                });
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
        _button_text = "Leave";
        _currentContent = LeaveSpotStep1(
          leavingDate: leavingDate,
          onTimeSelected: handleDateSelected,
        );
      } else {
        _button_text = "Reserve";
        _currentContent = ReserveSpotStep1(
          selectedParkingSpot: widget.selectedParkingSpot,
        );
      }
    } else {
      _button_text = "Create";
      _currentContent = AddParkingSpot(
        userData: widget.userData,
        dropDownController: parkingSpotSizeController,
        addressController: addressController,
      );
    }
  }
}
