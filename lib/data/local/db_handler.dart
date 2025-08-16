import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHandler {
  Database ? _database;
  
  Future<Database> get database async{
    // if(_database != null){
    //   return _database!;
    // }

     Directory directory = await getApplicationDocumentsDirectory();
     String path = join(directory.path,'mydatabase.db');
   _database= await openDatabase(path, version: 1,onCreate: (db, version) {
   db.execute('''
CREATE TABLE DatabaseTable {
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT,
  
}
 ''');
      
    }, );
    return _database!;

  }
  // singleton instace create
  // DbHandler._();
  // static final DbHandler getInstance = DbHandler._();

  insertData()async{
    Database db = await database;
 await db.rawInsert(
      'INSERT INTO DatabaseTable(id, title) VALUES(1, "Soudip")');
  
  // await  db.insert( 'DatabaseTable', {
  //     'id' : 1,
  //     'title' : "Soudip",
     
  //   });

  }

  readData() async{
    Database db = await database;
    
    final dataList = await db.query('DatabaseTable');
    return dataList;
  

  }

}