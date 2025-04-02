// import 'package:flutter/material.dart';
// import '../utils/database_helper.dart';

// class AdminScreen extends StatefulWidget {
//   @override
//   _AdminScreenState createState() => _AdminScreenState();
// }

// class _AdminScreenState extends State<AdminScreen> {
//   List<Map<String, dynamic>> _usuarios = [];

//   @override
//   void initState() {
//     super.initState();
//     _cargarUsuarios();
//   }

//   Future<void> _cargarUsuarios() async {
//     final usuarios = await DatabaseHelper().getAllUsers();
//     setState(() {
//       _usuarios = usuarios;
//     });
//   }

//   Future<void> _eliminarUsuario(int id) async {
//     await DatabaseHelper().deleteUser(id);
//     _cargarUsuarios(); // Actualizar la lista después de eliminar
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Usuario eliminado con éxito')),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Panel de Administrador')),
//       body: _usuarios.isEmpty
//           ? Center(child: Text('No hay usuarios registrados'))
//           : ListView.builder(
//               itemCount: _usuarios.length,
//               itemBuilder: (context, index) {
//                 final usuario = _usuarios[index];
//                 return ListTile(
//                   title: Text(usuario['correo']),
//                   trailing: IconButton(
//                     icon: Icon(Icons.delete, color: Colors.red),
//                     onPressed: () => _eliminarUsuario(usuario['id']),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../utils/database_helper.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<Map<String, dynamic>> _usuarios = [];

  @override
  void initState() {
    super.initState();
    _cargarUsuarios();
  }

  Future<void> _cargarUsuarios() async {
    final usuarios = await DatabaseHelper().getAllUsers();
    setState(() {
      _usuarios = usuarios;
    });
  }

  Future<void> _eliminarUsuario(int id) async {
    await DatabaseHelper().deleteUser(id);
    _cargarUsuarios(); // Actualizar la lista después de eliminar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Usuario eliminado con éxito'),
        backgroundColor:
            Colors.green, // Cambié el color de fondo para resaltar el éxito
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Colors.blueGrey[900], // Fondo más oscuro para el AppBar
        title: Text(
          'Panel de Administrador',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body:
          _usuarios.isEmpty
              ? Center(
                child: Text(
                  'No hay usuarios registrados',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              )
              : ListView.builder(
                itemCount: _usuarios.length,
                itemBuilder: (context, index) {
                  final usuario = _usuarios[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    color: Colors.blueGrey[800], // Fondo oscuro para cada item
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      title: Text(
                        usuario['correo'],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _eliminarUsuario(usuario['id']),
                      ),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aquí podrías agregar la funcionalidad para añadir un usuario.
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),
    );
  }
}
