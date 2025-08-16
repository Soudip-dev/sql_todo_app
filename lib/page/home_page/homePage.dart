import 'package:flutter/material.dart';
import 'package:sqlflite_todo/data/local/db_handler.dart';
import 'package:sqlflite_todo/servises/database_servises.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DbHandler dbHandler = DbHandler();
  String task = "";
  int i =0;
  final DatabaseService _databaseService = DatabaseService.instance;
  void increment() {
    setState(() {
  i++;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _addTaskButton(),
    );
  }

  Widget _addTaskButton() {
    return FloatingActionButton(onPressed: (){
      dbHandler.insertData();
//       showDialog(context: context, builder: (_){
//         return AlertDialog(
//           title: Text("Add Task"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 onChanged: (value) {
//                   // _databaseService.addTask(value);
//                   // print(value);
//                   // task = value;
//                   setState(() {
                    
//                     // task = value;
//                   });
//                 },
//                 decoration: InputDecoration(
//                   hintText: "Enter Task...",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10)

//                   )
//                 ),
//               ),
//               SizedBox(height: 10,),
//               MaterialButton(
//                 child: Text("Add"),
//                 color: Colors.blue,
//                 onPressed: (){
//                   if( task == ""){
//                     return;
//                   }
//                 // Navigator.pop(context);
//                 _databaseService.addTask(task);
//                 setState(() {
//                   task = "";
//                  });
//                 Navigator.pop(context);
//               })
//             ],
// )

//         );
//         });
   
    }, child: Icon(Icons.add),);
  }
}

