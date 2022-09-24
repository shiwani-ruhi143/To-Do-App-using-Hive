import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/Data/database.dart';
import 'package:to_do_app/Util/dialog_box.dart';
import 'package:to_do_app/Util/to_do_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference the hive box
  final _myBox = Hive.box('MyBox');
  ToDoDataBase db = ToDoDataBase();
  @override
  void initState() {
    //if this is the first time ever opening the app, then create default data
    if (_myBox.get("ToDoList") == null) {
      db.createInitialData();
    } else {
      //there already exits data
      db.loadData();
    }
    super.initState();
  }

  //text controller
  final _controller = TextEditingController();
  final _controller2 = TextEditingController();

  //list of to do tasks
  // List toDoList = [
  //   ["Make tutorial", true],
  //   ["Make tutorial", false],
  //   ["Make tutorial", true],
  // ];

  //checkbox tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateData();
  }

  //save new task
  void saveNewTask() {
    setState(() {
      db.toDoList
          .add([_controller.text, false, DateTime.now(), _controller2.text]);
      _controller.clear();
      _controller2.clear();
      print(db.toDoList.length);
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  //create a new task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
              controller: _controller,
              controller2: _controller2,
              onCancel: (){
                Navigator.pop(context);
                _controller.clear();
                _controller2.clear();
              },
              onSave: saveNewTask);
        });
  }

  //delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
      print(db.toDoList.length);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 84, 91, 88),
        appBar: AppBar(
          centerTitle: true,
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          backgroundColor: Colors.black,
          elevation: 5,
          title: Text(
            "TO-DO",
            style: TextStyle(
                color: Colors.white,
                fontSize: 27.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("object");
            createNewTask();
          },
          backgroundColor: Colors.black,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 30.r,
          ),
        ),
        body: db.toDoList.length == 0
            ? noTaskWidget()
            : ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: db.toDoList.length,
                itemBuilder: (context, index) {
                  return ToDoTile(
                      taskDescription: db.toDoList[index][3],
                      date: db.toDoList[index][2],
                      deleteFunction: (context) => deleteTask(index),
                      onchanged: (value) => checkBoxChanged(value, index),
                      taskCompleted: db.toDoList[index][1],
                      taskname: db.toDoList[index][0]);
                },
              ));
  }

  noTaskWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: createNewTask,
              child: Icon(Icons.add_circle, color: Colors.white, size: 75.r)),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "You have not created any tasks yet, tap on the add icon to create a task.",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
