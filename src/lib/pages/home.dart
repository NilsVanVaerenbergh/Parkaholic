import 'dart:async';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:src/components/slide_up_menu.dart';
import 'package:src/handlers/data_handler.dart';
import 'package:src/pages/cars.dart';

import '../components/icons.dart';
import '../components/markers.dart';
import '../handlers/position.dart';

import 'package:src/parkingSpot.dart';

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
  String routeName = "/home";
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PositionHandler positionHandler = PositionHandler();
  MapController mapController = MapController();
  Timer? timer;
  ParkingSpot? _selectedParkingSpot;
  LatLng location = LatLng(51.229838, 4.4171506);
  @override
  void initState() {
    super.initState();
    positionHandler.checkLocationEnabled();

    //zal center van map elke seconde naar currentlocation brengen.
    // timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    //   setState(() {
    //     if (positionHandler.updateMapCenter &&
    //         positionHandler.locationPermission) {
    //       positionHandler.getCurrentLocation();
    //       mapController.move(positionHandler.location, 17.0);
    //     }
    //   });
    // });
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

  void handleMarkerTap(ParkingSpot parkingSpot) {
    setState(() {
      _selectedParkingSpot = parkingSpot;
    });
  }

  PanelController slidePanelController = PanelController();
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
            controller: slidePanelController,
            minHeight: 25,
            borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
            body: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                  center: location,
                  zoom: 17.0,
                  maxZoom: 17.0,
                  // enableScrollWheel: false,
                  // interactiveFlags: InteractiveFlag.none,
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
                      debugPrint(snapshot.data!.toString());
                      final parkingSpots = DataHandler().filterParkingSpots(
                          snapshot.data!, widget.userData.id);
                      final markerList = Markers().parkingSpotMarkers(
                          parkingSpots, slidePanelController, handleMarkerTap);
                      return MarkerLayer(markers: markerList);
                    } else {
                      return const MarkerLayer();
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
                  panelController: slidePanelController,
                  selectedParkingSpot: _selectedParkingSpot,
                )));
  }
}
