import 'dart:async';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:src/components/slide_up_menu.dart';
import 'package:src/pages/cars.dart';

import '../components/icons.dart';
import '../components/markers.dart';
import '../handlers/position.dart';

import 'package:src/ParkingSpot.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title, required this.userData});
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;
  QueryDocumentSnapshot userData;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PositionHandler positionHandler = PositionHandler();
  MapController mapController = MapController();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    positionHandler.checkLocationEnabled();
    debugPrint(widget.userData.data().toString());
    //zal center van map elke seconde naar currentlocation brengen.
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (positionHandler.updateMapCenter &&
            positionHandler.locationPermission) {
          positionHandler.getCurrentLocation();
          mapController.move(positionHandler.location, 17.0);
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  //geeft stream met list van alle parkingSpots
  Stream<List<ParkingSpot>> readParkingSpots() => FirebaseFirestore.instance
      .collection('ParkingSpots')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => ParkingSpot.fromJson(doc.data()))
          .toList());

  PanelController slideMenuController = new PanelController();

  //Volledige body is SlidingUpPanel?
  //TODO
  //Markers van firebase builden adhv streambuilder widget (zal live updates uitvoeren)
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       appBar: AppBar(
  //         title: Text(widget.title),
  //         shape: const RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //             bottomLeft: Radius.circular(15),
  //             bottomRight: Radius.circular(15),
  //           ),
  //         ),
  //       ),
  //       body: SlidingUpPanel(

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
  //         ),
  //         body: Stack(
  //           children: [
  //             FlutterMap(
  //               mapController: mapController,
  //               options: MapOptions(
  //                   center: positionHandler.location,
  //                   zoom: 17.0,
  //                   maxZoom: 17.0,
  //                   // enableScrollWheel: false,
  //                   // interactiveFlags: InteractiveFlag.none,
  //                   scrollWheelVelocity: 0.005,
  //                   onPositionChanged: ((position, hasGesture) =>
  //                       positionHandler.updateMapCenter = false)),
  //               children: [
  //                 TileLayer(
  //                   urlTemplate:
  //                       'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
  //                   subdomains: const ['a', 'b', 'c'],
  //                 ),
  //                 StreamBuilder<List<ParkingSpot>>(
  //               stream: readParkingSpots(),
  //               builder: (context, snapshot) {
  //                 if(snapshot.hasData){
  //                   final parkingSpots = snapshot.data!;
  //                   final markerList = Markers().parkingSpotMarkers(parkingSpots);
  //                   return MarkerLayer(
  //                     markers: markerList
  //                   );
  //                 }
  //                 else{
  //                   return MarkerLayer(
  //                   );
  //                 }
  //               },
  //             ),
  //                 MarkerLayer(
  //                   markers: [Markers().currentUserLocation(positionHandler)],
  //                 ),
  //               ],
  //             ),
  //             AppIcons().centerPosition(positionHandler)
  //           ],
  //         ),
  //       ));
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Cars(
                                    userData: widget.userData,
                                  )))
                    },
                icon: const Icon(Icons.account_circle_sharp))
          ],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
        ),
        body: SlidingUpPanel(
            controller: slideMenuController,
            minHeight: 25,
            borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
            body: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                  center: positionHandler.location,
                  zoom: 17.0,
                  maxZoom: 17.0,
                  // enableScrollWheel: false,
                  //interactiveFlags: InteractiveFlag.none,
                  scrollWheelVelocity: 0.005,
                  onPositionChanged: ((position, hasGesture) =>
                      positionHandler.updateMapCenter = false)),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                ),
                StreamBuilder<List<ParkingSpot>>(
                  stream: readParkingSpots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final parkingSpots = snapshot.data!;
                      final markerList = Markers().parkingSpotMarkers(
                          parkingSpots, slideMenuController);
                      return MarkerLayer(markers: markerList);
                    } else {
                      return MarkerLayer();
                    }
                  },
                ),
                MarkerLayer(
                  markers: [Markers().currentUserLocation(positionHandler)],
                ),
              ],
            ),
            // AppIcons().centerPosition(positionHandler),
            panelBuilder: (controller) => slide_up_menu(
                  controller: controller,
                  panelController: slideMenuController,
                )));
  }
}
