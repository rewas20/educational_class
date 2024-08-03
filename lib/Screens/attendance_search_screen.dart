
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Models/attendance.dart';
import '../Provider/db_provider.dart';
import 'bonus_screen.dart';

class SearchScreen extends StatefulWidget {
  List<AttendanceModel> listAttendance;
  SearchScreen(this.listAttendance, {Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchString = "";
  var bonus;
  TextEditingController inputText = TextEditingController(text: "");
  List<AttendanceModel> result =[];
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
                result = widget.listAttendance.where((element) =>
                ("t "+element.time).toLowerCase().startsWith(search.toLowerCase()) ||
                (element.name.startsWith(search))||
                (element.name.contains(search))||
                (element.name==(search))||
                (element.gender.toLowerCase().contains(search.toLowerCase()))||
                (element.code==(search))||
                (element.classNumber.toLowerCase().contains(search.toLowerCase()))).toList();
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
  Widget buildBody(BuildContext context,String attend){
    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (_,index){
        bonus = result[index].total;
        return Card(
          margin: EdgeInsets.all(5),
          child: ListTile(
            contentPadding: EdgeInsets.all(20),
            onTap: () async {
                await Navigator.of(context).pushNamed(BonusScreen.routeName,arguments: result[index]).then((value) => setState((){bonus = value;}));

            },
            leading: result[index].typeUser=="فرد"?Text(bonus!="null"?"+$bonus":"0",style: TextStyle(fontSize: 20),):null,
            title: Text("${index+1}. ${result[index].name}",style: TextStyle(fontSize: 15,color: Theme.of(context).primaryColor),),
            subtitle: Text(result[index].time+"\n"+(result[index].classNumber+"_"+result[index].code)+"\n${result[index].answer??''}",style: TextStyle(fontSize: 15,color: Colors.black),),
            trailing: IconButton(onPressed: () async {
              showDialog(context: context, builder: (context)=>alertDialog(context, result[index]));

              //Navigator.pop(context);
            }, icon: Icon(Icons.delete,size: 20,)),

          )
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    result = widget.listAttendance;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            toolbarHeight: 70,
            title: Text("Result",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
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
  alertDialog(context,AttendanceModel attend){
    return AlertDialog(
      alignment: Alignment.center,
      elevation: 1,
      title: const Text("هل تريد المسح ؟"),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      actions: [
        TextButton(onPressed: () async {
          int id = int.parse(attend.id.toString());
          await DatabaseProvider.instance.deleteAttend(id);
          setState((){
            result.remove(attend);
          });
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

}
