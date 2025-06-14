import 'package:educational_class/Provider/db_provider.dart';
import 'package:educational_class/Screens/bonus_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NameItem extends StatelessWidget {
  final int? id;
  final String name;
  final String gender;
  final String typeUser;
  final String? date;
  final String? time;
  final String? answer;
  final String code;
  final String classNumber;
  Function(int) deleteItem;
  Function(int) personAttend;

  NameItem({Key? key,
    this.id,
    this.time,
    this.answer,
    this.date,
    required this.personAttend,
    required this.code,
    required this.classNumber,
    required this.name,
    required this.gender,
    required this.typeUser,
    required this.deleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        if (time != null && time!.isNotEmpty) {
          var attend = await DatabaseProvider.instance.readAttendById(
              int.parse(id.toString()));
          Navigator.of(context).pushNamed(
              BonusScreen.routeName, arguments:  attend);
        }
      },
      contentPadding: EdgeInsets.all(15),
      dense: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      leading: time==null||time==""? IconButton(
            onPressed: (){

          showDialog(context: context, builder: (context)=>alertDialogAttendance(context));
        }, icon: Icon(Icons.qr_code_scanner,size: 25,))
          :
      null,
      title: Text(name,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18,color: Theme.of(context).primaryColor),),
      subtitle: Text(time==null||time==""?"${classNumber}_${code}": "${time}\n${classNumber}_${code}\n${answer}",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 15,color: Colors.black),),
      trailing:IconButton(
          onPressed: (){

            showDialog(context: context, builder: (context)=>alertDialog(context));
          },
          icon: Icon(Icons.delete,size: 25,)),
    );
  }
  alertDialog(context){
    return AlertDialog(
      alignment: Alignment.center,
      elevation: 1,
      title: const Text("هل تريد المسح ؟"),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      actions: [
        TextButton(onPressed: () async {
          deleteItem(id!);
          Navigator.of(context).pop();
          Fluttertoast.showToast(msg: "تم");
        },
          child: const Text("نعم",style: TextStyle(fontSize: 20),),
        ),
        TextButton(onPressed: (){
          Navigator.of(context).pop();
          Fluttertoast.showToast(msg: "الغاء");
        },
          child: const Text("لا",style: TextStyle(fontSize: 20)),

        ),
      ],
    );
  }
  alertDialogAttendance(context){
    return AlertDialog(
      alignment: Alignment.center,
      elevation: 1,
      title: Text("هل تريد تسجيل الحضور ل ${name} ؟"),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      actions: [
        TextButton(onPressed: () async {
          Navigator.of(context).pop();
          personAttend(id!);
        },
          child: const Text("نعم",style: TextStyle(fontSize: 20),),
        ),
        TextButton(onPressed: (){
          Navigator.of(context).pop();
          Fluttertoast.showToast(msg: "الغاء");
        },
          child: const Text("لا",style: TextStyle(fontSize: 20)),

        ),
      ],
    );
  }
}
