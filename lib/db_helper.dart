import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;

  DBHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'notes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notes (id INTEGER PRIMARY KEY, content TEXT)',
        );
      },
    );
  }

  Future<int> addNote(String content) async {
    final db = await database;
    return await db.insert('notes', {'content': content});
  }

  Future<List<Map<String, dynamic>>> fetchNotes() async {
    final db = await database;
    return await db.query('notes');
  }

  Future<int> deleteNoteById(int id) async {
    final db = await database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
