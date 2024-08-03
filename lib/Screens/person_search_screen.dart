
import 'package:educational_class/Models/attendance.dart';
import 'package:educational_class/Screens/questions_screen.dart';
import 'package:educational_class/Screens/view_data_name_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../Models/person.dart';
import '../Provider/db_provider.dart';

class SearchScreen extends StatefulWidget {
  List<PersonModel> listPersons;
  SearchScreen(this.listPersons, {Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchString = "";
  TextEditingController inputText = TextEditingController(text: "");
  List<PersonModel> result =[];
  String formatDate  = DateFormat("dd/MM/yyyy").format(DateTime.now());
  String formatTime  = DateFormat("h:mm a").format(DateTime.now());

  Widget buildSearchBar(BuildContext context){
    return SafeArea(
      child:  Material(
        color: Theme.of(context).primaryColor,
        child: Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: TextFormField(
            controller: inputText,
            onChanged: (search){
              setState(() {
                result = widget.listPersons.where((element) =>
                    (element.name.startsWith(search))||
                    (element.name.contains(search)) ||
                    (element.name == search)||
                    (element.gender.toLowerCase().contains(search.toLowerCase()))||
                    (element.classNumber.toLowerCase().contains(search.toLowerCase()))||
                    (element.code.contains(search))).toList();
              });
            },
            decoration: InputDecoration(
              fillColor: Theme.of(context).primaryColor,
              filled: true,
              hintText: 'Search.....',
              hintStyle: TextStyle(color: Colors.black38,fontSize: 20),
              contentPadding: EdgeInsets.all(5),
              border: InputBorder.none,
              suffixIcon: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.close,size: 20,color: Colors.black,),
              ),
            ),
            autofocus: true,
          ),
        ),
      ),
    );
  }
  Widget buildBody(BuildContext context,String person){
    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (_,index){
        return Card(
          margin: EdgeInsets.all(5),
          child:  ListTile(
            contentPadding: EdgeInsets.all(20),
            onTap: () async {
               /* Navigator.of(context).pushNamed(
                    ViewDataNameScreen.routeName, arguments: {"model": result[index],'typeUser': result[index].gender=="female"?"بنت":"ولد"});*/


            },
            leading: IconButton(
                onPressed: (){

                  showDialog(context: context, builder: (context)=>alertDialogAttendance(context,result[index]));
                }, icon: Icon(Icons.qr_code_scanner,size: 25,)),
            title: Text("${index+1}. ${result[index].name}",style: TextStyle(fontSize: 15,color: Theme.of(context).primaryColor),),
            subtitle: Text("${result[index].classNumber}_${result[index].code}",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 15,color: Colors.black),),
            trailing: IconButton(onPressed: () async {
               showDialog(context: context, builder: (context)=>alertDialog(context, result[index]));


                }, icon: Icon(Icons.delete,size: 20,)),

          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    result = widget.listPersons;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            toolbarHeight: 70,
            title: Text("Result",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
            centerTitle: true,


          ),
          body: buildBody(context,inputText.text),
        ),
        Positioned(
          child: buildSearchBar(context),
          top: 0,
          left: 0,
          right: 0,
          height: 110,

        ),
      ],
    );
  }
  alertDialog(context,PersonModel person){
    return AlertDialog(
      alignment: Alignment.center,
      elevation: 1,
      title: const Text("هل تريد المسح ؟"),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      actions: [
        TextButton(onPressed: () async {
          int id = int.parse(person.id.toString()??'');
          await DatabaseProvider.instance.deletePerson(id);
          setState((){
            result.remove(person);
          });
          Navigator.pop(context);
          Navigator.of(context).pop();
          Fluttertoast.showToast(msg: "تم");
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
  alertDialogAttendance(context,PersonModel model){
    return AlertDialog(
      alignment: Alignment.center,
      elevation: 1,
      title: Text("هل تريد تسجيل الحضور ل ${model.name} ؟"),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      actions: [
        TextButton(onPressed: () async {
          Navigator.of(context).pop();
          bool attend = await DatabaseProvider.instance.checkAttend(model.name,formatDate,model.code,model.classNumber);
          if(attend){
            AttendanceModel attend = await DatabaseProvider.instance.readAllAttendByCodeAndClassNumber(model.name,formatDate,model.code,model.classNumber);
            Fluttertoast.showToast(msg: "مسجل من قبل"+" "+model.name);
            var questionList = await DatabaseProvider.instance.readAllQuestion();
            Navigator.of(context).pushNamed(QuestionsScreen.routeName,arguments: {'name':model.name,'model':model,'number':questionList.length,'list':questionList,'attend':attend});

          }
          else{
            AttendanceModel attend = await DatabaseProvider.instance.createAttend(AttendanceModel(name: model.name, gender: model.gender, typeUser: model.typeUser, date: formatDate, time: formatTime,grade: "0",total: "0",code: model.code,classNumber: model.classNumber,));
            Fluttertoast.showToast(msg: "${model.name} تم تسجيل");
            var questionList = await DatabaseProvider.instance.readAllQuestion();
            Navigator.of(context).pushNamed(QuestionsScreen.routeName,arguments: {'name':model.name,'model':model,'number':questionList.length,'list':questionList,'attend':attend});
          }
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

}
