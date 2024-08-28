import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Mapa extends StatefulWidget {
  final String? idViagem;

  Mapa({this.idViagem});

  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _marcadores = {};
  StreamSubscription<Position>? _locationSubscription; // Permite valor nulo
  bool _isMounted = false;
  bool _isLoading = true; // Flag para mostrar o ProgressIndicator
  CameraPosition _posicaoCamera =
      CameraPosition(target: LatLng(-23.562436, -46.65505), zoom: 18);

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    _carregarLocalizacaoInicial();
  }

  Future<void> _carregarLocalizacaoInicial() async {
    Position? position;

    // Tenta obter a localização atual do usuário
    try {
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      print("Erro ao obter localização: $e");
      // Se não conseguir obter a localização, ainda assim continua
      position = null;
    }

    // Se a localização foi obtida com sucesso
    if (position != null) {
      setState(() {
        _posicaoCamera = CameraPosition(
          target: LatLng(position!.latitude, position.longitude),
          zoom: 18,
        );
        _isLoading = false; // Define como falso quando o carregamento estiver concluído
      });
    }

    // Inicia o listener de localização se não houver um ID de viagem fornecido
    if (widget.idViagem == null) {
      _adicionarListenerLocalizacao();
    }

    // Se um ID de viagem foi fornecido, recupera os dados da viagem
    _recuperarViagemParaID(widget.idViagem);
  }

  _onMapCreated(GoogleMapController googleMapController) {
    _controller.complete(googleMapController);
  }

  _adicionarMarcador(LatLng latLng) async {
    print("local clicado:" + latLng.toString());

    List<Placemark> placemarks =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      String? rua = placemark.thoroughfare;//nome da rua,avenida
      Marker marcador = Marker(
          markerId:
              MarkerId("marcador - ${latLng.latitude} - ${latLng.longitude}"),
          position: latLng,
          infoWindow: InfoWindow(title: rua!));

      if (_isMounted) {
        setState(() {
          _marcadores.add(marcador);
          Map<String, dynamic> viagem = Map();
          viagem["titulo"] = rua;
          viagem["latitude"] = latLng.latitude;
          viagem["longitude"] = latLng.longitude;
          _db.collection("viagens").add(viagem);
        });
      }
    }
  }

  _movimentarCamera() async {
    GoogleMapController googleMapController = await _controller.future;

    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(_posicaoCamera));
  }

  _adicionarListenerLocalizacao() async {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    _locationSubscription = Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      if (_isMounted) {
        setState(() {
          _posicaoCamera = CameraPosition(
              target: LatLng(position.latitude, position.longitude), zoom: 18);
        });
      }
    });
  }

  _recuperarViagemParaID(String? idViagem) async {
    if (idViagem != null) {
      DocumentSnapshot documentSnapshot =
          await _db.collection("viagens").doc(idViagem).get();
      var dados = documentSnapshot.data()
          as Map<String, dynamic>; //data retorna um objeto
      String titulo = dados["titulo"];
      LatLng latLng = LatLng(dados["latitude"], dados["longitude"]);

      if (_isMounted) {
        setState(() {
          Marker marcador = Marker(
              markerId:
                  MarkerId("marcador - ${latLng.latitude} - ${latLng.longitude}"),
              position: latLng,
              infoWindow: InfoWindow(title: titulo));

          _marcadores.add(marcador);
          _posicaoCamera = CameraPosition(target: latLng, zoom: 18);
          _movimentarCamera();
        });
      }
    }
  }

  @override
  void dispose() {
    _isMounted = false;
    _locationSubscription?.cancel(); // Cancelar o listener de localização se não for nulo
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mapas',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xff0066cc),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator()) // Exibe um progress indicator enquanto carrega
          : GoogleMap(
              mapType: MapType.satellite,
              initialCameraPosition: _posicaoCamera,
              onMapCreated: _onMapCreated,
              onLongPress: _adicionarMarcador,
              markers: _marcadores,
            ),
    );
  }
}
