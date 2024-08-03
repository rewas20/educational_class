
import 'package:educational_class/Screens/questions_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Models/attendance.dart';
import '../Models/question.dart';
import '../Provider/db_provider.dart';

class BonusScreen extends StatefulWidget {
  static const routeName = "BONUS_SCREEN";
  const BonusScreen({Key? key}) : super(key: key);

  @override
  State<BonusScreen> createState() => _BonusScreenState();
}

class _BonusScreenState extends State<BonusScreen> {
  late var  attendGrade = 0, total = 0;
  var answer ;
  static const titleAttendName = "الحضور";
  static const totalName = ":المجموع";
  TextEditingController bonusController = TextEditingController();
  TextEditingController addBonusController = TextEditingController();
  var attendance;
  @override
  Widget build(BuildContext context) {
    final attend = ModalRoute.of(context)!.settings.arguments as AttendanceModel;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        toolbarHeight: 70,
        title: Text(
          "(${attend.classNumber}_${attend.code}) ${attend.name}",
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600, fontSize: 20),
        ),
      ),
      body: StreamBuilder(
        stream: DatabaseProvider.instance.readAttendById(attend.id!).asStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data as AttendanceModel;
            if(data!=null){
              if (data.date == attend.date) {
                attendance = data;
              }
            }
          }
          if (attendance != null) {
            attendGrade = attendance.grade!=null&&attendance.grade!=""?int.parse(attendance.grade.toString()):0;
            total = attendance.total!=null&&attendance.total!=""?int.parse(attendance.total.toString()):0;
            return SingleChildScrollView(
              child: Container(
                  margin: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "درجة ${total}",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "${totalName}",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        shadowColor: Colors.blue,
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                        child: ListTile(
                          onTap: () async {
                            List<QuestionModel> questionList =
                                await DatabaseProvider.instance
                                    .readAllQuestion();
                            Navigator.of(context).pushNamed(
                                QuestionsScreen.routeName,
                                arguments: {
                                  'name': attendance.name,
                                  'model': attendance,
                                  'number': questionList.length,
                                  'list': questionList,
                                  'attend': attendance,
                                }).then(( value ) {
                            if (value != null && value is Map) {
                              setState(() {
                                attendGrade = int.parse(value['total'].toString()) ;
                                answer = value['answer'];
                              });
                            }
                            });
                          },
                          contentPadding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          title: Text(
                            titleAttendName,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Theme.of(context).primaryColor),
                          ),
                          subtitle: Text(
                            "   الدرجة$attendGrade\n ${answer??attend.answer}",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  )),
            );
          } else {
            return Center(
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
          }
        },
      ),
    );
  }

}
