
import 'package:educational_class/Models/menu_item.dart';
import 'package:flutter/material.dart';

class MenuItems{

  static const List<MenuItemModel> itemsFirst = [
    itemImportData,
    itemUploadData,
  ];
  static const List<MenuItemModel> itemsSecond = [
    itemTotalGrade
  ];


  static const itemImportData = MenuItemModel(
        text: "سحب من السيرفر",
        icon: Icons.download_rounded
      );
  static const itemUploadData = MenuItemModel(
        text: "رفع الي الٍسيرفر",
        icon: Icons.cloud_upload
      );
  static const itemTotalGrade = MenuItemModel(
        text: "مجموع الدرجات",
        icon: Icons.calculate_rounded
      );
}