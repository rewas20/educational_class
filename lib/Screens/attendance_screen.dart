import 'dart:convert';
import 'dart:io';
import 'package:educational_class/Models/attendance.dart';
import 'package:educational_class/Models/question.dart';
import 'package:educational_class/Provider/db_provider.dart';
import 'package:educational_class/Screens/videw_attend_date_screen.dart';
import 'package:educational_class/Widgets/date_attendance_item.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xls;
import 'package:universal_html/html.dart' show AnchorElement;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';

class AttendanceScreen extends StatefulWidget {
  static const routeName = "ATTENDANCE_SCREEN";
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  List<String> listAllDate = [];
  List<String> letters = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];
  @override
  Widget build(BuildContext context) {
    final classModel = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        toolbarHeight: 70,
        title: Text(classModel['name'],
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(ViewAttendDateScreen.routeName,arguments: classModel['classNumber'] )
                    .then((value) => listAllDate.clear());
              },
              icon: Icon(
                Icons.delete,
                size: 25,
              ))
        ],
      ),
      body: StreamBuilder(
        stream: DatabaseProvider.instance.readAllAttendByDateByClass(classModel['classNumber']).asStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data as List<String>;
            if (data.isNotEmpty) {
              listAllDate = data;
              listAllDate.sort((a, b) {
                DateTime dateA = parseDate(a);
                DateTime dateB = parseDate(b);
                return dateB.compareTo(dateA);
              });
            }
          }
          return listAllDate != null && listAllDate.isNotEmpty
              ? RefreshIndicator(
                  child: GridView(
                    padding: const EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent:
                          MediaQuery.of(context).size.width * 0.5,
                      childAspectRatio: 4 / 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    children: listAllDate
                        .map((caData) => DateAttendanceItem(
                            date: caData,
                            classNumber: classModel['classNumber'],
                            onOpen: (date) async {
                              showDialog(
                                  context: context,
                                  builder: (context) => const Center(
                                        child: CircularProgressIndicator(),
                                      ));
                              setState(() {
                                //listAllAttendance = listAttends;
                                sheetExcel(date,classModel['classNumber']);
                              });
                            }))
                        .toList(),
                  ),
                  onRefresh: onRefresh)
              : Center(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "No data",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                );
        },
      ),
    );
  }

  Future sheetExcel(date,classNumber) async {
    List<AttendanceModel> attends =
        await DatabaseProvider.instance.readAllAttendTimeByClass(date,classNumber);
    List<QuestionModel> questions =
        await DatabaseProvider.instance.readAllQuestion();
    final xls.Workbook workbook = xls.Workbook();
    final xls.Worksheet sheet = workbook.worksheets[0];
    final xls.Worksheet sheet2 = workbook.worksheets.addWithName("الصلاة");
    final xls.Worksheet sheet3 = workbook.worksheets.addWithName("فكر مسيحي");

    sheet.name = "الحضور";
    sheet.getRangeByName('${letters[0]}1').setText("الوقت");
    sheet.getRangeByName('${letters[1]}1').setText("الاسم");
    sheet.getRangeByName('${letters[2]}1').setText("كود");
    sheet.getRangeByName('${letters[3]}1').setText("فصل");
    sheet.getRangeByName('${letters[4]}1').setText("رقم");
    sheet.getRangeByName('${letters[5]}1').setText("المجموع");
    sheet.getRangeByName('${letters[6]}1').setText("الصلاة");
    sheet.getRangeByName('${letters[7]}1').setText("فكر مسيحي");

    sheet2.getRangeByName('${letters[0]}1').setText("الوقت");
    sheet2.getRangeByName('${letters[1]}1').setText("الاسم");
    sheet2.getRangeByName('${letters[2]}1').setText("كود");

    sheet3.getRangeByName('${letters[0]}1').setText("الوقت");
    sheet3.getRangeByName('${letters[1]}1').setText("الاسم");
    sheet3.getRangeByName('${letters[2]}1').setText("كود");



    int numberRowSheet = 2;
    //int numberRowSheet2 = 2;
    for (var element in attends) {
        int numberColumn = 6;
        sheet
            .getRangeByName('${letters[0]}${numberRowSheet}')
            .setText(element.time);
        sheet
            .getRangeByName('${letters[1]}${numberRowSheet}')
            .setText(element.name);
        sheet.getRangeByName('${letters[2]}${numberRowSheet}').setText(
            (element.classNumber) != null &&
                    (element.classNumber) != "" &&
                    (element.classNumber) != "null"
                ? "${element.classNumber}_${element.code}"
                : "");
        sheet.getRangeByName('${letters[3]}${numberRowSheet}').setText(
            (element.classNumber) != null &&
                    (element.classNumber) != "" &&
                    (element.classNumber) != "null"
                ? element.classNumber
                : "");
        sheet.getRangeByName('${letters[4]}${numberRowSheet}').setText(
            (element.code) != null &&
                    (element.code) != "" &&
                    (element.code) != "null"
                ? element.code
                : "");
        sheet
            .getRangeByName('${letters[5]}${numberRowSheet}')
            .setText(element.total);
        final attendanceQ = element.answer!;
        if (attendanceQ.isNotEmpty &&
            attendanceQ != "null" &&
            attendanceQ != null) {
          final questionAttend = element.answer!.split(",");
          Map<String, dynamic> mapAnswer = {};
          questionAttend.forEach((element) {
            final keyValue = element.split(":");
            for (int j = 0; j < keyValue.length; j += 2) {
              mapAnswer.addAll({keyValue[j]: keyValue[j + 1]});
            }
          });
          mapAnswer.forEach((key, value) {
            for (int i = 0; i < questions.length; i++) {
              if (key.contains(questions[i].question)) {
                sheet
                    .getRangeByName(
                        '${letters[numberColumn + i]}${numberRowSheet}')
                    .setText(value.toString().replaceAll("}", ""));
              }
            }
          });
        }
        numberRowSheet++;
    }

    int numberRowSheetSheet1 = 2;
    int numberRowSheetSheet2 = 2;
    for (var element in attends) {
      final attendanceQ = element.answer!;
      if (attendanceQ.isNotEmpty &&
          attendanceQ != "null" &&
          attendanceQ != null) {
        final questionAttend = element.answer!.split(",");
        Map<String, dynamic> mapAnswer = {};
        questionAttend.forEach((element) {
          final keyValue = element.split(":");
          for (int j = 0; j < keyValue.length; j += 2) {
            mapAnswer.addAll({keyValue[j]: keyValue[j + 1]});
          }
        });
        mapAnswer.forEach((key, value) {
          String answer = value.toString().replaceAll("}", "");
          if(answer.contains('نعم')){
            for (int i = 0; i < questions.length; i++) {
              if (key.contains(questions[i].question)) {
                if(questions[i].question.contains('الصلاة')){

                  sheet2
                      .getRangeByName('${letters[0]}${numberRowSheetSheet1}')
                      .setText(element.time);
                  sheet2
                      .getRangeByName('${letters[1]}${numberRowSheetSheet1}')
                      .setText(element.name);
                  sheet2.getRangeByName('${letters[2]}${numberRowSheetSheet1}').setText(
                      (element.classNumber) != null &&
                          (element.classNumber) != "" &&
                          (element.classNumber) != "null"
                          ? "${element.classNumber}_${element.code}"
                          : "");
                  numberRowSheetSheet1++;
                }else if(questions[i].question.contains('فكر مسيحي')){

                  sheet3
                      .getRangeByName('${letters[0]}${numberRowSheetSheet2}')
                      .setText(element.time);
                  sheet3
                      .getRangeByName('${letters[1]}${numberRowSheetSheet2}')
                      .setText(element.name);
                  sheet3.getRangeByName('${letters[2]}${numberRowSheetSheet2}').setText(
                      (element.classNumber) != null &&
                          (element.classNumber) != "" &&
                          (element.classNumber) != "null"
                          ? "${element.classNumber}_${element.code}"
                          : "");
                  numberRowSheetSheet2++;
                }
              }

            }
          }

        });
      }

    }


    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    final time = date.replaceAll("/", "-");
    if (kIsWeb) {
      AnchorElement(
          href:
              'data:application/octet-srteam;charset=utf-16le;based64,${base64.encode(bytes)}')
        ..setAttribute('download', "educational_class($time)($classNumber).xlsx")
        ..click();
      Navigator.pop(context);
    } else {
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName = "$path/educational_class($time)($classNumber).xlsx";
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

  Future onRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      listAllDate.clear();
    });
  }

  DateTime parseDate(String date) {
    List<String> parts = date.split('/');
    return DateTime(
      int.parse(parts[2]), // Year
      int.parse(parts[1]), // Month
      int.parse(parts[0]), // Day
    );
  }
}
