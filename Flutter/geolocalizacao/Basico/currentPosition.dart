import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Completer<GoogleMapController> _controller = Completer();

  _onMapCreated(GoogleMapController googleMapController) {
    _controller.complete(
        googleMapController); //completa o completer e que o valor disponivel é o googlemapcontroller
  }

  _movimentarCamera() async {
    GoogleMapController googleMapController = await _controller.future;

    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        const CameraPosition(
            target: LatLng(-2.938655, -41.770079),
            zoom: 19,
            tilt: 40,
            bearing: 30 //rotaciona
            )));
  }

//bom falar do async...
  _recuperarLocalizacaoAtual() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print("Localização atual: " + position.toString());
    //-2.9195028 -41.7368463 . ou , pra android ou ios no simulador
  }

  @override
  void initState() {
    super.initState();
    _recuperarLocalizacaoAtual();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mapas e geolocalização"),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.done),
        onPressed: () {
          _movimentarCamera();
        },
      ),
      body: Container(
        child: GoogleMap(
          //mapType: MapType.normal,
          mapType: MapType.satellite,
          initialCameraPosition: const CameraPosition(
              target: LatLng(-2.958655, -41.770079), zoom: 16, tilt: 50),
          onMapCreated: _onMapCreated,
        ),
      ),
    );
  }
}
