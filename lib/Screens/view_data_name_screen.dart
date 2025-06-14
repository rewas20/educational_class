import 'package:educational_class/Models/person.dart';
import 'package:educational_class/Provider/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ViewDataNameScreen extends StatefulWidget {
  static const routeName = "VIEW_DATA_NAME_SCREEN";
  const ViewDataNameScreen({Key? key}) : super(key: key);

  @override
  State<ViewDataNameScreen> createState() => _ViewDataNameScreenState();
}

class _ViewDataNameScreenState extends State<ViewDataNameScreen> {
  GlobalKey<FormState> formKeyAdd = GlobalKey<FormState>();
  TextEditingController nameTeamController = TextEditingController();
  List<String> itemsTeams = ["1","2","3","4","5","6"];
  String selectedTeam ="1";
  var modelUser;
  var enter = true;
  @override
  Widget build(BuildContext context) {
    final model = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text("${model['model'].name}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: DatabaseProvider.instance.readPersonByName(model['model'].name).asStream(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var data = snapshot.data  as PersonModel;
            if(data!=null){
              modelUser =data;
              if(enter){
                selectedTeam = modelUser.team!=null&&modelUser.team!.isNotEmpty&&modelUser.team!='null'?modelUser.team!:"1";
                nameTeamController.text = modelUser.nameTeam!=null&&modelUser.nameTeam!.isNotEmpty&&modelUser.nameTeam!='null'?modelUser.nameTeam!:"";
                enter = false;
              }
            }
          }
          return modelUser!=null?Container(
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
                      Text(
                        "اسم الرهط",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700)
                        ),
                      const SizedBox(height: 15,),
                      TextFormField(
                        controller: nameTeamController,
                        style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.black),
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.drive_file_rename_outline,size: 20,),
                          hintText: "اسم الرهط (اختياري)",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                          hintTextDirection: TextDirection.rtl
                        ),
                        textDirection: TextDirection.rtl,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.start,
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
                              value: selectedTeam,
                              onChanged: (String? value) {
                                setState((){
                                  selectedTeam = value!;
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                              ),
                              items: itemsTeams
                                  .map((item) {
                                return DropdownMenuItem<String>(
                                  value:  item,
                                  child: Text(item,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Theme.of(context).primaryColor)),
                                );
                              }).toList(),

                            ),
                          ),
                          const Text("رقم الرهط",style:  TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.black))
                        ],
                      ),

                    ],
                  ),
                ),
              ),

            ),
          ):Center(child: Container(alignment: Alignment.center,child: Text("No data",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18,color: Theme.of(context).primaryColor),),),);
        },
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.all(20),
        child: FloatingActionButton(
          onPressed: () async {
              showDialog(context: context, builder: (context)=>const CircularProgressIndicator(),barrierDismissible: false);
              await DatabaseProvider.instance.updatePerson(PersonModel(
                  id: model['model'].id,
                  name: model['model'].name,
                  gender: model['model'].gender,
                  typeUser: model['model'].typeUser,
                  code: model['model'].code, classNumber:  model['model'].classNumber));
              Navigator.pop(context);
              Fluttertoast.showToast(msg: "تم الاضافة");
              Navigator.of(context).pop();
            //createObject
            //add database and pop
          },
          child: const Icon(Icons.save_rounded,size: 25,),
        ),
      ),
    );
  }
}
