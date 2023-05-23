import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'dart:async';

class PositionHandler {
  LatLng location = LatLng(51.229838, 4.4171506);
  bool locationPermission = false;
  bool updateMapCenter = true;

  Future<void> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);

    location = LatLng(position.latitude, position.longitude);
    LatLng(position.latitude, position.longitude);
  }

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
}
