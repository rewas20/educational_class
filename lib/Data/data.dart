import 'package:educational_class/Models/class.dart';
import 'package:educational_class/Screens/attendance_screen.dart';
import 'package:educational_class/Screens/boys_screen.dart';
import 'package:educational_class/Screens/class_screen.dart';
import 'package:educational_class/Screens/girls_screen.dart';
import 'package:educational_class/Screens/names_screen.dart';
import 'package:educational_class/Screens/scan_screen.dart';

import '../Models/category.dart';
import '../Models/person.dart';
import '../Models/question.dart';

var CATEGORY_HOME = [
  CategoryModel(name: "QR مسح", routeName: ScanScreen.routeName,type: 'qr'),
  CategoryModel(name: "الاسماء", routeName: ClassScreen.routeName,type: 'names'),
  CategoryModel(name: "الحضور", routeName: ClassScreen.routeName,type: 'attendance'),
];

var QUESTION_DATA = [
  QuestionModel(question: "الصلاة", grade: '1'),
  QuestionModel(question: "فكر مسيحي", grade: '1'),
];

var CLASSS_DATA = [
  ClassModel(name: "الصف الاول", classNumber: 'EC.1'),
  ClassModel(name: "الصف الثاني", classNumber: 'EC.2'),
  ClassModel(name: "الصف الثالث", classNumber: 'EC.3'),
  ClassModel(name: "الصف الرابع", classNumber: 'EC.4'),
];

var CATEGORY_NAMES = [
  CategoryModel(name: "الولاد", routeName: BoysScreen.routeName,type: 'boys'),
  CategoryModel(name: "البنات", routeName: GirlsScreen.routeName,type: 'girls'),
];

var DATA_PERSONS = [
  // EC.1 additional entries
  PersonModel(name: "ان كرم", gender: "female", typeUser: 'فرد', code: '1', classNumber: 'EC.1'),
  PersonModel(name: "ارساني خالد خلف", gender: "male", typeUser: 'فرد', code: '2', classNumber: 'EC.1'),
  PersonModel(name: "ايتن مجدي", gender: "female", typeUser: 'فرد', code: '3', classNumber: 'EC.1'),
  PersonModel(name: "ايريني سامح", gender: "female", typeUser: 'فرد', code: '4', classNumber: 'EC.1'),
  PersonModel(name: "ايريني عاطف ظريف", gender: "female", typeUser: 'فرد', code: '5', classNumber: 'EC.1'),
  PersonModel(name: "ايريني هاني", gender: "female", typeUser: 'فرد', code: '6', classNumber: 'EC.1'),
  PersonModel(name: "ايلاريا عاطف ظريف", gender: "female", typeUser: 'فرد', code: '7', classNumber: 'EC.1'),
  PersonModel(name: "باتريك بيتر خميس", gender: "male", typeUser: 'فرد', code: '8', classNumber: 'EC.1'),
  PersonModel(name: "بيشوي ميلاد عدلي", gender: "male", typeUser: 'فرد', code: '9', classNumber: 'EC.1'),
  PersonModel(name: "بيشوي مينا عجايبي", gender: "male", typeUser: 'فرد', code: '10', classNumber: 'EC.1'),
  PersonModel(name: "توماس البرت فايز", gender: "male", typeUser: 'فرد', code: '11', classNumber: 'EC.1'),
  PersonModel(name: "توني مينا", gender: "male", typeUser: 'فرد', code: '12', classNumber: 'EC.1'),
  PersonModel(name: "جونير سامح", gender: "female", typeUser: 'فرد', code: '13', classNumber: 'EC.1'),
  PersonModel(name: "جويس رامي فكري", gender: "female", typeUser: 'فرد', code: '14', classNumber: 'EC.1'),
  PersonModel(name: "جيسي اسامه", gender: "female", typeUser: 'فرد', code: '15', classNumber: 'EC.1'),
  PersonModel(name: "ستيفن عماد", gender: "male", typeUser: 'فرد', code: '16', classNumber: 'EC.1'),
  PersonModel(name: "شادي ميلاد ذكي", gender: "male", typeUser: 'فرد', code: '17', classNumber: 'EC.1'),
  PersonModel(name: "عهد هاني سمير", gender: "female", typeUser: 'فرد', code: '18', classNumber: 'EC.1'),
  PersonModel(name: "فادي اشرف سليمان", gender: "male", typeUser: 'فرد', code: '19', classNumber: 'EC.1'),
  PersonModel(name: "فادي ايمن", gender: "male", typeUser: 'فرد', code: '20', classNumber: 'EC.1'),
  PersonModel(name: "فريده مايكل سعيد", gender: "female", typeUser: 'فرد', code: '21', classNumber: 'EC.1'),
  PersonModel(name: "فيرونيا عماد صهيون", gender: "female", typeUser: 'فرد', code: '22', classNumber: 'EC.1'),
  PersonModel(name: "فيلوباتير عماد صبحي", gender: "male", typeUser: 'فرد', code: '23', classNumber: 'EC.1'),
  PersonModel(name: "كاراس البرت فايز", gender: "male", typeUser: 'فرد', code: '24', classNumber: 'EC.1'),
  PersonModel(name: "كاراس ماجد", gender: "male", typeUser: 'فرد', code: '25', classNumber: 'EC.1'),
  PersonModel(name: "كاراس ناصر ظريف", gender: "male", typeUser: 'فرد', code: '26', classNumber: 'EC.1'),
  PersonModel(name: "كارين بيشوي", gender: "female", typeUser: 'فرد', code: '27', classNumber: 'EC.1'),
  PersonModel(name: "كيرلس روماني جميل", gender: "male", typeUser: 'فرد', code: '28', classNumber: 'EC.1'),
  PersonModel(name: "كيرلس عادل عبد المسيح", gender: "male", typeUser: 'فرد', code: '29', classNumber: 'EC.1'),
  PersonModel(name: "لورين سامي رتيب", gender: "female", typeUser: 'فرد', code: '30', classNumber: 'EC.1'),
  PersonModel(name: "لوسيندا رزق بخيت", gender: "female", typeUser: 'فرد', code: '31', classNumber: 'EC.1'),
  PersonModel(name: "مارتن روماني توفيق", gender: "male", typeUser: 'فرد', code: '32', classNumber: 'EC.1'),
  PersonModel(name: "مارسلينو فادي", gender: "male", typeUser: 'فرد', code: '33', classNumber: 'EC.1'),
  PersonModel(name: "ماريا مينا", gender: "female", typeUser: 'فرد', code: '34', classNumber: 'EC.1'),
  PersonModel(name: "مايكل عادل", gender: "male", typeUser: 'فرد', code: '35', classNumber: 'EC.1'),
  PersonModel(name: "مريم رشدي عزيز", gender: "female", typeUser: 'فرد', code: '36', classNumber: 'EC.1'),
  PersonModel(name: "مريم يسي فتحي", gender: "female", typeUser: 'فرد', code: '37', classNumber: 'EC.1'),
  PersonModel(name: "مهرائيل ميلاد فهمي", gender: "female", typeUser: 'فرد', code: '38', classNumber: 'EC.1'),
  PersonModel(name: "ميرا مجدي خليل", gender: "female", typeUser: 'فرد', code: '39', classNumber: 'EC.1'),
  PersonModel(name: "ميراي ايهاب", gender: "female", typeUser: 'فرد', code: '40', classNumber: 'EC.1'),
  PersonModel(name: "مينا صفوت عبد الله", gender: "male", typeUser: 'فرد', code: '41', classNumber: 'EC.1'),
  PersonModel(name: "مينا ماجد فؤاد", gender: "male", typeUser: 'فرد', code: '42', classNumber: 'EC.1'),
  PersonModel(name: "يوسف رافت", gender: "male", typeUser: 'فرد', code: '43', classNumber: 'EC.1'),
  PersonModel(name: "اندرو ھاني", gender: "male", typeUser: 'فرد', code: '44', classNumber: 'EC.1'),
  PersonModel(name: "ایریني ماجد", gender: "female", typeUser: 'فرد', code: '45', classNumber: 'EC.1'),
  PersonModel(name: "ابانوب ھاني", gender: "male", typeUser: 'فرد', code: '46', classNumber: 'EC.1'),
  PersonModel(name: "انجي مینا", gender: "female", typeUser: 'فرد', code: '47', classNumber: 'EC.1'),
  PersonModel(name: "ایلاریا رفعت", gender: "female", typeUser: 'فرد', code: '48', classNumber: 'EC.1'),
  PersonModel(name: "باتریك فادي", gender: "male", typeUser: 'فرد', code: '49', classNumber: 'EC.1'),
  PersonModel(name: "بارثینیا وائل", gender: "female", typeUser: 'فرد', code: '50', classNumber: 'EC.1'),
  PersonModel(name: "بافلي شريف", gender: "male", typeUser: 'فرد', code: '51', classNumber: 'EC.1'),
  PersonModel(name: "بتول ثروت", gender: "female", typeUser: 'فرد', code: '52', classNumber: 'EC.1'),
  PersonModel(name: "بتول طارق", gender: "female", typeUser: 'فرد', code: '53', classNumber: 'EC.1'),
  PersonModel(name: "بولا ایھاب", gender: "male", typeUser: 'فرد', code: '54', classNumber: 'EC.1'),
  PersonModel(name: "بولا سامي", gender: "male", typeUser: 'فرد', code: '55', classNumber: 'EC.1'),
  PersonModel(name: "بیمن فرید", gender: "male", typeUser: 'فرد', code: '56', classNumber: 'EC.1'),
  PersonModel(name: "توماس نبیل", gender: "male", typeUser: 'فرد', code: '57', classNumber: 'EC.1'),
  PersonModel(name: "جاكوب ريمون", gender: "male", typeUser: 'فرد', code: '58', classNumber: 'EC.1'),
  PersonModel(name: "جان سامح", gender: "male", typeUser: 'فرد', code: '59', classNumber: 'EC.1'),
  PersonModel(name: "جرجس سامح", gender: "male", typeUser: 'فرد', code: '60', classNumber: 'EC.1'),
  PersonModel(name: "جرجس سعيد", gender: "male", typeUser: 'فرد', code: '61', classNumber: 'EC.1'),
  PersonModel(name: "جوفاني بولس", gender: "male", typeUser: 'فرد', code: '62', classNumber: 'EC.1'),
  PersonModel(name: "جولي اسامة", gender: "female", typeUser: 'فرد', code: '63', classNumber: 'EC.1'),
  PersonModel(name: "جولیا نادر", gender: "female", typeUser: 'فرد', code: '64', classNumber: 'EC.1'),
  PersonModel(name: "جومانا يوسف", gender: "female", typeUser: 'فرد', code: '65', classNumber: 'EC.1'),
  PersonModel(name: "جوني مدحت", gender: "male", typeUser: 'فرد', code: '66', classNumber: 'EC.1'),
  PersonModel(name: "جونیر عزت", gender: "female", typeUser: 'فرد', code: '67', classNumber: 'EC.1'),
  PersonModel(name: "جونیر مدحت میلاد", gender: "female", typeUser: 'فرد', code: '68', classNumber: 'EC.1'),
  PersonModel(name: "جویس یوسف", gender: "female", typeUser: 'فرد', code: '69', classNumber: 'EC.1'),
  PersonModel(name: "دیفید میخائیل", gender: "male", typeUser: 'فرد', code: '70', classNumber: 'EC.1'),
  PersonModel(name: "ریموندا مكرم اللھ", gender: "female", typeUser: 'فرد', code: '71', classNumber: 'EC.1'),
  PersonModel(name: "سارة رفيق", gender: "female", typeUser: 'فرد', code: '72', classNumber: 'EC.1'),
  PersonModel(name: "فادي مطر", gender: "male", typeUser: 'فرد', code: '73', classNumber: 'EC.1'),
  PersonModel(name: "فیرونیكا ریجان", gender: "female", typeUser: 'فرد', code: '74', classNumber: 'EC.1'),
  PersonModel(name: "فیلوباتیر بیشوي", gender: "male", typeUser: 'فرد', code: '75', classNumber: 'EC.1'),
  PersonModel(name: "فیلوباتیر شریف", gender: "male", typeUser: 'فرد', code: '76', classNumber: 'EC.1'),
  PersonModel(name: "فیلوباتیر عاطف", gender: "male", typeUser: 'فرد', code: '77', classNumber: 'EC.1'),
  PersonModel(name: "فیلوباتیر میلاد", gender: "male", typeUser: 'فرد', code: '78', classNumber: 'EC.1'),
  PersonModel(name: "فیلوباتیر نجیب", gender: "male", typeUser: 'فرد', code: '79', classNumber: 'EC.1'),
  PersonModel(name: "فیولا شریف", gender: "female", typeUser: 'فرد', code: '80', classNumber: 'EC.1'),
  PersonModel(name: "كاراس ایمن", gender: "male", typeUser: 'فرد', code: '81', classNumber: 'EC.1'),
  PersonModel(name: "كاراس مینا", gender: "male", typeUser: 'فرد', code: '82', classNumber: 'EC.1'),
  PersonModel(name: "كاراس وجیھ", gender: "male", typeUser: 'فرد', code: '83', classNumber: 'EC.1'),
  PersonModel(name: "كلاریس اسبیرو", gender: "female", typeUser: 'فرد', code: '84', classNumber: 'EC.1'),
  PersonModel(name: "كیرلس ماجد", gender: "male", typeUser: 'فرد', code: '85', classNumber: 'EC.1'),
  PersonModel(name: "كیرلس میشیل", gender: "male", typeUser: 'فرد', code: '86', classNumber: 'EC.1'),
  PersonModel(name: "كیرلس نجیب", gender: "male", typeUser: 'فرد', code: '87', classNumber: 'EC.1'),
  PersonModel(name: "لافي ایھاب", gender: "female", typeUser: 'فرد', code: '88', classNumber: 'EC.1'),
  PersonModel(name: "ماري تواضروس", gender: "female", typeUser: 'فرد', code: '89', classNumber: 'EC.1'),
  PersonModel(name: "ماریا ماجد", gender: "female", typeUser: 'فرد', code: '90', classNumber: 'EC.1'),
  PersonModel(name: "مريم رزق", gender: "female", typeUser: 'فرد', code: '91', classNumber: 'EC.1'),
  PersonModel(name: "مریم سامر", gender: "female", typeUser: 'فرد', code: '92', classNumber: 'EC.1'),
  PersonModel(name: "مریم عادل", gender: "female", typeUser: 'فرد', code: '93', classNumber: 'EC.1'),
  PersonModel(name: "مریم فوزي", gender: "female", typeUser: 'فرد', code: '94', classNumber: 'EC.1'),
  PersonModel(name: "مریم وجیھ", gender: "female", typeUser: 'فرد', code: '95', classNumber: 'EC.1'),
  PersonModel(name: "مریم ولید", gender: "female", typeUser: 'فرد', code: '96', classNumber: 'EC.1'),
  PersonModel(name: "مينا جورج عادل", gender: "male", typeUser: 'فرد', code: '97', classNumber: 'EC.1'),
  PersonModel(name: "مینا جاد", gender: "male", typeUser: 'فرد', code: '98', classNumber: 'EC.1'),
  PersonModel(name: "مینا عماد", gender: "male", typeUser: 'فرد', code: '99', classNumber: 'EC.1'),
  PersonModel(name: "مینا ھشام", gender: "male", typeUser: 'فرد', code: '100', classNumber: 'EC.1'),
  PersonModel(name: "نجيب جورج", gender: "male", typeUser: 'فرد', code: '101', classNumber: 'EC.1'),
  PersonModel(name: "یوانا ایمن", gender: "female", typeUser: 'فرد', code: '102', classNumber: 'EC.1'),
  PersonModel(name: "یوستینا عزیز", gender: "female", typeUser: 'فرد', code: '103', classNumber: 'EC.1'),

  //EC.2
  PersonModel(name: "اجنس عماد", gender: "female", typeUser: 'فرد', code: '1', classNumber: 'EC.2'),
  PersonModel(name: "انطونیوس وائل", gender: "male", typeUser: 'فرد', code: '2', classNumber: 'EC.2'),
  PersonModel(name: "اوجيستا وليم", gender: "female", typeUser: 'فرد', code: '3', classNumber: 'EC.2'),
  PersonModel(name: "ايريني سمير", gender: "female", typeUser: 'فرد', code: '4', classNumber: 'EC.2'),
  PersonModel(name: "ايلاريا هاني", gender: "female", typeUser: 'فرد', code: '5', classNumber: 'EC.2'),
  PersonModel(name: "بارثینیا مینا", gender: "female", typeUser: 'فرد', code: '6', classNumber: 'EC.2'),
  PersonModel(name: "باسیلیوس بطرس", gender: "male", typeUser: 'فرد', code: '7', classNumber: 'EC.2'),
  PersonModel(name: "بافلي القس", gender: "male", typeUser: 'فرد', code: '8', classNumber: 'EC.2'),
  PersonModel(name: "بافلي ماجد", gender: "male", typeUser: 'فرد', code: '9', classNumber: 'EC.2'),
  PersonModel(name: "بيشوي ايوب", gender: "male", typeUser: 'فرد', code: '10', classNumber: 'EC.2'),
  PersonModel(name: "جولیا جمیل", gender: "female", typeUser: 'فرد', code: '11', classNumber: 'EC.2'),
  PersonModel(name: "جومانا جرجس", gender: "female", typeUser: 'فرد', code: '12', classNumber: 'EC.2'),
  PersonModel(name: "جون نبيل", gender: "male", typeUser: 'فرد', code: '13', classNumber: 'EC.2'),
  PersonModel(name: "جونير راجي", gender: "female", typeUser: 'فرد', code: '14', classNumber: 'EC.2'),
  PersonModel(name: "جونیر امجد", gender: "female", typeUser: 'فرد', code: '15', classNumber: 'EC.2'),
  PersonModel(name: "جونیر فادي", gender: "female", typeUser: 'فرد', code: '16', classNumber: 'EC.2'),
  PersonModel(name: "جونیر نادر", gender: "female", typeUser: 'فرد', code: '17', classNumber: 'EC.2'),
  PersonModel(name: "جونیر ولید", gender: "female", typeUser: 'فرد', code: '18', classNumber: 'EC.2'),
  PersonModel(name: "جویس ماجد", gender: "female", typeUser: 'فرد', code: '19', classNumber: 'EC.2'),
  PersonModel(name: "جویس ھاني", gender: "female", typeUser: 'فرد', code: '20', classNumber: 'EC.2'),
  PersonModel(name: "جینا جورج", gender: "female", typeUser: 'فرد', code: '21', classNumber: 'EC.2'),
  PersonModel(name: "ديفيد نبيل", gender: "male", typeUser: 'فرد', code: '22', classNumber: 'EC.2'),
  PersonModel(name: "سارة اسحق", gender: "female", typeUser: 'فرد', code: '23', classNumber: 'EC.2'),
  PersonModel(name: "ساره عماد", gender: "female", typeUser: 'فرد', code: '24', classNumber: 'EC.2'),
  PersonModel(name: "ساره وجیه", gender: "female", typeUser: 'فرد', code: '25', classNumber: 'EC.2'),
  PersonModel(name: "عماد مجدى", gender: "male", typeUser: 'فرد', code: '26', classNumber: 'EC.2'),
  PersonModel(name: "فیلوباتیر عماد", gender: "male", typeUser: 'فرد', code: '27', classNumber: 'EC.2'),
  PersonModel(name: "فیلوباتیر منصف", gender: "male", typeUser: 'فرد', code: '28', classNumber: 'EC.2'),
  PersonModel(name: "كاراس میشیل", gender: "male", typeUser: 'فرد', code: '29', classNumber: 'EC.2'),
  PersonModel(name: "كارن ایمن", gender: "female", typeUser: 'فرد', code: '30', classNumber: 'EC.2'),
  PersonModel(name: "كیرلس سامي", gender: "male", typeUser: 'فرد', code: '31', classNumber: 'EC.2'),
  PersonModel(name: "كیرمینا یوسف جمال", gender: "male", typeUser: 'فرد', code: '32', classNumber: 'EC.2'),
  PersonModel(name: "كیفین میلاد", gender: "male", typeUser: 'فرد', code: '33', classNumber: 'EC.2'),
  PersonModel(name: "لوسندا لوقا", gender: "female", typeUser: 'فرد', code: '34', classNumber: 'EC.2'),
  PersonModel(name: "ماثیو عماد", gender: "male", typeUser: 'فرد', code: '35', classNumber: 'EC.2'),
  PersonModel(name: "مارسلینو تامر", gender: "male", typeUser: 'فرد', code: '36', classNumber: 'EC.2'),
  PersonModel(name: "مارلي میلاد", gender: "female", typeUser: 'فرد', code: '37', classNumber: 'EC.2'),
  PersonModel(name: "ماروسكا میخائیل", gender: "female", typeUser: 'فرد', code: '38', classNumber: 'EC.2'),
  PersonModel(name: "ماریا سامح", gender: "female", typeUser: 'فرد', code: '39', classNumber: 'EC.2'),
  PersonModel(name: "ماریا عماد", gender: "female", typeUser: 'فرد', code: '40', classNumber: 'EC.2'),
  PersonModel(name: "ماریا محب", gender: "female", typeUser: 'فرد', code: '41', classNumber: 'EC.2'),
  PersonModel(name: "ماریو ماجد", gender: "male", typeUser: 'فرد', code: '42', classNumber: 'EC.2'),
  PersonModel(name: "مايكل لطفي", gender: "male", typeUser: 'فرد', code: '43', classNumber: 'EC.2'),
  PersonModel(name: "مایفن وحید", gender: "female", typeUser: 'فرد', code: '44', classNumber: 'EC.2'),
  PersonModel(name: "مایكل سامح", gender: "male", typeUser: 'فرد', code: '45', classNumber: 'EC.2'),
  PersonModel(name: "مريم ايوب", gender: "female", typeUser: 'فرد', code: '46', classNumber: 'EC.2'),
  PersonModel(name: "مريم عماد", gender: "female", typeUser: 'فرد', code: '47', classNumber: 'EC.2'),
  PersonModel(name: "مریام رامي", gender: "female", typeUser: 'فرد', code: '48', classNumber: 'EC.2'),
  PersonModel(name: "مریم جورج", gender: "female", typeUser: 'فرد', code: '49', classNumber: 'EC.2'),
  PersonModel(name: "مریم یوحنا", gender: "female", typeUser: 'فرد', code: '50', classNumber: 'EC.2'),
  PersonModel(name: "مهرائيل علاء", gender: "female", typeUser: 'فرد', code: '51', classNumber: 'EC.2'),
  PersonModel(name: "مھرائیل رافت ذكى", gender: "female", typeUser: 'فرد', code: '52', classNumber: 'EC.2'),
  PersonModel(name: "میرولا رومانى", gender: "female", typeUser: 'فرد', code: '53', classNumber: 'EC.2'),
  PersonModel(name: "میرولا ھانى", gender: "female", typeUser: 'فرد', code: '54', classNumber: 'EC.2'),
  PersonModel(name: "مینا ملاك", gender: "male", typeUser: 'فرد', code: '55', classNumber: 'EC.2'),
  PersonModel(name: "مینا میشیل", gender: "male", typeUser: 'فرد', code: '56', classNumber: 'EC.2'),
  PersonModel(name: "یوانا عادل", gender: "female", typeUser: 'فرد', code: '57', classNumber: 'EC.2'),
  PersonModel(name: "یوانا عماد", gender: "female", typeUser: 'فرد', code: '58', classNumber: 'EC.2'),
  PersonModel(name: "یوسف ھشام", gender: "male", typeUser: 'فرد', code: '59', classNumber: 'EC.2'),
  PersonModel(name: "ابانوب میخائیل", gender: "male", typeUser: 'فرد', code: '60', classNumber: 'EC.2'),
  PersonModel(name: "انطونیوس جورج", gender: "male", typeUser: 'فرد', code: '61', classNumber: 'EC.2'),
  PersonModel(name: "ایریني سامح", gender: "female", typeUser: 'فرد', code: '62', classNumber: 'EC.2'),
  PersonModel(name: "ایریني مجدي", gender: "female", typeUser: 'فرد', code: '63', classNumber: 'EC.2'),
  PersonModel(name: "بافلي ھاني", gender: "male", typeUser: 'فرد', code: '64', classNumber: 'EC.2'),
  PersonModel(name: "بربارة بشاى", gender: "female", typeUser: 'فرد', code: '65', classNumber: 'EC.2'),
  PersonModel(name: "بسنت رفعت", gender: "female", typeUser: 'فرد', code: '66', classNumber: 'EC.2'),
  PersonModel(name: "جاستین میلاد", gender: "female", typeUser: 'فرد', code: '67', classNumber: 'EC.2'),
  PersonModel(name: "جولیا جرجس", gender: "female", typeUser: 'فرد', code: '68', classNumber: 'EC.2'),
  PersonModel(name: "مارلي محب", gender: "female", typeUser: 'فرد', code: '69', classNumber: 'EC.2'),
  PersonModel(name: "ماري جرجس", gender: "female", typeUser: 'فرد', code: '70', classNumber: 'EC.2'),
  PersonModel(name: "ماریا سامح", gender: "female", typeUser: 'فرد', code: '71', classNumber: 'EC.2'),
  PersonModel(name: "میریام رامي", gender: "female", typeUser: 'فرد', code: '72', classNumber: 'EC.2'),
  PersonModel(name: "مینا نشات", gender: "male", typeUser: 'فرد', code: '73', classNumber: 'EC.2'),
  PersonModel(name: "نور ثروت", gender: "female", typeUser: 'فرد', code: '74', classNumber: 'EC.2'),

  // EC.3
    PersonModel(name: "اوناي ملاك", gender: "female", typeUser: 'فرد', code: '1', classNumber: 'EC.3'),
  PersonModel(name: "انسطاسیا اشرف", gender: "female", typeUser: 'فرد', code: '2', classNumber: 'EC.3'),
  PersonModel(name: "ایفیت مایكل", gender: "female", typeUser: 'فرد', code: '3', classNumber: 'EC.3'),
  PersonModel(name: "ثروت هاني", gender: "male", typeUser: 'فرد', code: '4', classNumber: 'EC.3'),
  PersonModel(name: "جاسمین اكرامي", gender: "female", typeUser: 'فرد', code: '5', classNumber: 'EC.3'),
  PersonModel(name: "جورج عبد المسیح", gender: "male", typeUser: 'فرد', code: '6', classNumber: 'EC.3'),
  PersonModel(name: "جوستینا ناصر", gender: "female", typeUser: 'فرد', code: '7', classNumber: 'EC.3'),
  PersonModel(name: "جولیا اشرف", gender: "female", typeUser: 'فرد', code: '8', classNumber: 'EC.3'),
  PersonModel(name: "جومانا جورج", gender: "female", typeUser: 'فرد', code: '9', classNumber: 'EC.3'),
  PersonModel(name: "جومانا ناصر", gender: "female", typeUser: 'فرد', code: '10', classNumber: 'EC.3'),
  PersonModel(name: "جون عماد", gender: "male", typeUser: 'فرد', code: '11', classNumber: 'EC.3'),
  PersonModel(name: "جون محب", gender: "male", typeUser: 'فرد', code: '12', classNumber: 'EC.3'),
  PersonModel(name: "جونیر رافت", gender: "female", typeUser: 'فرد', code: '13', classNumber: 'EC.3'),
  PersonModel(name: "جونیر عصام", gender: "female", typeUser: 'فرد', code: '14', classNumber: 'EC.3'),
  PersonModel(name: "جونیر عماد", gender: "female", typeUser: 'فرد', code: '15', classNumber: 'EC.3'),
  PersonModel(name: "جونیر مدحت كمال", gender: "female", typeUser: 'فرد', code: '16', classNumber: 'EC.3'),
  PersonModel(name: "جویل ایمن", gender: "female", typeUser: 'فرد', code: '17', classNumber: 'EC.3'),
  PersonModel(name: "جیوفاني رفیق", gender: "male", typeUser: 'فرد', code: '18', classNumber: 'EC.3'),
  PersonModel(name: "ساندي مجدي", gender: "female", typeUser: 'فرد', code: '19', classNumber: 'EC.3'),
  PersonModel(name: "سوسنة دانیال", gender: "female", typeUser: 'فرد', code: '20', classNumber: 'EC.3'),
  PersonModel(name: "فيلوباتير نجيب", gender: "male", typeUser: 'فرد', code: '21', classNumber: 'EC.3'),
  PersonModel(name: "فیرینا امیر", gender: "female", typeUser: 'فرد', code: '22', classNumber: 'EC.3'),
  PersonModel(name: "فیلوباتیر جورج", gender: "male", typeUser: 'فرد', code: '23', classNumber: 'EC.3'),
  PersonModel(name: "كاراس محب", gender: "male", typeUser: 'فرد', code: '24', classNumber: 'EC.3'),
  PersonModel(name: "كارل ایھاب", gender: "male", typeUser: 'فرد', code: '25', classNumber: 'EC.3'),
  PersonModel(name: "كارن جرجس", gender: "female", typeUser: 'فرد', code: '26', classNumber: 'EC.3'),
  PersonModel(name: "كارول عماد", gender: "female", typeUser: 'فرد', code: '27', classNumber: 'EC.3'),
  PersonModel(name: "كاندي جوزیف", gender: "female", typeUser: 'فرد', code: '28', classNumber: 'EC.3'),
  PersonModel(name: "كیرلس بطرس", gender: "male", typeUser: 'فرد', code: '29', classNumber: 'EC.3'),
  PersonModel(name: "كیرلس جوزیف", gender: "male", typeUser: 'فرد', code: '30', classNumber: 'EC.3'),
  PersonModel(name: "كیرلس حسني", gender: "male", typeUser: 'فرد', code: '31', classNumber: 'EC.3'),
  PersonModel(name: "كیرلس ریمون عادل", gender: "male", typeUser: 'فرد', code: '32', classNumber: 'EC.3'),
  PersonModel(name: "كیرلس ریمون ماھر", gender: "male", typeUser: 'فرد', code: '33', classNumber: 'EC.3'),
  PersonModel(name: "كیرلس غالى", gender: "male", typeUser: 'فرد', code: '34', classNumber: 'EC.3'),
  PersonModel(name: "كیرلس نعیم", gender: "male", typeUser: 'فرد', code: '35', classNumber: 'EC.3'),
  PersonModel(name: "لورا جاد", gender: "female", typeUser: 'فرد', code: '36', classNumber: 'EC.3'),
  PersonModel(name: "مارفل مجدي", gender: "female", typeUser: 'فرد', code: '37', classNumber: 'EC.3'),
  PersonModel(name: "ماریا رزق", gender: "female", typeUser: 'فرد', code: '38', classNumber: 'EC.3'),
  PersonModel(name: "ماریا عاطف", gender: "female", typeUser: 'فرد', code: '39', classNumber: 'EC.3'),
  PersonModel(name: "ماریا عماد", gender: "female", typeUser: 'فرد', code: '40', classNumber: 'EC.3'),
  PersonModel(name: "مارینا رفعت", gender: "female", typeUser: 'فرد', code: '41', classNumber: 'EC.3'),
  PersonModel(name: "مارینا مجدي", gender: "female", typeUser: 'فرد', code: '42', classNumber: 'EC.3'),
  PersonModel(name: "مانریت تامر", gender: "female", typeUser: 'فرد', code: '43', classNumber: 'EC.3'),
  PersonModel(name: "مایفین امیر", gender: "female", typeUser: 'فرد', code: '44', classNumber: 'EC.3'),
  PersonModel(name: "مایفین عماد", gender: "female", typeUser: 'فرد', code: '45', classNumber: 'EC.3'),
  PersonModel(name: "مایكل دانیال", gender: "male", typeUser: 'فرد', code: '46', classNumber: 'EC.3'),
  PersonModel(name: "منیرفا محب", gender: "female", typeUser: 'فرد', code: '47', classNumber: 'EC.3'),
  PersonModel(name: "مورین موریس", gender: "female", typeUser: 'فرد', code: '48', classNumber: 'EC.3'),
  PersonModel(name: "مونیكا وائل", gender: "female", typeUser: 'فرد', code: '49', classNumber: 'EC.3'),
  PersonModel(name: "میریام جان", gender: "female", typeUser: 'فرد', code: '50', classNumber: 'EC.3'),
  PersonModel(name: "میریام لطفي", gender: "female", typeUser: 'فرد', code: '51', classNumber: 'EC.3'),
  PersonModel(name: "مینا عاطف", gender: "male", typeUser: 'فرد', code: '52', classNumber: 'EC.3'),
  PersonModel(name: "مینا مجدي", gender: "male", typeUser: 'فرد', code: '53', classNumber: 'EC.3'),
  PersonModel(name: "یوستینا عماد", gender: "female", typeUser: 'فرد', code: '54', classNumber: 'EC.3'),
  PersonModel(name: "جرجس ممدوح", gender: "male", typeUser: 'فرد', code: '55', classNumber: 'EC.3'),
  PersonModel(name: "كارن یوحنا", gender: "female", typeUser: 'فرد', code: '56', classNumber: 'EC.3'),
  PersonModel(name: "مینا مجدى", gender: "male", typeUser: 'فرد', code: '57', classNumber: 'EC.3'),
  PersonModel(name: "مینا وجیه", gender: "male", typeUser: 'فرد', code: '58', classNumber: 'EC.3'),
  PersonModel(name: "یؤنا سامح", gender: "female", typeUser: 'فرد', code: '59', classNumber: 'EC.3'),
  PersonModel(name: "یوسف نادر", gender: "male", typeUser: 'فرد', code: '60', classNumber: 'EC.3'),

  // EC.4
    PersonModel(name: "اغابي يوحنا", gender: "female", typeUser: 'فرد', code: '1', classNumber: 'EC.4'),
  PersonModel(name: "اندرو ماجد", gender: "male", typeUser: 'فرد', code: '2', classNumber: 'EC.4'),
  PersonModel(name: "ایلاریا ھاني", gender: "female", typeUser: 'فرد', code: '3', classNumber: 'EC.4'),
  PersonModel(name: "بافلي سامي", gender: "male", typeUser: 'فرد', code: '4', classNumber: 'EC.4'),
  PersonModel(name: "بطرس روماني", gender: "male", typeUser: 'فرد', code: '5', classNumber: 'EC.4'),
  PersonModel(name: "بیشوي ایمن", gender: "male", typeUser: 'فرد', code: '6', classNumber: 'EC.4'),
  PersonModel(name: "ثیؤدورا امیر", gender: "female", typeUser: 'فرد', code: '7', classNumber: 'EC.4'),
  PersonModel(name: "جیسیكا ریمون", gender: "female", typeUser: 'فرد', code: '8', classNumber: 'EC.4'),
  PersonModel(name: "جیسیكا مجدي", gender: "female", typeUser: 'فرد', code: '9', classNumber: 'EC.4'),
  PersonModel(name: "دمیانة صموئیل", gender: "female", typeUser: 'فرد', code: '10', classNumber: 'EC.4'),
  PersonModel(name: "روبرت رومیل", gender: "male", typeUser: 'فرد', code: '11', classNumber: 'EC.4'),
  PersonModel(name: "ساندي ناصر", gender: "female", typeUser: 'فرد', code: '12', classNumber: 'EC.4'),
  PersonModel(name: "فیرونيا اشرف", gender: "female", typeUser: 'فرد', code: '13', classNumber: 'EC.4'),
  PersonModel(name: "كارن ایھاب", gender: "female", typeUser: 'فرد', code: '14', classNumber: 'EC.4'),
  PersonModel(name: "كالیستا مایكل", gender: "female", typeUser: 'فرد', code: '15', classNumber: 'EC.4'),
  PersonModel(name: "كیرلس جورج نجیب", gender: "male", typeUser: 'فرد', code: '16', classNumber: 'EC.4'),
  PersonModel(name: "مارتینا ماھر", gender: "female", typeUser: 'فرد', code: '17', classNumber: 'EC.4'),
  PersonModel(name: "ماریا ادوار", gender: "female", typeUser: 'فرد', code: '18', classNumber: 'EC.4'),
  PersonModel(name: "ماریز عماد", gender: "female", typeUser: 'فرد', code: '19', classNumber: 'EC.4'),
  PersonModel(name: "ماریز میشیل", gender: "female", typeUser: 'فرد', code: '20', classNumber: 'EC.4'),
  PersonModel(name: "مارینا دمیان", gender: "female", typeUser: 'فرد', code: '21', classNumber: 'EC.4'),
  PersonModel(name: "مایكل ریمون", gender: "male", typeUser: 'فرد', code: '22', classNumber: 'EC.4'),
  PersonModel(name: "مریم منصف", gender: "female", typeUser: 'فرد', code: '23', classNumber: 'EC.4'),
  PersonModel(name: "مھرائیل رفعت", gender: "female", typeUser: 'فرد', code: '24', classNumber: 'EC.4'),
  PersonModel(name: "مینا اشرف", gender: "male", typeUser: 'فرد', code: '25', classNumber: 'EC.4'),
  PersonModel(name: "ایریني فایز", gender: "female", typeUser: 'فرد', code: '26', classNumber: 'EC.4'),
  PersonModel(name: "ایلاریا اشرف", gender: "female", typeUser: 'فرد', code: '27', classNumber: 'EC.4'),
  PersonModel(name: "بیشوي عادل", gender: "male", typeUser: 'فرد', code: '28', classNumber: 'EC.4'),
  PersonModel(name: "جاسيكا ايمن", gender: "female", typeUser: 'فرد', code: '29', classNumber: 'EC.4'),
  PersonModel(name: "جویس جرجس", gender: "female", typeUser: 'فرد', code: '30', classNumber: 'EC.4'),
  PersonModel(name: "ریتشیل مایكل", gender: "female", typeUser: 'فرد', code: '31', classNumber: 'EC.4'),
  PersonModel(name: "ساندي ممدوح", gender: "female", typeUser: 'فرد', code: '32', classNumber: 'EC.4'),
  PersonModel(name: "فادي وجدي", gender: "male", typeUser: 'فرد', code: '33', classNumber: 'EC.4'),
  PersonModel(name: "فیرینا جرجس", gender: "female", typeUser: 'فرد', code: '34', classNumber: 'EC.4'),
  PersonModel(name: "كیرلس جورج تواضروس", gender: "male", typeUser: 'فرد', code: '35', classNumber: 'EC.4'),
  PersonModel(name: "مادونا رفعت", gender: "female", typeUser: 'فرد', code: '36', classNumber: 'EC.4'),
  PersonModel(name: "مارتیروس جرجس", gender: "male", typeUser: 'فرد', code: '37', classNumber: 'EC.4'),

];

