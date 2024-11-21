import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prognosai_iic/StartingScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Startingscreen(),
    )),
  ));
}
