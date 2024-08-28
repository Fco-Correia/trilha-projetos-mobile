import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Set<Marker> _marcadores = {};
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _posicaoCamera = const CameraPosition(
      target: LatLng(-2.958655, -41.770079), zoom: 16, tilt: 50);

  _onMapCreated(GoogleMapController googleMapController) {
    _controller.complete(
        googleMapController); //completa o completer e que o valor disponivel é o googlemapcontroller
  }

  _movimentarCamera(CameraPosition cameraPosition) async {
    GoogleMapController googleMapController = await _controller.future;

    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  _recuperarLocalizacaoAtual() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print("Localização atual: " + position.toString());
    setState(() {
      _posicaoCamera = CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 17);
    });
  }

  void _adicionarListenerLocalizacao() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (Position position) {
        print("localizacao atual: $position");
        setState(() {
          _posicaoCamera = CameraPosition(
              target: LatLng(position.latitude, position.longitude), zoom: 17);
          _movimentarCamera(_posicaoCamera);
        });
        Marker marcador = Marker(
            markerId: const MarkerId("Marcador-usuario"),
            position: LatLng(position.latitude, position.longitude),
            infoWindow: const InfoWindow(title: "usuario"));
        _marcadores.add(marcador);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _recuperarLocalizacaoAtual().then(_adicionarListenerLocalizacao());
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
          _movimentarCamera(_posicaoCamera);
        },
      ),
      body: Container(
        child: GoogleMap(
          //mapType: MapType.normal,
          mapType: MapType.satellite,
          initialCameraPosition: _posicaoCamera,
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,
          markers: _marcadores,
        ),
      ),
    );
  }
}
