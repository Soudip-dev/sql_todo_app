import 'package:flutter/material.dart';
import 'package:sqlflite_todo/data/local/db_handler.dart';
import 'package:sqlflite_todo/data/local/db_helper.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  DBHelper? dbHelper ;
  List <Map<String, dynamic>> allNotes = [
  ];
  
  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    getAllNotes();

    
  }

  Future <void> getAllNotes()async{
    print("getAllNotes() called");
    allNotes = await dbHelper!.getNotes();
    setState(() {
      
    });
    print(allNotes);
    
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Notes"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          // List<Map<String, dynamic>> noteList = [];
     await dbHelper!.insertNote({
      "title": "Subhodip",
      "description": "I'm a Python developer"
     
     });
     getAllNotes();
        },
        child: Icon(Icons.add),
      ),
      body: allNotes.isNotEmpty ? ListView.builder(
        itemCount: allNotes.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text(allNotes[index]['id'].toString()),
            ),
            title: Text(allNotes[index]['title']),
            subtitle: Text(allNotes[index]['description']),
          );
        },
      )
      :Center(     child: Text("No Data Yet !!!"),
    )
    );
  }
}