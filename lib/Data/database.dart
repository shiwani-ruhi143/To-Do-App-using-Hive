import 'package:hive/hive.dart';

class ToDoDataBase {
  //List
  List toDoList = [];

  //reference our box
  final _myBox = Hive.box('MyBox');

  //run this method if this ist time ever opening this app
  void createInitialData() {
    toDoList = [];
  }

  //load data from database
  void loadData() {
    toDoList = _myBox.get("ToDoList");
  }

  //update database
  void updateData() {
    _myBox.put("ToDoList", toDoList);
  }
}
