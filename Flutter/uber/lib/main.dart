import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uber/telas/Home.dart';

import 'Rotas.dart';

final ThemeData temaPadrao = ThemeData(
  primaryColor: Color(0xff37474f),
);

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: "Uber",
    home: Home(),
    theme: temaPadrao,
    initialRoute: "/",
    onGenerateRoute: Rotas.gerarRotas,
    debugShowCheckedModeBanner: false,
  ));
}
