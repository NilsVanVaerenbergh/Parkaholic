import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:src/components/button.dart';
import 'package:src/components/menuComponents/reserveSpot/reserveSpotStep1.dart';
import 'package:src/components/menuComponents/reserveSpot/reserveSpotStep2.dart';
import 'package:src/components/menuComponents/reserveSpot/reserveSpotStep2AddCar.dart';
import 'package:src/components/menuComponents/reserveSpot/reserveSpotStep3.dart';
import 'package:src/components/menuComponents/leaveSpot/leaveSpotStep1.dart';
import 'package:src/components/menuComponents/leaveSpot/leaveSpotStep2.dart';
import 'package:src/parkingSpot.dart';
import 'dart:async';
import 'package:src/car.dart';
import 'package:src/handlers/cars_handler.dart';

class TemplatePanel extends StatefulWidget {
  const TemplatePanel(
      {super.key,
      required this.selectedParkingSpot,
      required this.panelController,
      required this.userData});

  final QueryDocumentSnapshot userData;
  final PanelController panelController;
  final ParkingSpot? selectedParkingSpot;

  @override
  State<TemplatePanel> createState() => _TemplatePanelState();
}

class _TemplatePanelState extends State<TemplatePanel> {
  Timer? timer;
  String _button_text = "Confirm";
  late Widget _currentContent = const Text("Klik op een marker");
  int leavingIn = 0;
  final timeInputController = TextEditingController();
  late Future<List<Car>> listOfCars;
  late String selectedCarId = "";
  late String previousCarId;

  void handleCarSelected(String carId) {
    setState(() {
      selectedCarId = carId;
    });
  }

  @override
  void initState() {
    super.initState();
    updateCurrentContent();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          listOfCars =
              CarsHandler().fetchUserCars(widget.userData.id.toString());
        });
      }
    });
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
                previousCarId = widget.selectedParkingSpot!.carId;
                widget.selectedParkingSpot!
                    .reserveParkingSpot(selectedCarId, widget.userData.id);
                _currentContent = ReserveSpotStep3(
                  carId: previousCarId,
                );
                _button_text = "Awsome!";
              } else if (_currentContent is ReserveSpotStep3) {
                _currentContent = const Text("Klik op een marker");
                widget.panelController.close();
              } else if (_currentContent is LeaveSpotStep1) {
                leavingIn = int.parse(timeInputController.text);
                if (widget.selectedParkingSpot != null) {
                  widget.selectedParkingSpot!.leaveParkingSpot(leavingIn);
                }
                timeInputController.text = "";
                _currentContent = LeaveSpotStep2(
                  leavingIn: leavingIn,
                );
              } else if (_currentContent is LeaveSpotStep2) {
                _currentContent = const Text("Klik op een marker");
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
        _currentContent = LeaveSpotStep1(
          timeInputController: timeInputController,
        );
      } else {
        _currentContent = ReserveSpotStep1(
          selectedParkingSpot: widget.selectedParkingSpot,
        );
      }
    } else {
      _currentContent = const Text("Klik op een marker");
    }
  }
}
