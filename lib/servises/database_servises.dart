import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseService{
  static Database ? _db;
 static final DatabaseService instance = DatabaseService._constractor();

final String _tasksTableName = "tasks";
final String _tasksIdColumnName = "id";
final String _tasksContentColumnName = "content";
final String _tasksStatusColumnName = "status";



 DatabaseService._constractor();

 Future <Database> get database async {
   _db = await getDatabase();
  return _db!;

 }

Future <Database> getDatabase() async{
try{
  
final databaseDirPath = await getDatabasesPath();
final databasePath = join(databaseDirPath, "master_db.db");

final database = await openDatabase(
  databasePath, 
  version: 1,
 onCreate: (db, version){
  db.execute(''' 
  CREATE TABLE $_tasksTableName {
  $_tasksIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
  $_tasksContentColumnName TEXT NOT NULL,
  $_tasksStatusColumnName INTEGER NOT NULL}
  ''');
});

}catch(err){
  print("Error: $err   ");
}
return database;
}

void addTask(String content) async{
  print("content: $content");
  final db = await database;
  await db.insert(_tasksTableName, {
    _tasksContentColumnName: content,
    _tasksStatusColumnName: 0,
  });
}





}