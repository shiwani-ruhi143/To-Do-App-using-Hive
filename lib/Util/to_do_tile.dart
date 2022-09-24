import 'package:flutter/material.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app/Pages/descriptionPage.dart';

class ToDoTile extends StatefulWidget {
  final DateTime date;
  final String taskname;
  final bool taskCompleted;
  final String taskDescription;
  final Function(bool?)? onchanged;
  Function(BuildContext)? deleteFunction;
  ToDoTile(
      {super.key,
      required this.taskDescription,
      required this.date,
      required this.onchanged,
      required this.taskCompleted,
      required this.taskname,
      required this.deleteFunction});

  @override
  State<ToDoTile> createState() => _ToDoTileState();
}

class _ToDoTileState extends State<ToDoTile> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(15.r),
              onPressed: widget.deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red,
            )
          ],
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DescrptionPage(
                        taskDescription: widget.taskDescription,
                        taskCompleted: widget.taskCompleted,
                        date: widget.date,
                        taskName: widget.taskname)));
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              padding: EdgeInsets.all(25.r),
              content: widget.taskCompleted
                  ? Text(
                      "Task Accomplished Already!!",
                      style: TextStyle(fontSize: 20.sp),
                    )
                  : Text(
                      "Task Not Completed Yet!!",
                      style: TextStyle(fontSize: 20.sp),
                    ),
              duration: Duration(seconds: 5),
              backgroundColor: widget.taskCompleted ? Colors.green : Colors.red,
              action: SnackBarAction(
                label: "Ok",
                onPressed: () {},
                textColor: Colors.white,
              ),
            ));
          },
          child: Container(
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(15.r)),
            child: Row(
              children: [
                //checkbox
                Checkbox(
                  value: widget.taskCompleted,
                  onChanged: widget.onchanged,
                  activeColor: Colors.green,
                  fillColor: MaterialStateProperty.all(Colors.green),
                ),

                //task name
                Text(
                  widget.taskname,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.sp,
                      decoration: widget.taskCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
                SizedBox(width: 70.w),
                Text(
                  widget.date.day.toString() +
                      ("/") +
                      (widget.date.month.toString() +
                          ("/") +
                          (widget.date.year.toString())),
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
