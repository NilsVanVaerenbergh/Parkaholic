import 'package:flutter/material.dart';

class AppConfig {
  Map<int, Color> colors() {
    Map<int, Color> color = {
      50: const Color.fromRGBO(255, 255, 255, 0.098),
      100: const Color.fromRGBO(255, 255, 255, 0.2),
      200: const Color.fromRGBO(255, 255, 255, 0.298),
      300: const Color.fromRGBO(255, 255, 255, 0.4),
      400: const Color.fromRGBO(255, 255, 255, 1),
      500: const Color.fromRGBO(255, 255, 255, 1),
      600: const Color.fromRGBO(255, 255, 255, 1),
      700: const Color.fromRGBO(255, 255, 255, 1),
      800: const Color.fromRGBO(255, 255, 255, 1),
      900: const Color.fromRGBO(255, 255, 255, 1),
    };
    return color;
  }
}
