import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
class TodoDataBase{
  List toDoList =[];
  final _myBox=Hive.box('myBox');
  void createInitialData() {
    toDoList = [
      ["Make Tutorial", false],
      ["Do Exercise", false],
    ];
  }
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }
  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}