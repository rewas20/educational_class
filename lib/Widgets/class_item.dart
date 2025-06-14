import 'dart:convert';
import 'dart:io';

import 'package:educational_class/Models/person.dart';
import 'package:educational_class/Provider/db_provider.dart';
import 'package:educational_class/Screens/attendance_screen.dart';
import 'package:educational_class/Screens/names_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart' show AnchorElement;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:url_launcher/url_launcher.dart';


class ClassItem extends StatelessWidget {
  final String name;
  final String classNumber;
  final String type;

  ClassItem({Key? key,
    required this.name,
    required this.type,
    required this.classNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final qur = MediaQuery.of(context).size.width/4;
    return InkWell(
      onTap: () async {
        if(type=='names'){
          Navigator.of(context).pushNamed(NamesScreen.routeName,arguments: {
            'name': name,
            'classNumber': classNumber
          });
        }else if(type == 'attendance'){
          Navigator.of(context).pushNamed(AttendanceScreen.routeName,arguments: {

            'name': name,
            'classNumber': classNumber
          });
        }

      },
      onLongPress: ()async{
        if(type=='names'){
          List<PersonModel> persons =
          await DatabaseProvider.instance.readAllPersonByClassNumber(classNumber);
          persons.sort((a, b) => int.parse(a.code).compareTo(int.parse(b.code)));
          final Workbook workbook = Workbook();
          final Worksheet sheet = workbook.worksheets[0];

          sheet.name = "الاسماء";
          sheet.getRangeByName('A1').setText("كود");
          sheet.getRangeByName('B1').setText("الاسم");

          int numberRowSheet = 2;
          for (var element in persons) {
            sheet
                .getRangeByName('A${numberRowSheet}')
                .setText(element.code);
            sheet
                .getRangeByName('B${numberRowSheet}')
                .setText(element.name);
            numberRowSheet++;
          }
          final List<int> bytes = workbook.saveAsStream();
          workbook.dispose();
          if (kIsWeb) {
          AnchorElement(
          href:
          'data:application/octet-srteam;charset=utf-16le;based64,${base64.encode(bytes)}')
          ..setAttribute('download', "$classNumber.xlsx")
          ..click();
          Navigator.pop(context);
          } else {
            final String path = (await getApplicationSupportDirectory()).path;
            final String fileName = "$path/$classNumber.xlsx";
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
        child: Text(name,style:  TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: Colors.black.withOpacity(0.5))),
      ),
    );
  }
}