import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class slide_up_menu extends StatelessWidget {
  const slide_up_menu({
    super.key,
    required this.controller,
    required this.panelController,
  });

  final ScrollController controller;
  final PanelController panelController;

  @override
  Widget build(BuildContext context) => ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 12,
          ),
          buildDragHandle(),
          SizedBox(
            height: 36,
          ),
          Center(child: Text("This is the sliding Widget")),
          SizedBox(
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
    if (panelController.isPanelOpen) {
      panelController.close();
    } else {
      panelController.open();
    }
  }

  //   return SlidingUpPanel(
  //         controller: controller,
  //         borderRadius: const BorderRadius.only(
  //           topLeft: Radius.circular(15),
  //           topRight: Radius.circular(15),
  //         ),
  //         panel: const Center(
  //           child: Text("This is the sliding Widget"),
  //         ),
  //         collapsed: Container(
  //           padding: const EdgeInsets.all(45.0),
  //           child: Container(
  //             decoration: BoxDecoration(
  //                 border: Border.all(
  //                     width: 1,
  //                     color: const Color.fromARGB(255, 170, 170, 170)),
  //                 borderRadius: const BorderRadius.all(Radius.circular(15))),
  //             height: 10.0,
  //             width: 50.0,
  //             child: Container(color: const Color.fromARGB(255, 170, 170, 170)),
  //           ),
  //         ),);
  // }
}

// void pullUpMenu(context) {
//   showModalBottomSheet(
//       context: context,
//       builder: (BuildContext bc) {
//         return SizedBox(
//             height: MediaQuery.of(context).size.height * .30,
//             child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         const Text("Klik om uw parkeerplaats vrij te geven"),
//                         IconButton(
//                           icon: const Icon(Icons.cancel),
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                         )
//                       ],
//                     )
//                   ],
//                 )
//               )
//             );
//         }
//       );
// }
