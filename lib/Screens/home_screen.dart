import 'dart:convert';
import 'dart:io';
import 'package:educational_class/Data/menu_items.dart';
import 'package:educational_class/Models/attendance.dart';
import 'package:educational_class/Models/menu_item.dart';
import 'package:educational_class/Models/person.dart';
import 'package:educational_class/Models/question.dart';
import 'package:educational_class/Provider/db_provider.dart';
import 'package:educational_class/Screens/login_screen.dart';
import 'package:educational_class/Services/auth_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xls;
import 'package:universal_html/html.dart' show AnchorElement;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';
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
          Container(
            width: 48,
            height: 48,
            child: PopupMenuButton<MenuItemModel>(
            onSelected: (item) => onSelected(context,item),
              padding: EdgeInsets.zero,
              icon: Icon(Icons.more_vert, color: Colors.white),
              position: PopupMenuPosition.under,
              itemBuilder: (context) => [
                ...MenuItems.itemsFirst.map(buildItem).toList(),
                PopupMenuDivider(),
                ...MenuItems.itemsSecond.map(buildItem).toList(),
                PopupMenuDivider(),

                PopupMenuItem<MenuItemModel>(
                  value: MenuItemModel(
                    text: "تسجيل الخروج",
                    icon: Icons.logout,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.black),
                      const SizedBox(width: 12),
                      Text("تسجيل الخروج")
                    ]
                  ),
                ),
              ],
            ),
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
      case MenuItems.itemTotalGrade:
        excelSheetTotalGrade(context);
        break;
      default:
        if (item.text == "تسجيل الخروج") {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("تسجيل الخروج"),
              content: const Text("هل أنت متأكد من تسجيل الخروج؟"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("إلغاء"),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context); // Close dialog
                    await AuthService().signOut();
                    if (mounted) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        LoginScreen.routeName,
                        (route) => false,
                      );
                    }
                  },
                  child: const Text("تأكيد"),
                ),
              ],
            ),
          );
        }
        break;
    }
  }

  alertDialog(context,item){
    bool isLoading = false;
    return StatefulBuilder(
      builder: (context, setState) {
    return AlertDialog(
      alignment: Alignment.center,
      elevation: 1,
          title: item.text==MenuItems.itemImportData.text
              ? const Text("هل تريد تحميل البيانات من السيرفر ؟")
              : const Text("هل تريد رفع البيانات الي السيرفر ؟"),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isLoading)
                const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: CircularProgressIndicator(),
                ),
              Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            child: DropdownButtonFormField(
              elevation: 16,
              value: selected,
                      onChanged: isLoading ? null : (String? value) {
                        setState(() {
                  selected = value!;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
                      items: items.map((item) {
                return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item, style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor
                          )),
                );
              }).toList(),
                      validator: (value) {
                        if(value==null||value==" ") {
                  return "اختار";
                }
                        return null;
                      },
                    ),
                  ),
                  const Text("النوع", style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black
                  ))
                ],
              ),
        ],
      ),
      actions: [
            TextButton(
              onPressed: isLoading ? null : () async {
                setState(() {
                  isLoading = true;
                });
                
                try {
                  if(item.text==MenuItems.itemUploadData.text && selected == "الاسماء") {
            final snapshot = await ref.get();
            final checkPerson = await DatabaseProvider.instance.checkAllPerson();
                    
                    if(!checkPerson) {
                      Navigator.of(context).pop();
                      Fluttertoast.showToast(
                        msg: "لا يوجد بيانات لرفعها",
                        backgroundColor: Colors.orange,
                      );
                      return;
                    }

              var mapPersons = {};
              final allPersons = await DatabaseProvider.instance.readAllPersons();
                    
                    if(snapshot.exists) {
                var map = snapshot.value as Map<dynamic,dynamic>;
                      if(snapshot.child('persons').exists) {
                  mapPersons = snapshot.value as Map<dynamic,dynamic>;
                        for(PersonModel person in allPersons) {
                    mapPersons['persons'][person.name+"_"+person.classNumber.replaceAll(".", "*")+"_"+person.code] = person.getMap();
                        }
                    await ref.update({
                          "attendance": map['attendance'],
                      "persons": mapPersons['persons'],
                    });
                      } else {
                        for(PersonModel person in allPersons) {
                    mapPersons[person.name+"_"+person.classNumber.replaceAll(".", "*")+"_"+person.code] = person.getMap();
                  }
                  await ref.set({
                          "attendance": map['attendance'],
                    "persons": mapPersons,
                  });
                }
                    } else {
                      for(PersonModel person in allPersons) {
                  mapPersons[person.name+"_"+person.classNumber.replaceAll(".", "*")+"_"+person.code] = person.getMap();
                }
                await ref.set({
                  "persons": mapPersons,
                });
              }
                    
                    Navigator.of(context).pop();
                    Fluttertoast.showToast(
                      msg: "تم رفع البيانات بنجاح",
                      backgroundColor: Colors.green,
                    );
                  } else if(item.text==MenuItems.itemImportData.text && selected == "الاسماء") {
                    final snapshotPersons = await ref.child('persons').get();
                    
                    if(!snapshotPersons.exists) {
                      Navigator.of(context).pop();
                      Fluttertoast.showToast(
                        msg: "لا يوجد بيانات للتحميل",
                        backgroundColor: Colors.orange,
                      );
                      return;
                    }

              Map<dynamic,dynamic> persons = snapshotPersons.value as Map<dynamic,dynamic>;
                    int totalPersons = persons.length;
                    int processedPersons = 0;
                    
                    for(var entry in persons.entries) {
                      Map<dynamic,dynamic> person = entry.value as Map<dynamic,dynamic>;
                      final search = await DatabaseProvider.instance.checkPersonCode(
                        person['name'],
                        person['class_number'],
                        person['code']
                      );
                      
                      if(search) {
                        await DatabaseProvider.instance.updatePerson(
                          PersonModel(
                            id: person['_id'],
                            name: person['name'],
                            gender: person['gender'],
                            typeUser: person['typeUser'],
                            code: person['code'],
                            classNumber: person['class_number']
                          )
                        );
                      } else {
                        await DatabaseProvider.instance.createPerson(
                          PersonModel(
                            name: person['name'],
                            gender: person['gender'],
                            typeUser: person['typeUser'],
                            code: person['code'],
                            classNumber: person['class_number']
                          )
                        );
                      }
                      
                      processedPersons++;
                      setState(() {
                        // Update progress in the dialog
                      });
                    }
                    
                    Navigator.of(context).pop();
                    Fluttertoast.showToast(
                      msg: "تم تحميل $processedPersons من $totalPersons فرد بنجاح",
                      backgroundColor: Colors.green,
                    );
                  } else if(item.text==MenuItems.itemUploadData.text && selected == "الحضور") {
                    try {
                      final snapshot = await ref.get();
                      final checkAttend = await DatabaseProvider.instance.checkAllAttend();
                      
                      if(!checkAttend) {
                        Navigator.of(context).pop();
                        Fluttertoast.showToast(
                          msg: "لا يوجد بيانات حضور لرفعها",
                          backgroundColor: Colors.orange,
                        );
                        return;
                      }

                      var mapAttend = {};
                      final allAttend = await DatabaseProvider.instance.readAllAttend();
                      
                      if(snapshot.exists) {
                        var map = snapshot.value as Map<dynamic,dynamic>;
                        if(snapshot.child("attendance").exists) {
                          mapAttend = snapshot.value as Map<dynamic,dynamic>;
                          for(AttendanceModel attend in allAttend) {
                            mapAttend['attendance'][attend.date.replaceAll("/", "-")+"_"+attend.name+"_"+attend.classNumber.replaceAll(".", "*")+"_"+attend.code] = attend.getMap();
                          }
                          await ref.update({
                            "attendance": mapAttend['attendance'],
                            "persons": map['persons'],
                          });
                        } else {
                          for(AttendanceModel attend in allAttend) {
                            mapAttend[attend.date.replaceAll("/", "-")+"_"+attend.name+"_"+attend.classNumber.replaceAll(".", "*")+"_"+attend.code] = attend.getMap();
                          }
                          await ref.update({
                            "attendance": mapAttend,
                            "persons": map['persons'],
                          });
                        }
                      } else {
                        for(AttendanceModel attend in allAttend) {
                          mapAttend[attend.date.replaceAll("/", "-")+"_"+attend.name+"_"+attend.classNumber.replaceAll(".", "*")+"_"+attend.code] = attend.getMap();
                        }
                        await ref.set({
                          "attendance": mapAttend,
                        });
                      }
                      
                      Navigator.of(context).pop();
                      Fluttertoast.showToast(
                        msg: "تم رفع بيانات الحضور بنجاح",
                        backgroundColor: Colors.green,
                      );
                    } catch (e) {
                      Navigator.of(context).pop();
                      Fluttertoast.showToast(
                        msg: "حدث خطأ أثناء رفع بيانات الحضور: ${e.toString()}",
                        backgroundColor: Colors.red,
                      );
                    }
                  } else if(item.text==MenuItems.itemImportData.text && selected == "الحضور") {
                    try {
            final snapshotAttendance = await ref.child('attendance').get();
                      
                      if(!snapshotAttendance.exists) {
                        Navigator.of(context).pop();
                        Fluttertoast.showToast(
                          msg: "لا يوجد بيانات حضور للتحميل",
                          backgroundColor: Colors.orange,
                        );
                        return;
                      }

              Map<dynamic,dynamic> attendance = snapshotAttendance.value as Map<dynamic,dynamic>;
                      int totalAttendance = attendance.length;
                      int processedAttendance = 0;
                      int batchSize = 10; // Process 10 records at a time
                      List<Map<dynamic,dynamic>> batch = [];
                      
                      // Show progress dialog
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => AlertDialog(
                          title: const Text("جاري تحميل بيانات الحضور"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const CircularProgressIndicator(),
                              const SizedBox(height: 16),
                              Text(
                                "تم تحميل $processedAttendance من $totalAttendance سجل",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      );

                      for(var entry in attendance.entries) {
                        batch.add(entry.value as Map<dynamic,dynamic>);
                        
                        if(batch.length >= batchSize) {
                          await _processAttendanceBatch(batch);
                          processedAttendance += batch.length;
                          
                          // Update progress dialog
                          if(mounted) {
                            Navigator.of(context).pop(); // Remove old dialog
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => AlertDialog(
                                title: const Text("جاري تحميل بيانات الحضور"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const CircularProgressIndicator(),
                                    const SizedBox(height: 16),
                                    Text(
                                      "تم تحميل $processedAttendance من $totalAttendance سجل",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          
                          batch.clear();
                        }
                      }
                      
                      // Process remaining records
                      if(batch.isNotEmpty) {
                        await _processAttendanceBatch(batch);
                        processedAttendance += batch.length;
                      }
                      
                      // Close progress dialog
                      if(mounted) {
                        Navigator.of(context).pop();
                      }
                      Navigator.of(context).pop();

                      // Show success message
                      Fluttertoast.showToast(
                        msg: "تم تحميل $processedAttendance من $totalAttendance سجل حضور بنجاح",
                        backgroundColor: Colors.green,
                      );
                    } catch (e) {
                      if(mounted) {
                        Navigator.of(context).pop(); // Close progress dialog
                      }
                      Fluttertoast.showToast(
                        msg: "حدث خطأ أثناء تحميل بيانات الحضور: ${e.toString()}",
                        backgroundColor: Colors.red,
                      );
                    }
                  }
                } catch (e) {
          Navigator.of(context).pop();
                  Fluttertoast.showToast(
                    msg: "حدث خطأ: ${e.toString()}",
                    backgroundColor: Colors.red,
                  );
                }
              },
              child: Text(
                isLoading ? "جاري المعالجة..." : "نعم",
                style: const TextStyle(fontSize: 20),
              ),
            ),
            TextButton(
              onPressed: isLoading ? null : () {
          Navigator.of(context).pop();
                Fluttertoast.showToast(msg: "تم الإلغاء");
              },
              child: const Text("لا", style: TextStyle(fontSize: 20)),
            ),
          ],
        );
      }
    );
  }

  // Helper method to process attendance batch
  Future<void> _processAttendanceBatch(List<Map<dynamic,dynamic>> batch) async {
    for(var attend in batch) {
      final search = await DatabaseProvider.instance.checkAttend(
        attend['name'],
        attend['date'],
        attend['code'],
        attend['class_number']
      );
      
      if(search) {
        await DatabaseProvider.instance.updateAttend(
          AttendanceModel(
            id: attend['_id'],
            name: attend['name'],
            gender: attend['gender'],
            typeUser: attend['typeUser'],
            date: attend['date'],
            time: attend['time'],
            classNumber: attend['class_number'],
            code: attend['code'],
            total: attend['total'],
            answer: attend['answer'],
            grade: attend['grade']
          )
        );
      } else {
        await DatabaseProvider.instance.createAttend(
          AttendanceModel(
            name: attend['name'],
            gender: attend['gender'],
            typeUser: attend['typeUser'],
            date: attend['date'],
            time: attend['time'],
            classNumber: attend['class_number'],
            code: attend['code'],
            total: attend['total'],
            answer: attend['answer'],
            grade: attend['grade']
          )
        );
      }
    }
  }

  Future<void> excelSheetTotalGrade(BuildContext context) async{
    List<String> letters = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
    final xls.Workbook workbook = xls.Workbook();
    final xls.Worksheet sheet = workbook.worksheets[0];
    final xls.Worksheet sheet2 = workbook.worksheets.addWithName("الصف الثاني");
    final xls.Worksheet sheet3 = workbook.worksheets.addWithName("الصف الثالث");
    final xls.Worksheet sheet4 = workbook.worksheets.addWithName("الصف الرابع");
    sheet.name = "الصف الاول";
    sheet.getRangeByName('${letters[0]}1').setText("الاسم");
    sheet.getRangeByName('${letters[1]}1').setText("كود");
    sheet.getRangeByName('${letters[2]}1').setText("فصل");
    sheet.getRangeByName('${letters[3]}1').setText("رقم");
    sheet.getRangeByName('${letters[4]}1').setText("المجموع");
    sheet.getRangeByName('${letters[5]}1').setText("التوارخ");
    int numberRowSheet = 2;
    List<PersonModel> personsEC1 =
    await DatabaseProvider.instance.readAllPersonByClassNumber("EC.1");
    personsEC1.forEach((person) async{
      int count = 0;
      List<String> dates = [];

      List<AttendanceModel> attends =
        await DatabaseProvider.instance.readAllAttendsByCodeAndClassNumber(person.name, person.code, person.classNumber);
      if(attends.length>0){
        sheet.getRangeByName('${letters[0]}${numberRowSheet}').setText(person.name);
        sheet.getRangeByName('${letters[1]}${numberRowSheet}').setText("${person.classNumber}_${person.code}");
        sheet.getRangeByName('${letters[2]}${numberRowSheet}').setText(person.classNumber);
        sheet.getRangeByName('${letters[3]}${numberRowSheet}').setText(person.code);
        count = attends.fold(0, (sum, att) => sum + (int.parse(att.total.toString())));
        sheet.getRangeByName('${letters[4]}${numberRowSheet}').setText(count.toString());
        dates = attends
            .map((att) => att.date)
            .where((date) => date.isNotEmpty) // optional: skip empty strings
            .toList();

        String datesString = dates.join(', ');

        sheet.getRangeByName('${letters[5]}${numberRowSheet}').setText(datesString);
        numberRowSheet++;
      }
    });

    sheet2.getRangeByName('${letters[0]}1').setText("الاسم");
    sheet2.getRangeByName('${letters[1]}1').setText("كود");
    sheet2.getRangeByName('${letters[2]}1').setText("فصل");
    sheet2.getRangeByName('${letters[3]}1').setText("رقم");
    sheet2.getRangeByName('${letters[4]}1').setText("المجموع");
    sheet2.getRangeByName('${letters[5]}1').setText("التوارخ");

    int numberRowSheet2 = 2;
    List<PersonModel> personsEC2 =
    await DatabaseProvider.instance.readAllPersonByClassNumber("EC.2");
    personsEC2.forEach((person) async{
      int count = 0;
      List<String> dates = [];

      List<AttendanceModel> attends =
      await DatabaseProvider.instance.readAllAttendsByCodeAndClassNumber(person.name, person.code, person.classNumber);
      if(attends.length>0){
        sheet2.getRangeByName('${letters[0]}${numberRowSheet2}').setText(person.name);
        sheet2.getRangeByName('${letters[1]}${numberRowSheet2}').setText("${person.classNumber}_${person.code}");
        sheet2.getRangeByName('${letters[2]}${numberRowSheet2}').setText(person.classNumber);
        sheet2.getRangeByName('${letters[3]}${numberRowSheet2}').setText(person.code);
        count = attends.fold(0, (sum, att) => sum + (int.parse(att.total.toString())));
        sheet2.getRangeByName('${letters[4]}${numberRowSheet2}').setText(count.toString());
        dates = attends
            .map((att) => att.date)
            .where((date) => date.isNotEmpty) // optional: skip empty strings
            .toList();

        String datesString = dates.join(', ');

        sheet2.getRangeByName('${letters[5]}${numberRowSheet2}').setText(datesString);
        numberRowSheet2++;
      }
    });

    sheet3.getRangeByName('${letters[0]}1').setText("الاسم");
    sheet3.getRangeByName('${letters[1]}1').setText("كود");
    sheet3.getRangeByName('${letters[2]}1').setText("فصل");
    sheet3.getRangeByName('${letters[3]}1').setText("رقم");
    sheet3.getRangeByName('${letters[4]}1').setText("المجموع");
    sheet3.getRangeByName('${letters[5]}1').setText("التوارخ");

    int numberRowSheet3 = 2;
    List<PersonModel> personsEC3 =
    await DatabaseProvider.instance.readAllPersonByClassNumber("EC.3");
    personsEC3.forEach((person) async{
      int count = 0;
      List<String> dates = [];

      List<AttendanceModel> attends =
      await DatabaseProvider.instance.readAllAttendsByCodeAndClassNumber(person.name, person.code, person.classNumber);
      if(attends.length>0){
        sheet3.getRangeByName('${letters[0]}${numberRowSheet3}').setText(person.name);
        sheet3.getRangeByName('${letters[1]}${numberRowSheet3}').setText("${person.classNumber}_${person.code}");
        sheet3.getRangeByName('${letters[2]}${numberRowSheet3}').setText(person.classNumber);
        sheet3.getRangeByName('${letters[3]}${numberRowSheet3}').setText(person.code);
        count = attends.fold(0, (sum, att) => sum + (int.parse(att.total.toString())));
        sheet3.getRangeByName('${letters[4]}${numberRowSheet3}').setText(count.toString());
        dates = attends
            .map((att) => att.date)
            .where((date) => date.isNotEmpty) // optional: skip empty strings
            .toList();

        String datesString = dates.join(', ');

        sheet3.getRangeByName('${letters[5]}${numberRowSheet3}').setText(datesString);
        numberRowSheet3++;
      }
    });

    sheet4.getRangeByName('${letters[0]}1').setText("الاسم");
    sheet4.getRangeByName('${letters[1]}1').setText("كود");
    sheet4.getRangeByName('${letters[2]}1').setText("فصل");
    sheet4.getRangeByName('${letters[3]}1').setText("رقم");
    sheet4.getRangeByName('${letters[4]}1').setText("المجموع");
    sheet4.getRangeByName('${letters[5]}1').setText("التوارخ");

    int numberRowSheet4 = 2;
    List<PersonModel> personsEC4 =
    await DatabaseProvider.instance.readAllPersonByClassNumber("EC.4");
    personsEC4.forEach((person) async{
      int count = 0;
      List<String> dates = [];

      List<AttendanceModel> attends =
      await DatabaseProvider.instance.readAllAttendsByCodeAndClassNumber(person.name, person.code, person.classNumber);
      if(attends.length>0){
        sheet4.getRangeByName('${letters[0]}${numberRowSheet4}').setText(person.name);
        sheet4.getRangeByName('${letters[1]}${numberRowSheet4}').setText("${person.classNumber}_${person.code}");
        sheet4.getRangeByName('${letters[2]}${numberRowSheet4}').setText(person.classNumber);
        sheet4.getRangeByName('${letters[3]}${numberRowSheet4}').setText(person.code);
        count = attends.fold(0, (sum, att) => sum + (int.parse(att.total.toString())));
        sheet4.getRangeByName('${letters[4]}${numberRowSheet4}').setText(count.toString());
        dates = attends
            .map((att) => att.date)
            .where((date) => date.isNotEmpty) // optional: skip empty strings
            .toList();

        String datesString = dates.join(', ');

        sheet4.getRangeByName('${letters[5]}${numberRowSheet4}').setText(datesString);
        numberRowSheet4++;
      }
    });
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    final time = DateFormat('yyyy-MM-dd_HH-mm-ss').format(DateTime.now());
    if (kIsWeb) {
      AnchorElement(
          href:
          'data:application/octet-srteam;charset=utf-16le;based64,${base64.encode(bytes)}')
        ..setAttribute('download', "educational_class($time)_total.xlsx")
        ..click();
      Navigator.pop(context);
    } else {
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName = "$path/educational_class($time)_total.xlsx";
      try {
        await File(fileName).writeAsBytes(bytes, flush: true);
        final file = File(fileName);
        if (await file.exists()) {
          final result = await OpenFilex.open(file.path);
          if (result.type != ResultType.done) {
            Fluttertoast.showToast(msg: "Could not open file: ${result.message}");
          }
        }
      } on FileSystemException catch (e) {
        Fluttertoast.showToast(msg: "Error saving file");
      }
      Navigator.pop(context);

    }

  }


}

