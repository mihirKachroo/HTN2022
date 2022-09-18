import 'package:flutter/material.dart';
import 'package:client/homePage.dart';
import 'package:get/get.dart';
import 'package:motor_flutter/motor_flutter.dart';

void main() {
  // Init Services
  WidgetsFlutterBinding.ensureInitialized();
  MotorFlutter.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}
