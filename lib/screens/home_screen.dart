// import 'package:flutter/material.dart';
// import 'login_screen.dart';
// import 'admin_screen.dart';

// class HomeScreen extends StatelessWidget {
//   final String nombre;
//   final String correo; // Recibimos el correo

//   const HomeScreen({required this.nombre, required this.correo, Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text('Bienvenido'),
//         automaticallyImplyLeading: false,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Hola, $nombre 👋',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             // SOLO mostrar el botón si el usuario es admin
//             if (correo == "admin@gmail.com")
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => AdminScreen()),
//                   );
//                 },
//                 child: Text('Panel de Administrador'),
//               ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (context) => LoginScreen()),
//                   (route) => false,
//                 );
//               },
//               child: Text('Cerrar sesión'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'login_screen.dart';
// import 'admin_screen.dart';

// class HomeScreen extends StatelessWidget {
//   final String nombre;
//   final String correo; // Recibimos el correo

//   const HomeScreen({required this.nombre, required this.correo, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blueGrey[800], // Fondo oscuro para toda la pantalla
//       appBar: AppBar(
//         title: Text(
//           'Bienvenido',
//           style: TextStyle(color: Colors.white), // Texto blanco en el AppBar
//         ),
//         backgroundColor: Colors.blueGrey[900], // Fondo más oscuro para el AppBar
//         automaticallyImplyLeading: false,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Hola, $nombre que hace?, vamos por una cervesa?',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white, // Texto en blanco para buen contraste
//               ),
//             ),
//             SizedBox(height: 20),
//             // Mostrar el botón de administrador solo si el usuario es admin
//             if (correo == "admin@gmail.com")
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => AdminScreen()),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green, // Fondo verde para el botón
//                   foregroundColor: Colors.white, // Texto blanco en el botón
//                 ),
//                 child: Text('Panel de Administrador'),
//               ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (context) => LoginScreen()),
//                   (route) => false,
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color.fromARGB(255, 118, 12, 211), // Fondo rojo para el botón
//                 foregroundColor: Colors.white, // Texto blanco en el botón
//               ),
//               child: Text('Cerrar sesión'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'admin_screen.dart';
import 'maps.dart'; // Importamos el archivo maps.dart

class HomeScreen extends StatelessWidget {
  final String nombre;
  final String correo; // Recibimos el correo

  const HomeScreen({required this.nombre, required this.correo, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.blueGrey[800], // Fondo oscuro para toda la pantalla
      appBar: AppBar(
        title: Text(
          'Bienvenido',
          style: TextStyle(color: Colors.white), // Texto blanco en el AppBar
        ),
        backgroundColor:
            Colors.blueGrey[900], // Fondo más oscuro para el AppBar
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hola, $nombre que hace?, vamos por una cervesa?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Texto en blanco para buen contraste
              ),
            ),
            SizedBox(height: 20),
            // Mostrar el botón de administrador solo si el usuario es admin
            if (correo == "admin@gmail.com")
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Fondo verde para el botón
                  foregroundColor: Colors.white, // Texto blanco en el botón
                ),
                child: Text('Panel de Administrador'),
              ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(
                  255,
                  118,
                  12,
                  211,
                ), // Fondo rojo para el botón
                foregroundColor: Colors.white, // Texto blanco en el botón
              ),
              child: Text('Cerrar sesión'),
            ),
            SizedBox(height: 20),
            // Botón para navegar a la pantalla de mapas
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla de MapsScreen (maps.dart)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MapsScreen(),
                  ), // Asegúrate de que MapsScreen esté bien definido en maps.dart
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Fondo azul para el botón
                foregroundColor: Colors.white, // Texto blanco en el botón
              ),
              child: Text('Ver Mapa'),
            ),
          ],
        ),
      ),
    );
  }
}
