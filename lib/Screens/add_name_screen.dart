
import 'package:educational_class/Models/person.dart';
import 'package:educational_class/Provider/db_provider.dart';
import 'package:educational_class/Screens/scanner_camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AddNameScreen extends StatefulWidget {
  static const routeName = "ADD_NAME_SCREEN";
  const AddNameScreen({Key? key}) : super(key: key);

  @override
  State<AddNameScreen> createState() => _AddNameScreenState();
}

class _AddNameScreenState extends State<AddNameScreen> {
  GlobalKey<FormState> formKeyAdd = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  List<String> items = ["ولد","بنت"];
  String selected="ولد";
  var exist = false;
  @override
  Widget build(BuildContext context) {
    final classNumber = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        toolbarHeight: 70,
        title: const Text("اضافة اسم",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                var result = await Navigator.of(context).pushNamed(ScannerCameraScreen.routeName);
                showDialog(context: context, builder: (context) => const Center(child: CircularProgressIndicator(),),barrierDismissible: false);
                setTitle(result,context);
              },
              icon: const Icon(Icons.qr_code_scanner,size: 25,)
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formKeyAdd,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFormField(
                    controller: nameController,
                    style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.black),
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.drive_file_rename_outline,size: 20,),
                      hintText: "الاسم",
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    textDirection: TextDirection.rtl,
                    keyboardType: TextInputType.text,
                      validator: (value){
                        if(value==null||value==""||value.toString().length < 2){
                          return "مطلوب";
                        }else if(exist){
                          return "موجود بالفعل $value";
                        }
                      }
                  ),
                  const SizedBox(height: 15,),
                  Row(
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

                ],
              ),
            ),
          ),

        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.all(20),
        child: FloatingActionButton(
          onPressed: () async {
            showDialog(context: context, builder: (context)=>const CircularProgressIndicator(),barrierDismissible: false);
              exist = await DatabaseProvider.instance.checkPerson(nameController.text);
            Navigator.pop(context);
            if(formKeyAdd.currentState!.validate()){
              showDialog(context: context, builder: (context)=>const CircularProgressIndicator(),barrierDismissible: false);
              await add(classNumber,context);
            }
            //createObject
            //add database and pop
          },
          child: const Icon(Icons.save_rounded,size: 25,),
        ),
      ),
    );
  }
  add(classNumber,BuildContext context) async {
    var gender = selected=="ولد"? "male":"female";
    var scanName = "";
    var scanClass = "";
    var scanCode = "";
    List<PersonModel> allPerson =[];

    var scanArray = nameController.text.toString().split('_');
    try {
      if(nameController.text.contains('_')&&scanArray.length>0&&scanArray.length<4) {
        scanName = scanArray[0];
        scanClass = scanArray[1];
        scanCode = scanArray[2];
        classNumber = scanClass;
      } else{

          allPerson = await DatabaseProvider.instance.readAllPersonByClassNumber(classNumber);

          print("===============");
          print("$allPerson");
          scanName = nameController.text.toString();
          classNumber = classNumber;
          Fluttertoast.showToast(msg: classNumber);
          allPerson.sort((a, b) =>
              int.parse(a.code).compareTo(int.parse(b.code)));
          int lastCode = int.parse(allPerson.last.code);
          scanCode = (lastCode + 1).toString();
      }
      bool personExists = await DatabaseProvider.instance.checkPersonWithCodeAndClass(scanName,scanCode,scanClass);
      if(personExists){
        Navigator.of(context).pop();
        Fluttertoast.showToast(msg: "$scanName موجود بالفعل ");
      }else{
          await DatabaseProvider.instance.createPerson(PersonModel(
              name: scanName,
              gender: gender,
              typeUser: "فرد",
              code: scanCode,
              classNumber: classNumber
          ));
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "تم الاضافة ${scanName} (${scanClass}_${scanCode})",toastLength: Toast.LENGTH_LONG);
          Navigator.of(context).pop();
      }
    }catch(e){
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: "حطأ في ادخال الاسم\nحاول مره اخري");
    }
  }

  void setTitle(result,BuildContext context) {
    try{
    var resultScan= "";
    if(result!=null&&result.toString().length>1){
      resultScan = result as String;
      var scanArray = result.toString().split('_');
      if(scanArray.length>0&&scanArray.length<4) {
        var scanName = scanArray[0];
        var scanClass = scanArray[1];
        var scanCode = scanArray[2];
      }else{

        Fluttertoast.showToast(msg: "qr خطاء");
      }
      setState(() {
        nameController.text = resultScan;
      });

    }
    Navigator.pop(context);
    }catch(e){
      Navigator.pop(context);
      Fluttertoast.showToast(msg:"حاول مره اخري");
    }
  }
}
