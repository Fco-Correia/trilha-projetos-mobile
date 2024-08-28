import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _marcadores = {};

  _onMapCreated(GoogleMapController googleMapController) {
    _controller.complete(googleMapController);//completa o completer e que o valor disponivel é o googlemapcontroller
  }

  _movimentarCamera() async {
    GoogleMapController googleMapController = await _controller.future;

    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        const CameraPosition(
            target: LatLng(-2.938655, -41.770079),
            zoom: 19,
            tilt: 10,
            bearing: 30)));
  }

  _carregarMarcadores() {
    Set<Marker> marcadoresLocal = {};
    Marker marcador = const Marker(
        markerId: MarkerId("Marcador-zpe"),
        position: LatLng(-2.958655, -41.770079),
        infoWindow: InfoWindow(
          title: "zpe"
        )
    );

    Marker marcador2 = Marker(
        markerId: const MarkerId("Marcador-aleatorio"),
        position: const LatLng(-2.908655, -41.770079),
        infoWindow: const InfoWindow(
          title: "aleatorio"
        ),
        //icon:BitmapDescriptor.defaultMarker
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        rotation: 45
    );

    marcadoresLocal.add(marcador);
    marcadoresLocal.add(marcador2);

    setState(() {
      _marcadores = marcadoresLocal;
    });
  }

  @override
  void initState() {
    super.initState();
    _carregarMarcadores();
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
          markers: _marcadores,
        ),
      ),
    );
  }
}
