// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'marker_form.dart'; // Importamos la pantalla del formulario

// class MapsScreen extends StatefulWidget {
//   const MapsScreen({Key? key}) : super(key: key);

//   @override
//   _MapsScreenState createState() => _MapsScreenState();
// }

// class _MapsScreenState extends State<MapsScreen> {
//   late GoogleMapController mapController;
//   final LatLng _center = const LatLng(45.521563, -122.677433);
//   final Set<Marker> _markers = {}; // Conjunto de marcadores

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   // Método para manejar la creación de marcadores al hacer una pulsación larga en el mapa
//   void _onLongPress(LatLng position) async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => MarkerFormScreen(position: position),
//       ),
//     );

//     // Si el usuario ingresó datos válidos, agregar el marcador al mapa
//     if (result != null && result is Map<String, String>) {
//       setState(() {
//         _markers.add(
//           Marker(
//             markerId: MarkerId(position.toString()),
//             position: position,
//             infoWindow: InfoWindow(
//               title: result['title'],
//               snippet: result['description'],
//             ),
//           ),
//         );
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Mapa Interactivo'),
//         backgroundColor: Colors.green[700],
//       ),
//       body: GoogleMap(
//         onMapCreated: _onMapCreated,
//         initialCameraPosition: CameraPosition(target: _center, zoom: 11.0),
//         markers: _markers, // Agregamos los marcadores
//         onLongPress: _onLongPress, // Detectar pulsación larga
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../screens/marker_form.dart';
// import '../utils/database_helper.dart';

// class MapsScreen extends StatefulWidget {
//   final int userId;
//   const MapsScreen({Key? key, required this.userId}) : super(key: key);

//   @override
//   _MapsScreenState createState() => _MapsScreenState();
// }

// class _MapsScreenState extends State<MapsScreen> {
//   late GoogleMapController _mapController;
//   final Set<Marker> _markers = {};
//   final DatabaseHelper _dbHelper = DatabaseHelper();

//   @override
//   void initState() {
//     super.initState();
//     _loadMarkers();
//   }

//   Future<void> _loadMarkers() async {
//     final markers = await _dbHelper.getUserMarkers(widget.userId);
//     setState(() {
//       _markers.clear();
//       _markers.addAll(markers.map((marker) => Marker(
//         markerId: MarkerId('${marker['id']}'),
//         position: LatLng(marker['lat'], marker['lng']),
//         infoWindow: InfoWindow(
//           title: marker['title'],
//           snippet: marker['description'],
//         ),
//         onTap: () => _showEditDeleteDialog(marker),
//       )));
//     });
//   }

//   void _showEditDeleteDialog(Map<String, dynamic> marker) async {
//     final action = await showDialog<String>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(marker['title'] ?? 'Marcador'),
//         content: const Text('Selecciona una acción'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, 'edit'),
//             child: const Text('Editar'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pop(context, 'delete'),
//             child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
//           ),
//         ],
//       ),
//     );

//     if (!mounted) return;

//     if (action == 'edit') {
//       final result = await Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => MarkerFormScreen(
//             position: LatLng(marker['lat'], marker['lng']),
//             initialTitle: marker['title'],
//             initialDescription: marker['description'],
//           ),
//         ),
//       );

//       if (result != null && mounted) {
//         await _dbHelper.updateMarker(marker['id'], {
//           'title': result['title'],
//           'description': result['description'],
//         });
//         _loadMarkers();
//       }
//     } else if (action == 'delete' && mounted) {
//       await _dbHelper.deleteMarker(marker['id']);
//       _loadMarkers();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Mis Marcadores')),
//       body: GoogleMap(
//         onMapCreated: (controller) => _mapController = controller,
//         initialCameraPosition: const CameraPosition(
//           target: LatLng(19.4326, -99.1332), // Ciudad de México
//           zoom: 12,
//         ),
//         markers: _markers,
//         onLongPress: (LatLng position) => _addNewMarker(position),
//       ),
//     );
//   }

//   Future<void> _addNewMarker(LatLng position) async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => MarkerFormScreen(position: position),
//       ),
//     );

//     if (result != null && mounted) {
//       await _dbHelper.insertMarker(widget.userId, {
//         'title': result['title'],
//         'description': result['description'],
//         'lat': position.latitude,
//         'lng': position.longitude,
//       });
//       _loadMarkers();
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../screens/marker_form.dart';
import '../utils/database_helper.dart';

class MapsScreen extends StatefulWidget {
  final int userId;
  const MapsScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  final Set<Marker> _markers = {};
  late GoogleMapController _mapController;
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Posición inicial definida (Ciudad de México)
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(19.4326, -99.1332),
    zoom: 12,
  );

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  /// Carga los marcadores asociados al usuario desde la base de datos
  Future<void> _loadMarkers() async {
    try {
      final markersData = await _dbHelper.getUserMarkers(widget.userId);
      debugPrint("Marcadores cargados: ${markersData.length}");
      setState(() {
        _markers.clear();
        _markers.addAll(
          markersData.map(
            (marker) => Marker(
              markerId: MarkerId('${marker['id']}'),
              position: LatLng(marker['lat'], marker['lng']),
              infoWindow: InfoWindow(
                title: marker['title'] ?? 'Sin título',
                snippet: marker['description'] ?? 'Sin descripción',
              ),
              onTap: () => _showEditDeleteDialog(marker),
            ),
          ),
        );
      });
    } catch (e) {
      debugPrint("Error al cargar marcadores: $e");
    }
  }

  /// Muestra un diálogo para editar o eliminar un marcador
  Future<void> _showEditDeleteDialog(Map<String, dynamic> marker) async {
    final action = await showDialog<String>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(marker['title'] ?? 'Marcador'),
            content: const Text('¿Qué acción deseas realizar?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'edit'),
                child: const Text('Editar'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'delete'),
                child: const Text(
                  'Eliminar',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );

    if (!mounted) return;

    if (action == 'edit') {
      final result = await Navigator.push<Map<String, String>?>(
        context,
        MaterialPageRoute(
          builder:
              (context) => MarkerFormScreen(
                position: LatLng(marker['lat'], marker['lng']),
                initialTitle: marker['title'] ?? '',
                initialDescription: marker['description'] ?? '',
              ),
        ),
      );
      if (result != null && mounted) {
        try {
          await _dbHelper.updateMarker(marker['id'], {
            'title': result['title'],
            'description': result['description'],
          });
          debugPrint("Marcador (ID: ${marker['id']}) actualizado.");
          _loadMarkers();
        } catch (e) {
          debugPrint("Error al actualizar marcador: $e");
        }
      }
    } else if (action == 'delete' && mounted) {
      try {
        await _dbHelper.deleteMarker(marker['id']);
        debugPrint("Marcador (ID: ${marker['id']}) eliminado.");
        _loadMarkers();
      } catch (e) {
        debugPrint("Error al eliminar marcador: $e");
      }
    }
  }

  /// Agrega un nuevo marcador tras presionar prolongadamente sobre el mapa.
  Future<void> _addNewMarker(LatLng position) async {
    final result = await Navigator.push<Map<String, String>?>(
      context,
      MaterialPageRoute(
        builder: (context) => MarkerFormScreen(position: position),
      ),
    );

    if (result != null && mounted) {
      try {
        // Insertar nuevo marcador en la base de datos
        final id = await _dbHelper.insertMarker(widget.userId, {
          'title': result['title'],
          'description': result['description'],
          'lat': position.latitude,
          'lng': position.longitude,
        });
        debugPrint("Marcador insertado con id: $id");
        await _loadMarkers();
      } catch (e) {
        debugPrint("Error al insertar marcador: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mapa de Marcadores')),
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        markers: _markers,
        onMapCreated: (controller) {
          _mapController = controller;
        },
        onLongPress: _addNewMarker,
      ),
    );
  }
}
