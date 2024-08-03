import 'package:educational_class/Models/attendance.dart';
import 'package:educational_class/Models/person.dart';
import 'package:educational_class/Models/search_bar.dart';
import 'package:educational_class/Provider/db_provider.dart';
import 'package:educational_class/Screens/add_name_screen.dart';
import 'package:educational_class/Screens/person_search_screen.dart';
import 'package:educational_class/Screens/questions_screen.dart';
import 'package:educational_class/Widgets/name_item.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../Data/data.dart';
import '../Widgets/category_item.dart';

class NamesScreen extends StatefulWidget {
  static const routeName = "NAMES_SCREEN";
  const NamesScreen({Key? key}) : super(key: key);

  @override
  State<NamesScreen> createState() => _NamesScreenState();
}

class _NamesScreenState extends State<NamesScreen> with TickerProviderStateMixin {
  List<PersonModel> personList = [];
  late AnimationController animationController ;
  String formatDate  = DateFormat("dd/MM/yyyy").format(DateTime.now());
  String formatTime  = DateFormat("h:mm a").format(DateTime.now());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      lowerBound: 0,
      upperBound: 1,
      vsync: this,

    )..addListener(() {
      setState(() {

      });
    });

  }
  void openSearchBar() async{
    await animationController.animateTo(1,curve: Curves.easeInOutQuart).orCancel;
    await Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context,_,__)=> SearchScreen(personList)));
    closeSearchBar();
  }
  void closeSearchBar() async{
    await animationController.animateBack(0,curve: Curves.easeInOutQuart).orCancel;
  }
  @override
  Widget build(BuildContext context) {
    final model = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    return Stack(
      children: [
          Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.white,
              backgroundColor: Theme.of(context).primaryColor,
              centerTitle: true,
              toolbarHeight: 70,
              actions: [
                IconButton(
                  onPressed: (){
                    openSearchBar();
                  },
                  icon: Icon(Icons.search),

                ),
                IconButton(
                  onPressed: (){
                    setState((){
                      personList;
                    });
                  },
                  icon: Icon(Icons.format_list_numbered_rtl),

                )
              ],
              title: Text(personList==null||personList.isEmpty?model['name']:"${model['name']} (${personList.length})",style: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
            ),
            body: StreamBuilder(
             stream: DatabaseProvider.instance.readAllPersonByClassNumber(model['classNumber']).asStream(),
             builder: (context,snapshot){
               if(snapshot.hasData){
                 var data = snapshot.data as List<PersonModel>;
                 if(data.isNotEmpty){
                   personList = data;
                   personList.sort((a, b) => int.parse(a.code).compareTo(int.parse(b.code)));
                 }
               }
               return personList!=null&&personList.isNotEmpty?RefreshIndicator(
                 onRefresh: onRefresh,
                 child: ListView.builder(
                   itemCount: personList.length,
                   itemBuilder: (_,index){
                     return Card(
                       margin: EdgeInsets.all(10),
                       elevation: 4,
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                       shadowColor: Theme.of(context).primaryColor,
                       child: NameItem(id: personList[index].id,name: personList[index].name, gender: personList[index].gender, typeUser: personList[index].typeUser,code: personList[index].code,classNumber: personList[index].classNumber, deleteItem: (id) async {
                         showDialog(context: context, builder: (context)=>const CircularProgressIndicator(),barrierDismissible: false);
                         await DatabaseProvider.instance.deletePerson(id);
                         setState((){
                           personList.remove(personList[index]);
                         });
                         Navigator.pop(context);
                       },
                        personAttend: (id) async{
                           PersonModel model = await DatabaseProvider.instance.readPersonById(id);
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

                       ),
                     );
                   },
                 ),
               ):Center(child: Container(alignment: Alignment.center,child: Text("No data",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18,color: Theme.of(context).primaryColor),),),);
             },
           ),
            floatingActionButton: Container(
              margin: const EdgeInsets.all(20),
              child: FloatingActionButton(
                onPressed: () async {
                  await Navigator.of(context).pushNamed(AddNameScreen.routeName,arguments: model['classNumber']);
                  setState((){
                    personList.clear();
                  });
                },
                child: const Icon(Icons.add,size: 25,),
              ),
            ),

        ),
          Positioned(
          child: buildSearchBar(context),
            top: 0,
            left: 0,
            right: 0,
            height: 110,

          ),
      ]
    );

  }

  Widget buildSearchBar(BuildContext context){
    return SafeArea(
      child: ClipPath(
        clipper: SearchBarClipArea(animationController.value * 1.01),
        child: Material(

          color: Theme.of(context).primaryColor,
          child: Container(
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
                decoration: InputDecoration(
                  fillColor: Theme.of(context).primaryColor,
                  contentPadding: EdgeInsets.all(5),
                  hintText: 'Search.....',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.black38,fontSize: 20),
                  suffixIcon: IconButton(
                    onPressed: (){
                      closeSearchBar();
                    },
                    icon: Icon(Icons.close),
                  ),
                )
            ),
          ),
        ),
      ),
    );
  }
  Future onRefresh() async{
    await Future.delayed(Duration(seconds: 2));
    setState(() {

      personList.clear();
    });
  }
}
