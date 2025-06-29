
import 'package:educational_class/Models/person.dart';
import 'package:educational_class/Models/search_bar.dart';
import 'package:educational_class/Provider/db_provider.dart';
import 'package:educational_class/Screens/person_search_screen.dart';
import 'package:educational_class/Widgets/name_item.dart';
import 'package:flutter/material.dart';

import 'add_name_screen.dart';

class GirlsScreen extends StatefulWidget {
  static const routeName = "GIRLS_SCREEN";
  const GirlsScreen({Key? key}) : super(key: key);

  @override
  State<GirlsScreen> createState() => _GirlsScreenState();
}

class _GirlsScreenState extends State<GirlsScreen>with TickerProviderStateMixin {
  late AnimationController animationController ;
  List<PersonModel> listAllGirls =[];
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
    await Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context,_,__)=> SearchScreen(listAllGirls)));
    closeSearchBar();
  }
  void closeSearchBar() async{
    await animationController.animateBack(0,curve: Curves.easeInOutQuart).orCancel;
  }
  @override
  Widget build(BuildContext context) {
    final name = ModalRoute.of(context)!.settings.arguments as String;
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
                    listAllGirls;
                  });
                },
                icon: Icon(Icons.format_list_numbered_rtl),

              )
            ],
            title: Text(listAllGirls==null||listAllGirls.isEmpty?name:"$name (${listAllGirls.length})",style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold)),
          ),
          body: StreamBuilder(
            stream: DatabaseProvider.instance.readPersonByGender("female").asStream(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                var data = snapshot.data as List<PersonModel>;
                if(data.isNotEmpty){
                  listAllGirls = data;
                }
              }
              return listAllGirls!=null&&listAllGirls.isNotEmpty?RefreshIndicator(
                onRefresh: onRefresh,
                child: ListView.builder(
                  itemCount: listAllGirls.length,
                  itemBuilder: (_,index){
                    return Card(
                      margin: EdgeInsets.all(10),
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      shadowColor: Theme.of(context).primaryColor,
                      child: NameItem(id: listAllGirls[index].id,name: listAllGirls[index].name, gender: listAllGirls[index].gender, typeUser: listAllGirls[index].typeUser,code: listAllGirls[index].code,classNumber: listAllGirls[index].classNumber, deleteItem: (id) async {
                        showDialog(context: context, builder: (context)=>const CircularProgressIndicator(),barrierDismissible: false);
                        await DatabaseProvider.instance.deletePerson(id);
                        setState((){
                          listAllGirls.remove(listAllGirls[index]);
                        });
                        Navigator.pop(context);
                      },
                      personAttend: (id){},),
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
                await Navigator.of(context).pushNamed(AddNameScreen.routeName,arguments: {
                  "typeUser":"بنت",
                });
                setState((){
                  listAllGirls.clear();
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
      ],
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

      listAllGirls.clear();
    });
  }
}
