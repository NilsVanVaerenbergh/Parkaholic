import 'package:flutter/material.dart';
import 'package:src/app.config.dart';
import 'package:src/pages/home.dart';

import 'package:src/pages/login.dart';
import 'handlers/position.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future main() async {
  //checkt of alles init
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

PositionHandler positionHandler = PositionHandler();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Parkaholic',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xffffffff, AppConfig().colors()),
      ),
      home: const Login(),
    );
  }
}
