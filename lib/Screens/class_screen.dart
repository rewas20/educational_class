import 'package:educational_class/Models/class.dart';
import 'package:educational_class/Provider/db_provider.dart';
import 'package:educational_class/Widgets/class_item.dart';
import 'package:flutter/material.dart';

class ClassScreen extends StatefulWidget {
  static const routeName = "CLASS_SCREEN";
  const ClassScreen({super.key});

  @override
  State<ClassScreen> createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> {
  List<ClassModel> classList = [];
  @override
  Widget build(BuildContext context) {
    final model = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        toolbarHeight: 70,
        title: Text(model['name'],
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white)),

      ),
      body: StreamBuilder(
        stream: DatabaseProvider.instance.readAllClasses().asStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data as List<ClassModel>;
            if (data.isNotEmpty) {
              classList = data;
            }
          }
          return classList != null && classList.isNotEmpty
              ? RefreshIndicator(
              child: GridView(
                padding: const EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent:
                  MediaQuery.of(context).size.width * 0.5,
                  childAspectRatio: 4 / 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                children: classList
                    .map((clData) => ClassItem(
                    name: clData.name,
                    type: model['type'],
                    classNumber: clData.classNumber,
                    ))
                    .toList(),
              ),
              onRefresh: onRefresh)
              : Center(
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
        },
      ),
    );
  }
  Future onRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      classList.clear();
    });
  }
}
