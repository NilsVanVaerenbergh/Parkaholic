import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

LatLng location =
    LatLng(51.229838, 4.4171506); //Default naar ellermanstraat campus.

bool locationPermission = false;

Future<void> checkLocationEnabled() async {
  bool servicestatus = await Geolocator.isLocationServiceEnabled();
  if (servicestatus) {
    print("GPS service is enabled");
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
        locationPermission = false;
      } else if (permission == LocationPermission.deniedForever) {
        print("Location permissions are permanently denied");
        locationPermission = false;
      } else {
        getCurrentLocation();
        locationPermission = true;
      }
    } else {
      print("GPS Location permission granted.");
      getCurrentLocation();
      locationPermission = true;
    }
  } else {
    print("GPS service is disabled.");
    locationPermission = false;
  }
}

Future<void> getCurrentLocation() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  location = LatLng(position.latitude, position.longitude);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Park Aholic',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: MaterialColor(0xffffffff, color),
      ),
      home: const MyHomePage(title: 'Parkaholic'),
    );
  }
}

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
  MapController mapController = MapController();
  Timer? timer;
  bool updateMapCenter = true;

  @override
  void initState() {
    super.initState();
    checkLocationEnabled();

    //zal center van map elke seconde naar currentlocation brengen.
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (updateMapCenter && locationPermission) {
          getCurrentLocation();
          mapController.move(location, 17.0);
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
                center: location,
                zoom: 17.0,
                maxZoom: 22.0,
                enableScrollWheel: true,
                scrollWheelVelocity: 0.005,
                onPositionChanged: ((position, hasGesture) =>
                    updateMapCenter = false)),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: location,
                    builder: (ctx) => const Icon(
                      Icons.person,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: FloatingActionButton(
              onPressed: () {
                updateMapCenter = true;
              },
              child: Icon(Icons.adjust),
            ),
          ),
        ],
      ),
    );
  }
}
