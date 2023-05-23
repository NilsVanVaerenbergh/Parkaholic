import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:src/components/menuComponents/reserveSpot/reserveSpotStep2.dart';
import 'package:src/components/menuComponents/reserveSpot/reserveSpotStep1.dart';
import 'package:src/components/menuComponents/reserveSpot/reserveSpotStep3.dart';
import 'package:src/components/menuComponents/templatePanel.dart';
import 'package:src/parkingSpot.dart';

class slide_up_menu extends StatefulWidget {
  slide_up_menu({
    Key? key,
    required this.controller,
    required this.panelController,
    required this.selectedParkingSpot,
    required this.userData,
  });

  final QueryDocumentSnapshot userData;
  final ScrollController controller;
  final PanelController panelController;
  ParkingSpot? selectedParkingSpot;
  @override
  State<slide_up_menu> createState() => _slide_up_menuState();
}

class _slide_up_menuState extends State<slide_up_menu> {
  //https://stackoverflow.com/questions/51029655/call-method-in-one-stateful-widget-from-another-stateful-widget-flutter#:~:text=Calling%20a%20method%20of%20child,widget%20to%20update%20its%20children.

  @override
  Widget build(BuildContext context) => ListView(
        padding: EdgeInsets.zero,
        controller: widget.controller,
        children: <Widget>[
          const SizedBox(
            height: 12,
          ),
          buildDragHandle(),
          const SizedBox(
            height: 36,
          ),
          Center(
              child: TemplatePanel(
                  selectedParkingSpot: widget.selectedParkingSpot,
                  panelController: widget.panelController,
                  userData: widget.userData)),
          const SizedBox(
            height: 24,
          )
        ],
      );

  Widget buildDragHandle() => GestureDetector(
        onTap: togglePanel,
        child: Center(
          child: Container(
            width: 200,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      );
  void togglePanel() {
    widget.panelController.panelPosition.round() == 1
        ? widget.panelController.close()
        : widget.panelController.open();
  }
}
