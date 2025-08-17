import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHandler {
  Database ? _database;
  
  Future<Database?> get database async{
    if(_database != null){
      return _database!;
    }

     Directory directory = await getApplicationDocumentsDirectory();
     String path = join(directory.path,'myDatabase.db');
   _database= await openDatabase(path, version: 1,onCreate: (db, version) {
   db.execute('''
CREATE TABLE myDatabase (
  id INTEGER PRIMARY KEY,
  title TEXT
  )
 ''');
      
    }, );
    return _database!;

  }
  // singleton instace create
  // DbHandler._();
  // static final DbHandler getInstance = DbHandler._();

  insertData()async{
    Database ? db = await database;
 await db?.rawInsert(
      'INSERT INTO myDatabase(id, title) VALUES(1, soudip)');
  
  // await  db!.insert( 'myDatabase', {
  //     'id' : 1,
  //     'title' : 'soudip',
     
  //   });

  }

  readData() async{
    Database ? db = await database;
    
    final dataList = await db?.query('myDatabase');
    return dataList;
  

  }

}