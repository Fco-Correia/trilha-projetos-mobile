import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _posicaoCamera = const CameraPosition(
      target: LatLng(-2.958655, -41.770079), zoom: 16, tilt: 50);

  _onMapCreated(GoogleMapController googleMapController) {
    _controller.complete(googleMapController); // Completa o completer com o valor googleMapController
  }

  _movimentarCamera() async {
    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(_posicaoCamera));
  }

  _recuperarLocalParaEndereco() async {
    try {
      // Obter coordenadas do endereço
      List<Location> locations = await locationFromAddress("parnaiba piaui Brasil");
      if (locations.isNotEmpty) {
        Location location = locations.first;
        print('Latitude: ${location.latitude}, Longitude: ${location.longitude}');

        // Obter informações detalhadas da localização
        List<Placemark> placemarks = await placemarkFromCoordinates(location.latitude, location.longitude);
        if (placemarks.isNotEmpty) {
          Placemark placemark = placemarks.first;
          print('Country: ${placemark.country}');//Tem várias outras
        }

        // Atualizar a posição da câmera
        setState(() {
          _posicaoCamera = CameraPosition(
            target: LatLng(location.latitude, location.longitude),
            zoom: 16,
            tilt: 50,
          );
          _movimentarCamera(); // Move a câmera para a nova localização
        });
      } else {
        print('Nenhuma localização encontrada para o endereço fornecido.');
      }
    } catch (e) {
      print('Erro ao obter a localização: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _recuperarLocalParaEndereco();
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
          mapType: MapType.satellite,
          initialCameraPosition: _posicaoCamera,
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,
        ),
      ),
    );
  }
}
