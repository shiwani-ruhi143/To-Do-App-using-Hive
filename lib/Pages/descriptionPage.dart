import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DescrptionPage extends StatefulWidget {
  final DateTime date;
  final String taskName;
  final bool taskCompleted;
  final String taskDescription;

  const DescrptionPage(
      {super.key,
      required this.taskCompleted,
      required this.taskDescription,
      required this.date,
      required this.taskName});

  @override
  State<DescrptionPage> createState() => _DescrptionPageState();
}

class _DescrptionPageState extends State<DescrptionPage> {
  
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      child: Scaffold(
        
        backgroundColor: Color.fromARGB(255, 84, 91, 88),
        appBar: AppBar(
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          backgroundColor: Colors.black,
          title: Text(widget.taskName),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(30.r),
              child: Container(                
                width: double.infinity,
                // height: 30.h,
                decoration: BoxDecoration(color: Colors.black),
                child: Text(
                    "Created on : " +
                        widget.date.day.toString() +
                        "-" +
                        widget.date.month.toString() +
                        "-" +
                        widget.date.year.toString() +
                        " at " +
                        widget.date.hour.toString() +
                        ":" +
                        widget.date.minute.toString(),
                    style: TextStyle(color: Colors.white,fontSize: 20.sp,decoration: TextDecoration.underline),textAlign: TextAlign.center,),
              ),
            ),
            Padding(
              padding:  EdgeInsets.all(20.r),
              child: Text(
                "Description : " + widget.taskDescription,
                style: TextStyle(color: Colors.white,fontSize: 28.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
