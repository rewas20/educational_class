
import 'package:educational_class/Screens/questions_screen.dart';
import 'package:educational_class/Screens/scanner_camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../Models/attendance.dart';
import '../Models/person.dart';
import '../Provider/db_provider.dart';

class ScanScreen extends StatefulWidget {
  static const routeName = "SCAN_SCREEN";
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  String formatDate  = DateFormat("dd/MM/yyyy").format(DateTime.now());
  String formatTime  = DateFormat("h:mm a").format(DateTime.now());
  var scan = "" ;
  var resultScan = "" ;
  @override
  Widget build(BuildContext context) {
    final qur = MediaQuery.of(context).size.width/4;
    final model = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        toolbarHeight: 70,
        title: Text(model['name'],style: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              Text(scan!=null&&scan!=""?scan:"No Selected",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18,color: Theme.of(context).primaryColor),),
              SizedBox(height: qur),
              ElevatedButton.icon(
                  onPressed: () async {
                    try{
                    var result  = await Navigator.of(context).pushNamed(ScannerCameraScreen.routeName);
                      if(result!=null&&result.toString().length>1){
                        resultScan = result as String;
                        var scanArray = resultScan.toString().split('_');
                        if(scanArray.length>0&&scanArray.length<4){
                          var scanName = scanArray[0];
                          var scanClass = scanArray[1];
                          var scanCode = scanArray[2];
                          setState((){
                            scan = resultScan;
                          });
                          showDialog(context: context, builder: (context)=>const Center(child: CircularProgressIndicator(),),barrierDismissible: false);
                            await checkCode(scanName,scanClass ,scanCode,context);

                        }else{
                         Fluttertoast.showToast(msg: "ليس موجود في البيانات"+" "+resultScan);
                          setState((){
                            scan = result;
                          });
                        }
                      }else{
                        setState((){
                          scan = "No Selected";
                        });
                      }
                    }catch(e){
                      Navigator.pop(context);
                    }

                  },
                icon: const Icon(Icons.qr_code_scanner,size: 25,color: Colors.white),
                label: const Text("Scan",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20,color: Colors.white),),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor,)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future checkCode(scanName,scanClass,scanCode,BuildContext context) async {
    PersonModel model = await DatabaseProvider.instance.readPersonByCodeAndClass(scanName,scanCode,scanClass);
    if(model!=null){
      bool attend = await DatabaseProvider.instance.checkAttend(model.name,formatDate,model.code,model.classNumber);
      if(attend){
        AttendanceModel attend = await DatabaseProvider.instance.readAllAttendByCodeAndClassNumber(model.name,formatDate,model.code,model.classNumber);
        Fluttertoast.showToast(msg: "مسجل من قبل"+" "+model.name);
        Navigator.pop(context);
        var questionList = await DatabaseProvider.instance.readAllQuestion();
        Navigator.of(context).pushNamed(QuestionsScreen.routeName,arguments: {'name':model.name,'model':model,'number':questionList.length,'list':questionList,'attend':attend});

      }else{
        AttendanceModel attend = await DatabaseProvider.instance.createAttend(AttendanceModel(name: model.name, gender: model.gender, typeUser: model.typeUser, date: formatDate, time: formatTime,grade: "0",total: "0",code: model.code,classNumber: model.classNumber,));
        Fluttertoast.showToast(msg: "${model.name} تم تسجيل");
        Navigator.pop(context);
        var questionList = await DatabaseProvider.instance.readAllQuestion();
        Navigator.of(context).pushNamed(QuestionsScreen.routeName,arguments: {'name':model.name,'model':model,'number':questionList.length,'list':questionList,'attend':attend});
      }
    }else{
      Fluttertoast.showToast(msg: "ليس موجود في البيانات"+" "+scanName);
      Navigator.pop(context);
    }

  }

}
