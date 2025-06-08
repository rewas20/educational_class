import 'dart:convert';
import 'dart:io';
import 'package:educational_class/Data/menu_items.dart';
import 'package:educational_class/Models/attendance.dart';
import 'package:educational_class/Models/menu_item.dart';
import 'package:educational_class/Models/person.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xls;
import 'package:universal_html/html.dart' show AnchorElement;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';
import '../Provider/db_provider.dart';
import 'DivideScreens/category_home_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "HOME_SCREEN";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ref = FirebaseDatabase.instance.ref();
  @override
  initState(){
    super.initState();
    refresh();
  }
  final items = ["الحضور","الاسماء"];
  var selected = "الحضور";

  Future<void> refresh() async {
    await DatabaseProvider.instance.database;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          PopupMenuButton<MenuItemModel>(
            onSelected: (item) => onSelected(context,item),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(
              minWidth: 200,
              maxWidth: 300,
            ),
            itemBuilder: (context) => [
              ...MenuItems.itemsFirst.map(buildItem).toList(),
              /*PopupMenuDivider(),
              ...MenuItems.itemsSecond.map(buildItem).toList(),*/
            ],
          )
        ],
        title: const Text("الفصل التعليمي",style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),),
        centerTitle: true,
        toolbarHeight: 70,
      ),
      body: Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: const CategoriesDivideScreen()
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(child: Text("Created By Rewas Safwat 🖤✨",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12,color: Colors.grey),),onPressed: () async {
                var url =Uri.parse( 'https://www.facebook.com/rewass.safout');
                    await launchUrl(url);

            }),
          )
        ],
      ),
    ),
    );

  }
  PopupMenuItem<MenuItemModel> buildItem(MenuItemModel item) => PopupMenuItem(
    value: item,
      child: Row(
          children: [
            Icon(item.icon,color: Colors.black,),
            const SizedBox(width: 12,),
            Text(item.text)
          ]
      ),
  );

  onSelected(BuildContext context, MenuItemModel item) {
    switch(item){
      case MenuItems.itemImportData:
        showDialog(context: context, builder: (context)=>alertDialog(context,item));
        break;
      case MenuItems.itemUploadData:
        showDialog(context: context, builder: (context)=>alertDialog(context,item));
        break;
      /*case MenuItems.itemTotalGrade:
        showDialog(context: context, builder: (context) => const Center(child: CircularProgressIndicator(),));
        setState((){
          sheetExcel();
        });
        break;*/
        
    }
  }

  alertDialog(context,item){
    return AlertDialog(
      alignment: Alignment.center,
      elevation: 1,
      title: item.text==MenuItems.itemImportData.text?const Text("هل تريد تحميل البيانات من السيرفر ؟"):const Text("هل تريد رفع البيانات الي السيرفر ؟"),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            child: DropdownButtonFormField(
              elevation: 16,
              value: selected,
              onChanged: (String? value) {
                setState((){
                  selected = value!;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
              items: items
                  .map((item) {
                return DropdownMenuItem<String>(
                  value:  item,
                  child: Text(item,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Theme.of(context).primaryColor)),
                );
              }).toList(),

              validator: (value){
                if(value==null||value==" "){
                  return "اختار";
                }
              },

            ),
          ),
          const Text("النوع",style:  TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.black))
        ],
      ),
      actions: [
        TextButton(onPressed: () async {
          showDialog(context: context, builder: (context)=> Dialog(insetPadding: EdgeInsets.symmetric(horizontal: 180),child:  CircularProgressIndicator(),backgroundColor: Colors.transparent,alignment: Alignment.center,),barrierDismissible: false,);
          if(item.text==MenuItems.itemUploadData.text&& selected == "الحضور"){
            final snapshot = await ref.get();
            final checkAttend = await DatabaseProvider.instance.checkAllAttend();


            if(checkAttend){
              var mapAttend = {};
              final allAttend = await DatabaseProvider.instance.readAllAttend();
              if(snapshot.exists){
                var map = snapshot.value as Map<dynamic,dynamic>;
                if(snapshot.child("attendance").exists){
                  mapAttend = snapshot.value as Map<dynamic,dynamic>;
                  for(AttendanceModel attend in allAttend){
                    mapAttend['attendance'][attend.date.replaceAll("/", "-")+"_"+attend.name+"_"+attend.classNumber.replaceAll(".", "*")+"_"+attend.code] = attend.getMap();
                  }
                    await ref.update({
                      "attendance":mapAttend['attendance'],
                      "persons":map['persons'],
                    });
                }else{
                  for(AttendanceModel attend in allAttend){
                    mapAttend[attend.date.replaceAll("/", "-")+"_"+attend.name+"_"+attend.classNumber.replaceAll(".", "*")+"_"+attend.code] = attend.getMap();
                  }
                  await ref.update({
                    "attendance":mapAttend,
                    "persons":map['persons'],
                  });
                }
              }else{
                final allAttend = await DatabaseProvider.instance.readAllAttend();

                for(AttendanceModel attend in allAttend){
                  mapAttend[attend.date.replaceAll("/", "-")+"_"+attend.name+"_"+attend.classNumber.replaceAll(".", "*")+"_"+attend.code] = attend.getMap();
                }

                await ref.set({
                  "attendance":mapAttend,
                });
              }

              Fluttertoast.showToast(msg: "تم الرفع");
            }else{
              Fluttertoast.showToast(msg: "لا يوجد بيانات لرفعها");
            }
          }
          if(item.text==MenuItems.itemUploadData.text&& selected == "الاسماء"){
            final snapshot = await ref.get();
            final checkPerson = await DatabaseProvider.instance.checkAllPerson();
            if(checkPerson){
              var mapPersons = {};
              final allPersons = await DatabaseProvider.instance.readAllPersons();
              if(snapshot.exists){
                var map = snapshot.value as Map<dynamic,dynamic>;
                if(snapshot.child('persons').exists){
                  mapPersons = snapshot.value as Map<dynamic,dynamic>;
                  for(PersonModel person in allPersons){
                    mapPersons['persons'][person.name+"_"+person.classNumber.replaceAll(".", "*")+"_"+person.code] = person.getMap();
                    await ref.update({
                      "attendance":map['attendance'],
                      "persons": mapPersons['persons'],
                    });
                  }
                }else{
                  for(PersonModel person in allPersons){
                    mapPersons[person.name+"_"+person.classNumber.replaceAll(".", "*")+"_"+person.code] = person.getMap();
                  }
                  await ref.set({
                    "attendance":map['attendance'],
                    "persons": mapPersons,
                  });
                }

              }else{
                for(PersonModel person in allPersons){
                  mapPersons[person.name+"_"+person.classNumber.replaceAll(".", "*")+"_"+person.code] = person.getMap();
                }
                await ref.set({
                  "persons": mapPersons,
                });
              }
              Fluttertoast.showToast(msg: "تم الرفع");
            }else{
              Fluttertoast.showToast(msg: "لا يوجد بيانات لرفعها");
            }
          }else if(item.text==MenuItems.itemImportData.text&& selected == "الاسماء"){
            final snapshotPersons = await ref.child('persons').get();
            if(snapshotPersons.exists){
              /*if(await DatabaseProvider.instance.checkAllPerson()){
                final allPersons = await DatabaseProvider.instance.readAllPersons();
                allPersons.forEach(( element) async {
                  int id = element.id as int;
                  //await DatabaseProvider.instance.deletePerson(id);
                });
              }*/
              Map<dynamic,dynamic> persons = snapshotPersons.value as Map<dynamic,dynamic>;
              persons.forEach((key, value) async {
                Map<dynamic,dynamic> person = value as Map<dynamic,dynamic>;
                final search = await DatabaseProvider.instance.checkPersonCode(person['name'],person['class_number'],person['code']);
                if(search){
                  await DatabaseProvider.instance.updatePerson(PersonModel(id: person['_id'],name: person['name'], gender: person['gender'], typeUser: person['typeUser'],code: person['code'],classNumber: person['class_number']));

                }else
                if(!search){

                  await DatabaseProvider.instance.createPerson(PersonModel(name: person['name'], gender: person['gender'], typeUser: person['typeUser'],code: person['code'],classNumber: person['class_number']));
                }

              });
              Fluttertoast.showToast(msg: "تم تحميل البيانات للافراد");
            }else{
              Fluttertoast.showToast(msg: "لا يوجد بيانات");

            }

          }else if(item.text==MenuItems.itemImportData.text&& selected == "الحضور"){

            final snapshotAttendance = await ref.child('attendance').get();
            if(snapshotAttendance.exists){
              /*if(await DatabaseProvider.instance.checkAllAttend()){
                final allAttendance = await DatabaseProvider.instance.readAllAttendByDate();
                allAttendance.forEach((element) async {
                  //await DatabaseProvider.instance.deleteAttendByDate(element);
                });
              }*/
              Map<dynamic,dynamic> attendance = snapshotAttendance.value as Map<dynamic,dynamic>;
              attendance.forEach((key, value) async {
                Map<dynamic,dynamic> attend = value as Map<dynamic,dynamic>;
                final search = await DatabaseProvider.instance.checkAttend(attend['name'],attend['date'],attend['code'],attend['class_number']);
                if(search){
                  await DatabaseProvider.instance.updateAttend(AttendanceModel(id: attend['_id'],name: attend['name'], gender: attend['gender'], typeUser: attend['typeUser'], date: attend['date'], time: attend['time'],classNumber: attend['class_number'],
                      code: attend['code'],total: attend['total'],answer: attend['answer'],grade: attend['grade']));
                }else
                if(!search){

                  await DatabaseProvider.instance.createAttend(AttendanceModel(name: attend['name'], gender: attend['gender'], typeUser: attend['typeUser'], date: attend['date'], time: attend['time'],classNumber: attend['class_number'],
                      code: attend['code'],total: attend['total'],answer: attend['answer'],grade: attend['grade']));
                }

              });
              Fluttertoast.showToast(msg: "تم تحميل بيانات الحضور");
            }
            else{
              Fluttertoast.showToast(msg: "لا يوجد بيانات");
              
            }
          }
          Navigator.of(context).pop();
          Navigator.of(context).pop();
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
  Future sheetExcel() async{
    List<String> letters = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
    int totalGrade=0,total=0;
    List<PersonModel> persons = await DatabaseProvider.instance.readAllPersons();
    final xls.Workbook workbook =  xls.Workbook();
    final xls.Worksheet sheet = workbook.worksheets[0];
    sheet.name = "افراد";

    sheet.getRangeByName('${letters[0]}1').setText("الاسم");
    sheet.getRangeByName('${letters[1]}1').setText("الرتبه");
    sheet.getRangeByName('${letters[2]}1').setText("رقم الرهط");
    sheet.getRangeByName('${letters[3]}1').setText("اسم الرهط");
    sheet.getRangeByName('${letters[4]}1').setText("درجة الحضور والاداوات");
    sheet.getRangeByName('${letters[5]}1').setText("البونص");
    sheet.getRangeByName('${letters[6]}1').setText("تقيم الفرد");
    sheet.getRangeByName('${letters[7]}1').setText("تقيم الكشكول");
    sheet.getRangeByName('${letters[8]}1').setText("المجموع");

    final allAttendance = await DatabaseProvider.instance.readAllAttend();
    int numberRowSheet = 2;
    persons.forEach((element) async {
      sheet.getRangeByName('${letters[0]}${numberRowSheet}').setText(element.name);
      sheet.getRangeByName('${letters[1]}${numberRowSheet}').setText(element.typeUser);
      sheet.getRangeByName('${letters[2]}${numberRowSheet}').setText(element.classNumber != null && element.classNumber != "" && element.classNumber != "null" ? element.classNumber : "");
      sheet.getRangeByName('${letters[3]}${numberRowSheet}').setText(element.code != null && element.code != "" && element.code != "null" ? element.code : "");
      totalGrade=0;total=0;


        allAttendance.forEach((attend) {
          if(element.name==attend.name){
            totalGrade += (attend.grade!.isNotEmpty && attend.grade!=null)? int.parse(attend.grade.toString()??'') : 0;
            total += attend.total!.isNotEmpty && attend.total!=null? int.parse(attend.total.toString()??''):0;
          }
        });
        sheet.getRangeByName('${letters[4]}${numberRowSheet}').setText(totalGrade.toString());
        sheet.getRangeByName('${letters[5]}${numberRowSheet}').setText(total.toString());
        numberRowSheet++;
    });
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    if(kIsWeb){
      AnchorElement(href: 'data:application/octet-srteam;charset=utf-16le;based64,${base64.encode(bytes)}')
        ..setAttribute('download', "TotalGrade.xlsx")..click();
      Navigator.pop(context);
    }else{
      final String path =(await getApplicationSupportDirectory()).path;
      final String fileName = "$path/TotalGrade.xlsx";
      try{
        await File(fileName).writeAsBytes(bytes,flush: true);
      }on FileSystemException catch(e){
        Fluttertoast.showToast(msg: "wrong");
      }
      OpenFile.open(fileName);
      Navigator.pop(context);
    }
  }
}

