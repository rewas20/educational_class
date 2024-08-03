import 'package:educational_class/Screens/view_attendance_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../Models/attendance.dart';
import '../Provider/db_provider.dart';

class DateAttendanceItem extends StatelessWidget {
  final String date;
  final String classNumber;
  Function(String) onOpen;
  Map<String, String> daysNames = {
    'Monday': 'الاثنين',
    'Tuesday': 'الثلاثاء',
    'Wednesday': 'الأربعاء',
    'Thursday': 'الخميس',
    'Friday': 'الجمعة',
    'Saturday': 'السبت',
    'Sunday': 'الأحد',
  };



  DateAttendanceItem({Key? key,
    required this.date,
    required this.classNumber,
    required this.onOpen
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final qur = MediaQuery.of(context).size.width/4;
    List<String> arrayDate =  date.split('/');
    String newDate = "${arrayDate[2]}-${arrayDate[1]}-${arrayDate[0]}";
    String getDay = DateFormat('EEEE').format(DateFormat('yyyy-MM-dd').parse(newDate));
    String day = daysNames[getDay]??'';
    return InkWell(
      onTap: () async {
        showDialog(context: context, builder: (context)=>AlertDialog(
          title: Text("فتح في اكسل؟"),
          titleTextStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.black),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          actionsPadding: EdgeInsets.all(10),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          alignment: Alignment.center,
          actions: [
            TextButton(
                onPressed: (){

                  Navigator.pop(context);
                  onOpen(date);
                  Fluttertoast.showToast(msg: "تم");
                },
                child: Text("نعم",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800))
            ),
            TextButton(
                onPressed: (){

                  Navigator.pop(context);
                  Navigator.of(context).pushNamed(ViewAttendanceScreen.routeName,arguments: {
                    'date': date,
                    'classNumber':classNumber

                  });
                  },
                child: Text("لا",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800))
            ),
          ],
        ));

      },
      onLongPress: () async {
        List<AttendanceModel> allAttendance = await DatabaseProvider.instance.readAllAttendTimeByClass(date,classNumber);
        var data =" اجتماع ($classNumber)($date)(${allAttendance.length})\n===========\nافراد\n=========";
        var boys ="\n===========\nولاد\n=========";
        var girls ="\n===========\nبنات\n=========";
        var counterPerson = 0;
        var counterLeader = 0;
        var counterMale = 0;
        var counterFemale = 0;
        allAttendance.forEach((type) {


            counterPerson++;
            data = "$data\n $counterPerson.\t${type.name}\t => ${type.time}";

        });
        allAttendance.forEach((gender) {

          if(gender.gender=="male"){
            counterMale++;
            boys = "$boys\n $counterMale.\t${gender.name}\t => ${gender.time}";
          }else if(gender.gender=="female") {
            counterFemale++;
            girls = "$girls\n $counterFemale.\t${gender.name}\t => ${gender.time}\t";
          }
        });

        Clipboard.setData(ClipboardData(text: data+"\n\n"+boys+girls));
        Fluttertoast.showToast(msg: "تم النسخ");

      },
      borderRadius: BorderRadius.circular(25),
      focusColor: Colors.black,
      splashColor: Colors.black,
      child:  Container(
        height: 100,
        width: qur*1.5,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(

          gradient: LinearGradient(
            colors: [
              Colors.blue.withOpacity(0.7),
              Colors.white.withOpacity(0.6),
              Theme.of(context).primaryColor.withOpacity(0.6)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
          ),
          boxShadow: const [
            BoxShadow(
                color: Colors.lightBlueAccent,
                blurRadius: 100,
                blurStyle: BlurStyle.inner
            )
          ],
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text("${day}\n$newDate",style:  TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: Colors.black.withOpacity(0.5))),
      ),
    );
  }
}