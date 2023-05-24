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
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          locationPermission = false;
        } else if (permission == LocationPermission.deniedForever) {
          locationPermission = false;
        } else {
          getCurrentLocation();
          locationPermission = true;
        }
      } else {
        getCurrentLocation();
        locationPermission = true;
      }
    } else {
      locationPermission = false;
    }
  }
}
