// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapsScreen extends StatefulWidget {
//   const MapsScreen({Key? key}) : super(key: key);

//   @override
//   _MapsScreenState createState() => _MapsScreenState();
// }

// class _MapsScreenState extends State<MapsScreen> {
//   late GoogleMapController mapController;

//   final LatLng _center = const LatLng(45.521563, -122.677433);

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Maps Sample App'),
//         backgroundColor: Colors.green[700],
//       ),
//       body: GoogleMap(
//         onMapCreated: _onMapCreated,
//         initialCameraPosition: CameraPosition(target: _center, zoom: 11.0),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'marker_form.dart'; // Importamos la pantalla del formulario

class MapsScreen extends StatefulWidget {
  const MapsScreen({Key? key}) : super(key: key);

  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(20.495985, -99.182557);
  final Set<Marker> _markers = {}; // Conjunto de marcadores

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // Método para manejar la creación de marcadores al hacer una pulsación larga en el mapa
  void _onLongPress(LatLng position) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MarkerFormScreen(position: position),
      ),
    );

    // Si el usuario ingresó datos válidos, agregar el marcador al mapa
    if (result != null && result is Map<String, String>) {
      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId(position.toString()),
            position: position,
            infoWindow: InfoWindow(
              title: result['title'],
              snippet: result['description'],
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa Interactivo'),
        backgroundColor: Colors.green[700],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(target: _center, zoom: 11.0),
        markers: _markers, // Agregamos los marcadores
        onLongPress: _onLongPress, // Detectar pulsación larga
      ),
    );
  }
}
