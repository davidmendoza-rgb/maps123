// import 'package:flutter/material.dart';
// import 'screens/login_screen.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'App de Login',
//       theme: ThemeData(
//         brightness: Brightness.light,
//         scaffoldBackgroundColor: Color(0xFFD4F2E7), // Verde pistache
//         primaryColor: Color(0xFF40E0D0), // Turquesa
//         appBarTheme: AppBarTheme(
//           backgroundColor: Color(0xFF40E0D0), // Fondo Turquesa
//           foregroundColor: Colors.white, // Letras blancas
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Color(0xFF40E0D0), // Turquesa
//             foregroundColor: Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//         ),
//         inputDecorationTheme: InputDecorationTheme(
//           filled: true,
//           fillColor: Colors.white,
//           labelStyle: TextStyle(color: Color(0xFF40E0D0)), // Turquesa
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Color(0xFF40E0D0)), // Turquesa
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.green, width: 2), // Verde Pistache
//           ),
//         ),
//       ),
//       home: LoginScreen(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App de Login',
      theme: ThemeData(
        brightness: Brightness.dark, // Usar tema oscuro
        scaffoldBackgroundColor: Color(0xFF2C3E50), // Azul oscuro
        primaryColor: Color(0xFF34495E), // Azul grisáceo oscuro
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF34495E), // Fondo Azul oscuro
          foregroundColor: Colors.white, // Letras blancas
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF1ABC9C), // Verde oscuro
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          labelStyle: TextStyle(color: Color(0xFF1ABC9C)), // Verde oscuro
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF1ABC9C)), // Verde oscuro
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF34495E),
              width: 2,
            ), // Azul oscuro
          ),
        ),
      ),
      home: LoginScreen(),
    );
  }
}
