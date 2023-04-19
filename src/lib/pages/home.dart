import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import '../components/icons.dart';
import '../components/markers.dart';
import '../handlers/position.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
                center: positionHandler.location,
                zoom: 17.0,
                maxZoom: 22.0,
                enableScrollWheel: true,
                scrollWheelVelocity: 0.005,
                onPositionChanged: ((position, hasGesture) =>
                    positionHandler.updateMapCenter = false)),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [Markers().currentUserLocation(positionHandler)],
              ),
            ],
          ),
          AppIcons().park(context),
          AppIcons().centerPosition(positionHandler)
        ],
      ),
    );
  }
}
