// import 'package:flutter/material.dart';
// import '../utils/database_helper.dart';
// import 'home_screen.dart';
// import 'register_screen.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _correoController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   Future<void> _login() async {
//     final correo = _correoController.text;
//     final password = _passwordController.text;

//     final user = await DatabaseHelper().getUser(correo, password);
//     if (user != null) {
//       String nombre = user['nombre'];
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => HomeScreen(nombre: nombre, correo: correo)),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Correo o password incorrectos', style: TextStyle(color: Colors.white)),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Inicio de Sesión')),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _correoController,
//               decoration: InputDecoration(labelText: 'Correo electrónico'),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _login,
//               child: Text('Iniciar sesión', style: TextStyle(fontSize: 18)),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
//               },
//               child: Text(
//                 '¿No tienes cuenta? Regístrate aquí',
//                 style: TextStyle(color: Colors.green[700]), // Verde Pistache
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../utils/database_helper.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final correo = _correoController.text;
    final password = _passwordController.text;

    final user = await DatabaseHelper().getUser(correo, password);
    if (user != null) {
      String nombre = user['nombre'];
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(nombre: nombre, correo: correo),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Correo o password incorrectos',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800], // Fondo oscuro
      appBar: AppBar(
        title: Text('Inicio de Sesión', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueGrey[900], // AppBar más oscuro
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Título de la pantalla
            Text(
              'Bienvenido, por favor ingresa tus datos',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            // Campo de texto para el correo electrónico
            TextField(
              controller: _correoController,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                labelStyle: TextStyle(color: Colors.white),
                fillColor: Colors.blueGrey[700], // Fondo oscuro para el campo
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.green, width: 2),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            // Campo de texto para la contraseña
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white),
                fillColor: Colors.blueGrey[700], // Fondo oscuro para el campo
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.green, width: 2),
                ),
              ),
              obscureText: true,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            // Botón de inicio de sesión
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Fondo verde para el botón
                foregroundColor: Colors.white, // Texto blanco
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Bordes redondeados
                ),
              ),
              child: Text('Iniciar sesión', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 15),
            // Enlace para registro de cuenta
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              child: Text(
                '¿No tienes cuenta? Regístrate aquí',
                style: TextStyle(color: Colors.green[700]), // Verde Pistache
              ),
            ),
          ],
        ),
      ),
    );
  }
}
