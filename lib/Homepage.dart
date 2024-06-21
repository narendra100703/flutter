import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mywork1/database.dart';
import 'package:mywork1/todo_tile.dart';
import 'package:mywork1/dialogBox.dart';
import 'package:hive_flutter/hive_flutter.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  late Box _myBox;
  TodoDataBase db = TodoDataBase();

  @override
  void initState() {
    super.initState();
    _setup();
  }

  Future<void> _setup() async {
    _myBox = await Hive.openBox('myBox');
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    setState(() {});
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;

    if (_myBox == null) {
      return Scaffold(
        backgroundColor: Colors.yellow[200],
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70.0,
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            " TODAY WORKS",
            style: TextStyle(fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 40,
                fontStyle: FontStyle.italic),
          ),
        ),

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: createNewTask,
        child: Icon(Icons.add,color: Colors.white,),
        shape: CircleBorder(),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskCompleted: db.toDoList[index][1],
            taskName: db.toDoList[index][0],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
