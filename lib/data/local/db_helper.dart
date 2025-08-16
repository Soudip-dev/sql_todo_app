
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  // Table and column names as static const
  static const String tableNote = "note";
  static const String columnNoteId = "id";
  static const String columnNoteTitle = "title";
  static const String columnNoteContent = "content";

  // Singleton instance
  DBHelper._();
  static final DBHelper getInstance = DBHelper._();

  Database? _db;

  // Get database instance
  Future<Database> getDB() async {
    _db ??= await _openDB();
    return _db!;
  }

  // Open database and create table if not exists
  Future<Database> _openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, "noteDB.db");
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
CREATE TABLE $tableNote (
  $columnNoteId INTEGER PRIMARY KEY AUTOINCREMENT,
  $columnNoteTitle TEXT,
  $columnNoteContent TEXT
)
''');
      },
    );
  }

  // Insert a note into the table
  Future<bool> addNote({required String title, required String content}) async {
    final db = await getDB();
    int rowsAffected = await db.insert(
      tableNote,
      {
        columnNoteTitle: title,
        columnNoteContent: content,
      },
    );
    return rowsAffected > 0;
  }

  // Get all notes from the table
  Future<List<Map<String, dynamic>>> getAllNotes() async {
    try {
      final db = await getDB();
      return await db.query(tableNote);
    } catch (err) {
      print("Error: $err");
      return [];
    }
  }
}



