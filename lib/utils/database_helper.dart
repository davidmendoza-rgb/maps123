// import 'package:path/path.dart';
// import 'dart:io';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// class DatabaseHelper {
//   static final DatabaseHelper _instance = DatabaseHelper._internal();
//   static Database? _database;

//   DatabaseHelper._internal();

//   factory DatabaseHelper() {
//     return _instance;
//   }

//   Future<Database> get database async {
//     if (_database != null) return _database!;

//     if (Platform.isWindows) {
//       sqfliteFfiInit();
//       databaseFactory = databaseFactoryFfi;
//     }

//     _database = await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, 'usuarios.db');

//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) {
//         db.execute('''
//           CREATE TABLE usuarios (
//             id INTEGER PRIMARY KEY AUTOINCREMENT,
//             nombre TEXT NOT NULL,
//             apellido TEXT NOT NULL,
//             correo TEXT NOT NULL UNIQUE,
//             password TEXT NOT NULL
//           )
//         ''');
//       },
//     );
//   }

//   Future<int> insertUser(
//     String nombre,
//     String apellido,
//     String correo,
//     String password,
//   ) async {
//     final db = await database;
//     return await db.insert('usuarios', {
//       'nombre': nombre,
//       'apellido': apellido,
//       'correo': correo,
//       'password': password,
//     });
//   }

//   Future<Map<String, dynamic>?> getUser(String correo, String password) async {
//     final db = await database;
//     final result = await db.query(
//       'usuarios',
//       where: 'correo = ? AND password = ?',
//       whereArgs: [correo, password],
//     );
//     return result.isNotEmpty ? result.first : null;
//   }

//   Future<List<Map<String, dynamic>>> getAllUsers() async {
//     final db = await database;
//     return await db.query('usuarios', columns: ['id', 'correo']);
//   }

//   Future<int> deleteUser(int id) async {
//     final db = await database;
//     return await db.delete('usuarios', where: 'id = ?', whereArgs: [id]);
//   }
import 'package:path/path.dart';
import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');

    return await openDatabase(
      path,
      version: 3,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE usuarios (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT NOT NULL,
            correo TEXT NOT NULL UNIQUE,
            password TEXT NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE markers (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER NOT NULL,
            title TEXT NOT NULL,
            description TEXT NOT NULL,
            lat REAL NOT NULL,
            lng REAL NOT NULL,
            FOREIGN KEY (user_id) REFERENCES usuarios(id)
          )
        ''');
      },
    );
  }

  // ========== MÉTODOS PARA USUARIOS ==========
  Future<int> insertUser(String nombre, String correo, String password) async {
    final db = await database;
    return await db.insert('usuarios', {
      'nombre': nombre,
      'correo': correo,
      'password': password,
    });
  }

  Future<Map<String, dynamic>?> getUser(String correo, String password) async {
    final db = await database;
    final result = await db.query(
      'usuarios',
      where: 'correo = ? AND password = ?',
      whereArgs: [correo, password],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await database;
    return await db.query('usuarios');
  }

  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete('usuarios', where: 'id = ?', whereArgs: [id]);
  }

  // ========== MÉTODOS PARA MARCADORES ==========
  Future<int> insertMarker(int userId, Map<String, dynamic> marker) async {
    final db = await database;
    return await db.insert('markers', {
      'user_id': userId,
      'title': marker['title'],
      'description': marker['description'],
      'lat': marker['lat'],
      'lng': marker['lng'],
    });
  }

  Future<List<Map<String, dynamic>>> getUserMarkers(int userId) async {
    final db = await database;
    return await db.query('markers', where: 'user_id = ?', whereArgs: [userId]);
  }

  Future<int> updateMarker(int id, Map<String, dynamic> updates) async {
    final db = await database;
    return await db.update(
      'markers',
      updates,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteMarker(int id) async {
    final db = await database;
    return await db.delete('markers', where: 'id = ?', whereArgs: [id]);
  }
}
