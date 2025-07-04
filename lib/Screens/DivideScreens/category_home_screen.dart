import 'package:educational_class/Data/data.dart';
import 'package:educational_class/Widgets/category_item.dart';
import 'package:flutter/material.dart';


class CategoriesDivideScreen extends StatelessWidget {
  const CategoriesDivideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
        childAspectRatio: 3/2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: CATEGORY_HOME.map((caData) => CategoryItem(type: caData.type,name: caData.name, routeName: caData.routeName) ).toList(),

    );
  }
}
