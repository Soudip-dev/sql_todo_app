import 'package:flutter/material.dart';
import 'package:sqlflite_todo/data/local/db_handler.dart';
import 'package:sqlflite_todo/data/local/db_helper.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  List <Map<String, dynamic>> allNotes = [];
  // List <Map<String, dynamic>> allData = [];
  DBHelper  dbRef = DBHelper.getInstance;
  // DbHandler ? dbHandler;
  @override
  void initState() {
    super.initState();
    
    getNotes();
  }
  Future<void> getNotes()async{
    print("before allNotes +++++++++++++");
     allNotes= await   dbRef.getAllNotes();
    //  allNotes.forEach((element) {
    //   print(element.toString());
    //  });
     print("after allNotes +++++++++++++$allNotes");
     setState(() {
       
     });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Notes"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
print("button pressed");
      // await DbHandler().insertData();
        // print(data);
      //  print("Alldata: $allData");
          // DbHandler().getAllData();
         bool check= await dbRef.addNote(title: "Soudip", content: "Samanta");
          if(check){
           getNotes();
         }
        },
        child: Icon(Icons.add),
      ),
      body: allNotes.isNotEmpty ? ListView.builder(
        itemCount: allNotes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(allNotes[index][DBHelper.columnNoteTitle]),
            subtitle: Text(allNotes[index][DBHelper.columnNoteContent]),
          );
        },
      )
      :Center(     child: Text("No Data Yet !!!"),
    )
    );
  }
}