// import 'package:flutter/material.dart';
// import '../utils/database_helper.dart';

// class RegisterScreen extends StatefulWidget {
//   @override
//   _RegisterScreenState createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final TextEditingController _nombreController = TextEditingController();
//   final TextEditingController _apellidoController = TextEditingController();
//   final TextEditingController _correoController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();

//   Future<void> _register() async {
//     final nombre = _nombreController.text;
//     final apellido = _apellidoController.text;
//     final correo = _correoController.text;
//     final password = _passwordController.text;
//     final confirmarPassword = _confirmPasswordController.text;

//     if (password != confirmarPassword) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Las passwords no coinciden', style: TextStyle(color: Colors.white)),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     await DatabaseHelper().insertUser(nombre, apellido, correo, password);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Usuario registrado con éxito', style: TextStyle(color: Colors.white)),
//         backgroundColor: Colors.green,
//       ),
//     );
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Registro de Usuario')),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(controller: _nombreController, decoration: InputDecoration(labelText: 'Nombre')),
//             SizedBox(height: 10),
//             TextField(controller: _apellidoController, decoration: InputDecoration(labelText: 'Apellido')),
//             SizedBox(height: 10),
//             TextField(controller: _correoController, decoration: InputDecoration(labelText: 'Correo electrónico')),
//             SizedBox(height: 10),
//             TextField(controller: _passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
//             SizedBox(height: 10),
//             TextField(controller: _confirmPasswordController, decoration: InputDecoration(labelText: 'Confirmar password'), obscureText: true),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _register,
//               child: Text('Registrarse', style: TextStyle(fontSize: 18)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../utils/database_helper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Future<void> _register() async {
    final nombre = _nombreController.text;
    final apellido = _apellidoController.text;
    final correo = _correoController.text;
    final password = _passwordController.text;
    final confirmarPassword = _confirmPasswordController.text;

    if (password != confirmarPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Las passwords no coinciden',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    await DatabaseHelper().insertUser(nombre, apellido, correo, password);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Usuario registrado con éxito',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800], // Fondo oscuro
      appBar: AppBar(
        title: Text(
          'Registro de Usuario',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey[900], // AppBar más oscuro
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Campo para el nombre
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(
                labelText: 'Nombre',
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
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10),
            // Campo para el apellido
            TextField(
              controller: _apellidoController,
              decoration: InputDecoration(
                labelText: 'Apellido',
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
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10),
            // Campo para el correo
            TextField(
              controller: _correoController,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
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
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10),
            // Campo para la contraseña
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
            SizedBox(height: 10),
            // Campo para confirmar la contraseña
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirmar password',
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
            // Botón de registro
            ElevatedButton(
              onPressed: _register,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Fondo verde para el botón
                foregroundColor: Colors.white, // Texto blanco
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Bordes redondeados
                ),
              ),
              child: Text('Registrarse', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
