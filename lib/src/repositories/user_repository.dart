import 'package:projeto_final_fltter/src/models/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserRepository {
  late Database _database;

  UserRepository() {
    _initDatabase();
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        return await db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, password TEXT)',
        );
      },
    );

    await insertUser(User(email: 'admin', password: 'admin'));

    return _database;
  }

  Future<void> insertUser(User user) async {
    final db = _database;
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<User>> users() async {
    var db = _database;

    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return User(
          id: maps[i]['id'],
          email: maps[i]['email'],
          password: maps[i]['password']);
    });
  }

  Future<void> updateUser(User user) async {
    final db = _database;

    await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> deleteUser(int id) async {
    final db = _database;

    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
