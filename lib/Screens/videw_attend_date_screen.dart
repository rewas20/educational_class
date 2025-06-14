import 'package:educational_class/Provider/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';


class ViewAttendDateScreen extends StatefulWidget {
  static const routeName = "VIEW_ATTEND_DATE_SCREEN";
  const ViewAttendDateScreen({Key? key}) : super(key: key);

  @override
  State<ViewAttendDateScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewAttendDateScreen> {
  Map<String, String> daysNames = {
    'Monday': 'الاثنين',
    'Tuesday': 'الثلاثاء',
    'Wednesday': 'الأربعاء',
    'Thursday': 'الخميس',
    'Friday': 'الجمعة',
    'Saturday': 'السبت',
    'Sunday': 'الأحد',
  };
  List<String> listAllDate =[];
  List<String> listRemove = [];
  List<bool> checklist = [];
  List<Icon> iconCheckList = [];
  Icon iconCheckAll = Icon(Icons.check_box_outline_blank,size: 20);
  bool checkAll = false;
  @override
  Widget build(BuildContext context) {
    final classNumber = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text("Dates"),
        toolbarHeight: 70,
        actions: [
          IconButton(
            onPressed: (){
              if(checkAll){
                setState((){
                  for(int i = 0;i<iconCheckList.length;i++){
                    iconCheckList[i] = Icon(Icons.check_box_outline_blank,size: 20);
                    checklist[i] = false;
                  }
                  iconCheckAll = Icon(Icons.check_box_outline_blank,size: 20);
                  checkAll = false;
                  listRemove.clear();
                });
              }else{
                setState((){
                  for(int i = 0;i<iconCheckList.length;i++){
                    iconCheckList[i] = Icon(Icons.check_box,size: 20);
                    checklist[i] = true;
                  }
                  iconCheckAll = Icon(Icons.check_box,size: 20);
                  checkAll = true;
                  listRemove = listAllDate;
                });
              }
            },
            icon: iconCheckAll,
          ),
        ],
      ),
      body: StreamBuilder(
        stream: DatabaseProvider.instance.readAllAttendByDateByClass(classNumber).asStream(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var data = snapshot.data as List<String>;
            if(data.isNotEmpty){
              listAllDate = data;
              listAllDate.sort((a, b) {
                DateTime dateA = parseDate(a);
                DateTime dateB = parseDate(b);
                return dateB.compareTo(dateA);
              });
            }
          }
          return listAllDate!=null&&listAllDate.isNotEmpty?RefreshIndicator(
            onRefresh: onRefresh,
            child: ListView.builder(
                itemCount: listAllDate.length,
                itemBuilder: (conxt,index){
                  iconCheckList.add(Icon(Icons.check_box_outline_blank,size: 20));
                  checklist.add(false);
                  List<String> arrayDate =  listAllDate[index].split('/');
                  String newDate = "${arrayDate[2]}-${arrayDate[1]}-${arrayDate[0]}";
                  String getDay = DateFormat('EEEE').format(DateFormat('yyyy-MM-dd').parse(newDate));
                  String day = daysNames[getDay]??'';
                  return Card(
                    margin: EdgeInsets.all(20),
                    child: ListTile(
                      title: Text(newDate+" $day",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
                      trailing: IconButton(
                        onPressed: (){
                          if(checklist[index]){
                            if(listRemove.length==listAllDate.length){
                              setState((){
                                iconCheckAll = iconCheckAll = Icon(Icons.check_box_outline_blank,size: 20);
                                checkAll = false;
                              });
                            }
                            setState((){
                              iconCheckList[index] = Icon(Icons.check_box_outline_blank,size: 20);
                              checklist[index] = false;
                              listRemove.remove(listAllDate[index]);
                            });

                          }
                          else{
                            setState((){
                              iconCheckList[index] = Icon(Icons.check_box,size: 20);
                              checklist[index] = true;
                              listRemove.add(listAllDate[index]);
                            });
                            if(listRemove.length==listAllDate.length){
                              setState((){
                                iconCheckAll = Icon(Icons.check_box,size: 20);
                                checkAll = true;
                              });
                            }
                          }
                        },
                        icon: iconCheckList[index],
                      ),
                    ),
                  );
                }
            ),
          ):Center(child: Container(alignment: Alignment.center,child: Text("No Data"),),);
        },
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.all(20),
        child: FloatingActionButton(
          onPressed: (){
            listRemove==null||listRemove.isEmpty?Fluttertoast.showToast(msg: "لا يوجد تحديد"):showDialog(context: context, builder: (context)=>AlertDialog(
              title: Text("هل انت متأكد ؟"),
              titleTextStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.black),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              actionsPadding: EdgeInsets.all(10),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              alignment: Alignment.center,
              actions: [
                TextButton(
                  onPressed: (){
                    showDialog(context: context, builder: (context)=>Center(child: CircularProgressIndicator(),));
                    listRemove.forEach((element) async {
                      await DatabaseProvider.instance.deleteAttendByDateWithClassNumber(element,classNumber);
                    });
                    Fluttertoast.showToast(msg: "تم");
                    Navigator.pop(context);
                    Navigator.pop(context);
                    setState((){
                      listAllDate.clear();
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text("نعم",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800))
                ),
                TextButton(
                  onPressed: (){
                    Fluttertoast.showToast(msg: "الغاء");
                    Navigator.pop(context);
                  },
                  child: Text("لا",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800))
                ),
              ],
            ));
          },
          child: Icon(Icons.delete,size: 25,),
        ),
      ),
    );
  }
  Future onRefresh() async{
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
