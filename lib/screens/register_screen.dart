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
import '../screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _correoController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      try {
        await DatabaseHelper().insertUser(
          _nombreController.text,
          _correoController.text,
          _passwordController.text,
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('¡Registro exitoso!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _correoController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator:
                    (value) =>
                        value != null && value.isNotEmpty
                            ? null
                            : 'Campo requerido',
              ),
              TextFormField(
                controller: _correoController,
                decoration: const InputDecoration(labelText: 'Correo'),
                validator:
                    (value) =>
                        value != null && value.contains('@')
                            ? null
                            : 'Correo inválido',
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                validator:
                    (value) =>
                        value != null && value.length >= 6
                            ? null
                            : 'Mínimo 6 caracteres',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _register,
                child: const Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
