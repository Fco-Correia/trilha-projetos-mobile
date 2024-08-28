import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

/*O Completer é uma CLASSE GENERICA que pode 
ser parametrizada com qualquer tipo. Nesse caso
ela está parametrizada com GoogleMapController, 
significando que o Completer vai completar 
uma Future com um valor do tipo 
GoogleMapController. */
class _HomeState extends State<Home> {
  Completer<GoogleMapController> _controller = Completer(); 
  _onMapCreated(GoogleMapController googleMapController) {
    _controller.complete(googleMapController);

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mapas e geolocalização"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: GoogleMap(
          mapType: MapType.normal,
          //-23.562436, -46.655005
          initialCameraPosition: const CameraPosition(
              target: LatLng(-23.562436, -46.655005), zoom: 16),
          onMapCreated: _onMapCreated,
        ),
      ),
    );
  }
}
