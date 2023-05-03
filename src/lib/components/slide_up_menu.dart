import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class slide_up_menu extends StatefulWidget {
  const slide_up_menu({
    Key? key,
    required this.controller,
    required this.panelController,
    });

  final ScrollController controller;
  final PanelController panelController;

  @override
  State<slide_up_menu> createState() => _slide_up_menuState();
}

class _slide_up_menuState extends State<slide_up_menu> {

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
          const Center(child: Text("This is the sliding Widget")),
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
  void togglePanel(){
      if(widget.panelController.isPanelOpen){
        widget.panelController.close();
      }
      else{
        widget.panelController.open();
      }
    
  }
}