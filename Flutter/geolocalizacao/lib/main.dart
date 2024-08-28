import 'package:flutter/material.dart';
import 'SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(MaterialApp(
    title: "Minhas viagens",
    home: SplashScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
