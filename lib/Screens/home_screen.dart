import 'dart:convert';
import 'dart:io';
import 'package:educational_class/Data/menu_items.dart';
import 'package:educational_class/Models/attendance.dart';
import 'package:educational_class/Models/menu_item.dart';
import 'package:educational_class/Models/person.dart';
import 'package:educational_class/Provider/db_provider.dart';
import 'package:educational_class/Screens/login_screen.dart';
import 'package:educational_class/Services/auth_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      try {
        await File(fileName).writeAsBytes(bytes, flush: true);
        final file = File(fileName);
        if (await file.exists()) {
          final uri = Uri.file(file.path);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          } else {
            Fluttertoast.showToast(msg: "Could not open file");
          }
        }
      } on FileSystemException catch (e) {
        Fluttertoast.showToast(msg: "Error saving file");
      }
    }
  }
}

