import 'package:path/path.dart';
import 'package:projeto_final_fltter/src/models/contact_model.dart';
import 'package:sqflite/sqflite.dart';

class ContactRepository {
  late Database _database;

  ContactRepository() {
    _initDatabase();
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'contacts_db.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        return await db.execute(
          'CREATE TABLE contacts(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, phone TEXT, email TEXT, lat REAL, lng REAL)',
        );
      },
    );

    // await insertContact(
    //     Contact(name: 'Admin', phone: '123456789', lat: 0, lng: 0));

    return _database;
  }

  Future<void> insertContact(Contact contact) async {
    if (!_database.isOpen) {
      await _initDatabase();
    }
    final db = _database;
    await db.insert(
      'contacts',
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Contact>> contacts() async {
    var db = _database;

    final List<Map<String, dynamic>> maps = await db.query('contacts');
    return List.generate(maps.length, (i) {
      return Contact(
        id: maps[i]['id'],
        name: maps[i]['name'],
        phone: maps[i]['phone'],
        lat: maps[i]['lat'],
        lng: maps[i]['lng'],
      );
    });
  }

  Future<void> updateContact(Contact contact) async {
    if (!_database.isOpen) {
      await _initDatabase();
    }
    final db = _database;

    await db.update(
      'contacts',
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  Future<void> deleteContact(int id) async {
    if (!_database.isOpen) {
      await _initDatabase();
    }
    final db = _database;

    await db.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
