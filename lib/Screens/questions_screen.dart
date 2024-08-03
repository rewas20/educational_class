import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Models/attendance.dart';
import '../Models/question.dart';
import '../Provider/db_provider.dart';

class QuestionsScreen extends StatefulWidget {
  static const routeName = "QUESTIONS_SCREEN";
  const QuestionsScreen({Key? key}) : super(key: key);

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  List<QuestionModel> listQuestion=[];
  Map<String,dynamic> mapCheck = {};
  List<bool> checkQuestion = [];
  List<Icon> iconCheckList = [];
  Icon iconCheckAll = Icon(Icons.check_box_outline_blank,size: 20);
  bool checkAll = false;
  TextEditingController numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<dynamic,dynamic>;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        toolbarHeight: 70,
        title: Text("(${args['model'].classNumber}_${args['model'].code}) ${args['name']}",style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white)),
        actions: [
          IconButton(
            onPressed: (){
              if(checkAll){

                  setState((){
                  iconCheckAll = Icon(Icons.check_box_outline_blank,size: 20);
                  checkAll = false;
                  });
                  for(int i = 0;i<listQuestion.length;i++){
                    setState((){
                    iconCheckList[i] = Icon(Icons.check_box_outline_blank,size: 20);
                    checkQuestion[i] = false;
                    mapCheck.addAll({listQuestion[i].question:"لا"});
                    });
                  }


              }else{

                  setState((){
                  iconCheckAll = Icon(Icons.check_box,size: 20);
                  checkAll = true;
                  });
                  for(int x = 0;x<listQuestion.length;x++){

                      setState((){
                        mapCheck.addAll({listQuestion[x].question:"نعم"});
                        iconCheckList[x] = Icon(Icons.check_box,size: 20);
                        checkQuestion[x] = true;
                      });


                  }

              }
            },
            icon: iconCheckAll,
          ),
        ],
      ),
      body: StreamBuilder(
        stream: DatabaseProvider.instance.readAllQuestion().asStream(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var data = snapshot.data as List<QuestionModel>;
            if(data.isNotEmpty){
              listQuestion = data;
            }
          }
          return listQuestion!=null&&listQuestion.isNotEmpty?RefreshIndicator(child: ListView.builder(
              itemCount: listQuestion.length,
              itemBuilder: (conxt,index){
                iconCheckList.add(Icon(Icons.check_box_outline_blank,size: 20));
                checkQuestion.add(false);
                return Card(
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    onTap: (){
                      if(checkQuestion[index]){
                        setState((){
                          iconCheckList[index] = Icon(Icons.check_box_outline_blank,size: 20);
                          checkQuestion[index] = false;
                          mapCheck.addAll({listQuestion[index].question:"لا"});
                        });

                      }else{
                        setState((){
                          mapCheck.addAll({listQuestion[index].question:"نعم"});
                          iconCheckList[index] = Icon(Icons.check_box,size: 20);
                          checkQuestion[index] = true;
                        });
                      }
                    },
                    contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                    title: Text(listQuestion[index].question,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600)),
                    trailing: iconCheckList[index],
                  ),
                );
              }
          ), onRefresh: onRefresh):Center(child: Container(alignment: Alignment.center,child: Text("No data",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18,color: Theme.of(context).primaryColor),),),);
        },
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.all(20),
        child: FloatingActionButton(
          onPressed: () async{
            var calculateGrade = 0;
            if(mapCheck.isEmpty||mapCheck==null){
              listQuestion.forEach((element) {
                setState((){
                  mapCheck.addAll({element.question:"لا"});
                });

              });
            }else if(mapCheck.length!=listQuestion.length){
              for(int i=0;i<listQuestion.length;i++){
                if(!mapCheck.containsKey(listQuestion[i].question)){
                  setState((){

                  mapCheck.addAll({listQuestion[i].question:"لا"});
                  });
                }
              }
            }
            mapCheck.forEach((key, value) {
              if(value!="لا"&&value!.isNotEmpty&&value!=null) {
                setState((){
                  calculateGrade+= 1;
                });

              }else if(value!.isEmpty||value==null||key.isNotEmpty||key==null){
                setState((){
                  mapCheck[key] = "لا";
                });

              }

            });

            var total = calculateGrade.toString();
            showDialog(context: context, builder: (context)=>Center(child: CircularProgressIndicator(),),barrierDismissible: false);
            await DatabaseProvider.instance.updateAttend(AttendanceModel(id: args['attend'].id,name: args['attend'].name, gender: args['attend'].gender,
                typeUser: args['attend'].typeUser, date: args['attend'].date, time: args['attend'].time,answer: mapCheck.toString(),
                grade: calculateGrade.toString(),total: total,classNumber: args['attend'].classNumber,code: args['attend'].code));
            Navigator.pop(context);
            Fluttertoast.showToast(msg: "تم");
            Navigator.of(context).pop({
              'total': calculateGrade,
              'answer': mapCheck.toString(),
            });
          },
          child: Icon(Icons.check,size: 25,),
        ),
      ),
    );
  }
  Future onRefresh() async{
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      listQuestion.clear();
    });
  }
}
