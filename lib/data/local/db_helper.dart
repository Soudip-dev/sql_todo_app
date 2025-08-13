import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper{
  // singleton instace create
  final String TABLE_NOTE = "note";
  final String COLUMN_NOTE_ID = "id";
  final String COLUMN_NOTE_TITLE = "title";
  final String COLUMN_NOTE_CONTENT = "content";
  
  DBHelper._();
  static final DBHelper getInstance = DBHelper._();
// static  DBHelper getInstance(){
//     return DBHelper._();
  
//   }
Database ? myDB;
// db open>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
Future <Database>  getDB()async{
   myDB ??= await openDB();
   return myDB!;
}

  //  if(myDB == null){
  //   openDB();
  // }
  
  // return myDB!;


Future <Database> openDB()async{
 Directory appDir = await getApplicationDocumentsDirectory();
 String dbPath = join(appDir.path, "noteDB.db") ;

 return await openDatabase(dbPath, version: 1, onCreate: (db, version){
  
  // create all your tabels
  db.execute("CREATE TABLE $TABLE_NOTE {$COLUMN_NOTE_ID INTEGER PRIMARY KEY AUTOINCREMENT, $COLUMN_NOTE_TITLE TEXT, $COLUMN_NOTE_CONTENT TEXT}");

 });
 
}
// all queries>>>>>>>>>>>>>>>>>>>>
   
   Future<bool> addNote({required String title, required String content})async{
      //  data add function......
      print("title : $title , content : $content  ");
      print("add fun Called >>>>>>>>>>>>>>>>>>>>>");
      var db = await getDB();
     int rowsEffected = await  db.insert( TABLE_NOTE, {
      COLUMN_NOTE_TITLE : title,
      COLUMN_NOTE_CONTENT : content

     });

     return rowsEffected > 0;
   

   }

   Future <List<Map<String, dynamic>>> getAllNotes()async{
    print("get all notes fun called>>>>>>>>>>>>>>>>>>>>>>>");
    //  data list show function....
    
    var db = await getDB();
print("get all notes fun called>>>>>>>>>>>>>>>>>>>>>>>22222");
   List<Map<String, dynamic>> noteList = await db.query(TABLE_NOTE);
   print("get all notes fun called>>>>>>>>>>>>>>>>>>>>>>>3333");
   print(noteList.toString());
   print("get all notes fun called>>>>>>>>>>>>>>>>>>>>>>>22222");
   return noteList;


   }

    }



