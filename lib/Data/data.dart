

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

  //EC.1 58 person
  PersonModel(name: "ابانوب ھانى", gender: "male", typeUser: 'فرد', code: '1', classNumber: 'EC.1'),
  PersonModel(name: "انطونیوس وائل", gender: "male", typeUser: 'فرد', code: '4', classNumber: 'EC.1'),
  PersonModel(name: "باتریك فادى", gender: "male", typeUser: 'فرد', code: '6', classNumber: 'EC.1'),
  PersonModel(name: "بافلي القس", gender: "male", typeUser: 'فرد', code: '8', classNumber: 'EC.1'),
  PersonModel(name: "بافلي ماجد", gender: "male", typeUser: 'فرد', code: '9', classNumber: 'EC.1'),
  PersonModel(name: "جوفاني بولس", gender: "male", typeUser: 'فرد', code: '11', classNumber: 'EC.1'),
  PersonModel(name: "عماد مجدى", gender: "male", typeUser: 'فرد', code: '24', classNumber: 'EC.1'),
  PersonModel(name: "فیلوباتیر منصف", gender: "male", typeUser: 'فرد', code: '26', classNumber: 'EC.1'),
  PersonModel(name: "كاراس میشیل", gender: "male", typeUser: 'فرد', code: '27', classNumber: 'EC.1'),
  PersonModel(name: "كاراس مینا", gender: "male", typeUser: 'فرد', code: '28', classNumber: 'EC.1'),
  PersonModel(name: "كاراس وجیھ", gender: "male", typeUser: 'فرد', code: '29', classNumber: 'EC.1'),
  PersonModel(name: "كیرلس سامي", gender: "male", typeUser: 'فرد', code: '31', classNumber: 'EC.1'),
  PersonModel(name: "ماثیو عماد", gender: "male", typeUser: 'فرد', code: '35', classNumber: 'EC.1'),
  PersonModel(name: "مارسلینو تامر", gender: "male", typeUser: 'فرد', code: '36', classNumber: 'EC.1'),
  PersonModel(name: "ماریو ماجد", gender: "male", typeUser: 'فرد', code: '42', classNumber: 'EC.1'),
  PersonModel(name: "مایكل سامح", gender: "male", typeUser: 'فرد', code: '44', classNumber: 'EC.1'),
  PersonModel(name: "مینا ملاك", gender: "male", typeUser: 'فرد', code: '53', classNumber: 'EC.1'),
  PersonModel(name: "مینا ھشام", gender: "male", typeUser: 'فرد', code: '54', classNumber: 'EC.1'),
  PersonModel(name: "یوسف ھشام", gender: "male", typeUser: 'فرد', code: '58', classNumber: 'EC.1'),

  PersonModel(name: "اجنس عماد", gender: "female", typeUser: 'فرد', code: '2', classNumber: 'EC.1'),
  PersonModel(name: "انجي مینا", gender: "female", typeUser: 'فرد', code: '3', classNumber: 'EC.1'),
  PersonModel(name: "ایلاریا رفعت", gender: "female", typeUser: 'فرد', code: '5', classNumber: 'EC.1'),
  PersonModel(name: "بارثینیا مینا", gender: "female", typeUser: 'فرد', code: '7', classNumber: 'EC.1'),
  PersonModel(name: "بتول ثروت", gender: "female", typeUser: 'فرد', code: '10', classNumber: 'EC.1'),
  PersonModel(name: "جولیا جمیل", gender: "female", typeUser: 'فرد', code: '12', classNumber: 'EC.1'),
  PersonModel(name: "جولیا نادر", gender: "female", typeUser: 'فرد', code: '13', classNumber: 'EC.1'),
  PersonModel(name: "جومانا جرجس", gender: "female", typeUser: 'فرد', code: '14', classNumber: 'EC.1'),
  PersonModel(name: "جونیر امجد", gender: "female", typeUser: 'فرد', code: '15', classNumber: 'EC.1'),
  PersonModel(name: "جونیر عزت", gender: "female", typeUser: 'فرد', code: '16', classNumber: 'EC.1'),
  PersonModel(name: "جونیر فادي", gender: "female", typeUser: 'فرد', code: '17', classNumber: 'EC.1'),
  PersonModel(name: "جونیر نادر", gender: "female", typeUser: 'فرد', code: '18', classNumber: 'EC.1'),
  PersonModel(name: "جونیر ولید", gender: "female", typeUser: 'فرد', code: '19', classNumber: 'EC.1'),
  PersonModel(name: "جویس ماجد", gender: "female", typeUser: 'فرد', code: '20', classNumber: 'EC.1'),
  PersonModel(name: "جویس ھاني", gender: "female", typeUser: 'فرد', code: '21', classNumber: 'EC.1'),
  PersonModel(name: "جینا جورج", gender: "female", typeUser: 'فرد', code: '22', classNumber: 'EC.1'),
  PersonModel(name: "ساره وجیه", gender: "female", typeUser: 'فرد', code: '23', classNumber: 'EC.1'),
  PersonModel(name: "فیرونیكا ریجان", gender: "female", typeUser: 'فرد', code: '25', classNumber: 'EC.1'),
  PersonModel(name: "كارن ایمن", gender: "female", typeUser: 'فرد', code: '30', classNumber: 'EC.1'),
  PersonModel(name: "كیرمینا یوسف جمال", gender: "female", typeUser: 'فرد', code: '32', classNumber: 'EC.1'),
  PersonModel(name: "لافي ایھاب", gender: "female", typeUser: 'فرد', code: '33', classNumber: 'EC.1'),
  PersonModel(name: "لوسندا لوقا", gender: "female", typeUser: 'فرد', code: '34', classNumber: 'EC.1'),
  PersonModel(name: "مارلي میلاد", gender: "female", typeUser: 'فرد', code: '37', classNumber: 'EC.1'),
  PersonModel(name: "ماروسكا میخائیل", gender: "female", typeUser: 'فرد', code: '38', classNumber: 'EC.1'),
  PersonModel(name: "ماریا سامح", gender: "female", typeUser: 'فرد', code: '39', classNumber: 'EC.1'),
  PersonModel(name: "ماریا عماد", gender: "female", typeUser: 'فرد', code: '40', classNumber: 'EC.1'),
  PersonModel(name: "ماریا محب", gender: "female", typeUser: 'فرد', code: '41', classNumber: 'EC.1'),
  PersonModel(name: "مایفن وحید", gender: "female", typeUser: 'فرد', code: '43', classNumber: 'EC.1'),
  PersonModel(name: "مریام رامي", gender: "female", typeUser: 'فرد', code: '45', classNumber: 'EC.1'),
  PersonModel(name: "مریم جورج", gender: "female", typeUser: 'فرد', code: '46', classNumber: 'EC.1'),
  PersonModel(name: "مریم سامر", gender: "female", typeUser: 'فرد', code: '47', classNumber: 'EC.1'),
  PersonModel(name: "مریم ولید", gender: "female", typeUser: 'فرد', code: '48', classNumber: 'EC.1'),
  PersonModel(name: "مریم یوحنا", gender: "female", typeUser: 'فرد', code: '49', classNumber: 'EC.1'),
  PersonModel(name: "مھرائیل رافت ذكى", gender: "female", typeUser: 'فرد', code: '50', classNumber: 'EC.1'),
  PersonModel(name: "میرولا رومانى", gender: "female", typeUser: 'فرد', code: '51', classNumber: 'EC.1'),
  PersonModel(name: "میرولا ھانى", gender: "female", typeUser: 'فرد', code: '52', classNumber: 'EC.1'),
  PersonModel(name: "یوانا ایمن", gender: "female", typeUser: 'فرد', code: '55', classNumber: 'EC.1'),
  PersonModel(name: "یوانا عادل", gender: "female", typeUser: 'فرد', code: '56', classNumber: 'EC.1'),
  PersonModel(name: "یوانا عماد", gender: "female", typeUser: 'فرد', code: '57', classNumber: 'EC.1'),

  //EC.2 66 person
  PersonModel(name: "أنطونیوس جورج", gender: "male", typeUser: 'فرد', code: '2', classNumber: 'EC.2'),
  PersonModel(name: "أوناي عماد", gender: "male", typeUser: 'فرد', code: '3', classNumber: 'EC.2'),
  PersonModel(name: "بافلي ھاني", gender: "male", typeUser: 'فرد', code: '7', classNumber: 'EC.2'),
  PersonModel(name: "جورج عبد المسیح", gender: "male", typeUser: 'فرد', code: '9', classNumber: 'EC.2'),
  PersonModel(name: "جون عماد", gender: "male", typeUser: 'فرد', code: '14', classNumber: 'EC.2'),
  PersonModel(name: "جون محب", gender: "male", typeUser: 'فرد', code: '15', classNumber: 'EC.2'),
  PersonModel(name: "جیوفاني رفیق", gender: "male", typeUser: 'فرد', code: '21', classNumber: 'EC.2'),
  PersonModel(name: "فیلوباتیر جورج", gender: "male", typeUser: 'فرد', code: '25', classNumber: 'EC.2'),
  PersonModel(name: "كاراس محب", gender: "male", typeUser: 'فرد', code: '26', classNumber: 'EC.2'),
  PersonModel(name: "كارل إیھاب", gender: "male", typeUser: 'فرد', code: '27', classNumber: 'EC.2'),
  PersonModel(name: "كیرلس بطرس", gender: "male", typeUser: 'فرد', code: '31', classNumber: 'EC.2'),
  PersonModel(name: "كیرلس جوزیف", gender: "male", typeUser: 'فرد', code: '32', classNumber: 'EC.2'),
  PersonModel(name: "كیرلس حسني", gender: "male", typeUser: 'فرد', code: '33', classNumber: 'EC.2'),
  PersonModel(name: "كیرلس ریمون عادل", gender: "male", typeUser: 'فرد', code: '34', classNumber: 'EC.2'),
  PersonModel(name: "كیرلس ریمون ماھر", gender: "male", typeUser: 'فرد', code: '35', classNumber: 'EC.2'),
  PersonModel(name: "كیرلس غالى", gender: "male", typeUser: 'فرد', code: '36', classNumber: 'EC.2'),
  PersonModel(name: "كیرلس نعیم", gender: "male", typeUser: 'فرد', code: '37', classNumber: 'EC.2'),
  PersonModel(name: "مایكل دانیال", gender: "male", typeUser: 'فرد', code: '48', classNumber: 'EC.2'),
  PersonModel(name: "مینا عاطف", gender: "male", typeUser: 'فرد', code: '54', classNumber: 'EC.2'),
  PersonModel(name: "مینا مجدي", gender: "male", typeUser: 'فرد', code: '55', classNumber: 'EC.2'),
  PersonModel(name: "أبانوب میخائیل", gender: "male", typeUser: 'فرد', code: '58', classNumber: 'EC.2'),
  PersonModel(name: "مینا نشأت", gender: "male", typeUser: 'فرد', code: '66', classNumber: 'EC.2'),

  PersonModel(name: "انسطاسیا أشرف", gender: "female", typeUser: 'فرد', code: '1', classNumber: 'EC.2'),
  PersonModel(name: "إیریني سامح", gender: "female", typeUser: 'فرد', code: '4', classNumber: 'EC.2'),
  PersonModel(name: "إیریني مجدي", gender: "female", typeUser: 'فرد', code: '5', classNumber: 'EC.2'),
  PersonModel(name: "ایفیت مایكل", gender: "female", typeUser: 'فرد', code: '6', classNumber: 'EC.2'),
  PersonModel(name: "جاسمین إكرامي", gender: "female", typeUser: 'فرد', code: '8', classNumber: 'EC.2'),
  PersonModel(name: "جوستینا ناصر", gender: "female", typeUser: 'فرد', code: '10', classNumber: 'EC.2'),
  PersonModel(name: "جولیا أشرف", gender: "female", typeUser: 'فرد', code: '11', classNumber: 'EC.2'),
  PersonModel(name: "جومانا جورج", gender: "female", typeUser: 'فرد', code: '12', classNumber: 'EC.2'),
  PersonModel(name: "جومانا ناصر", gender: "female", typeUser: 'فرد', code: '13', classNumber: 'EC.2'),
  PersonModel(name: "جونیر رأفت", gender: "female", typeUser: 'فرد', code: '16', classNumber: 'EC.2'),
  PersonModel(name: "جونیر عصام", gender: "female", typeUser: 'فرد', code: '17', classNumber: 'EC.2'),
  PersonModel(name: "جونیر عماد", gender: "female", typeUser: 'فرد', code: '18', classNumber: 'EC.2'),
  PersonModel(name: "جونیر مدحت كمال", gender: "female", typeUser: 'فرد', code: '19', classNumber: 'EC.2'),
  PersonModel(name: "جویل أیمن", gender: "female", typeUser: 'فرد', code: '20', classNumber: 'EC.2'),
  PersonModel(name: "ساندي مجدي", gender: "female", typeUser: 'فرد', code: '22', classNumber: 'EC.2'),
  PersonModel(name: "سوسنة دانیال", gender: "female", typeUser: 'فرد', code: '23', classNumber: 'EC.2'),
  PersonModel(name: "فیرینا أمیر", gender: "female", typeUser: 'فرد', code: '24', classNumber: 'EC.2'),
  PersonModel(name: "كارن جرجس", gender: "female", typeUser: 'فرد', code: '28', classNumber: 'EC.2'),
  PersonModel(name: "كارول عماد", gender: "female", typeUser: 'فرد', code: '29', classNumber: 'EC.2'),
  PersonModel(name: "كاندي جوزیف", gender: "female", typeUser: 'فرد', code: '30', classNumber: 'EC.2'),
  PersonModel(name: "لورا جاد", gender: "female", typeUser: 'فرد', code: '38', classNumber: 'EC.2'),
  PersonModel(name: "مارفل مجدي", gender: "female", typeUser: 'فرد', code: '39', classNumber: 'EC.2'),
  PersonModel(name: "ماري جرجس", gender: "female", typeUser: 'فرد', code: '40', classNumber: 'EC.2'),
  PersonModel(name: "ماریا سامح", gender: "female", typeUser: 'فرد', code: '41', classNumber: 'EC.2'),
  PersonModel(name: "ماریا عماد", gender: "female", typeUser: 'فرد', code: '42', classNumber: 'EC.2'),
  PersonModel(name: "مارینا رفعت", gender: "female", typeUser: 'فرد', code: '43', classNumber: 'EC.2'),
  PersonModel(name: "مارینا مجدي", gender: "female", typeUser: 'فرد', code: '44', classNumber: 'EC.2'),
  PersonModel(name: "مانریت تامر", gender: "female", typeUser: 'فرد', code: '45', classNumber: 'EC.2'),
  PersonModel(name: "مایفین أمیر", gender: "female", typeUser: 'فرد', code: '46', classNumber: 'EC.2'),
  PersonModel(name: "مایفین عماد", gender: "female", typeUser: 'فرد', code: '47', classNumber: 'EC.2'),
  PersonModel(name: "منیرفا محب", gender: "female", typeUser: 'فرد', code: '49', classNumber: 'EC.2'),
  PersonModel(name: "مورین موریس", gender: "female", typeUser: 'فرد', code: '50', classNumber: 'EC.2'),
  PersonModel(name: "مونیكا وائل", gender: "female", typeUser: 'فرد', code: '51', classNumber: 'EC.2'),
  PersonModel(name: "میریام جان", gender: "female", typeUser: 'فرد', code: '52', classNumber: 'EC.2'),
  PersonModel(name: "میریام لطفي", gender: "female", typeUser: 'فرد', code: '53', classNumber: 'EC.2'),
  PersonModel(name: "نور ثروت", gender: "female", typeUser: 'فرد', code: '56', classNumber: 'EC.2'),
  PersonModel(name: "یوستینا عماد", gender: "female", typeUser: 'فرد', code: '57', classNumber: 'EC.2'),
  PersonModel(name: "بربارة بشاى", gender: "female", typeUser: 'فرد', code: '59', classNumber: 'EC.2'),
  PersonModel(name: "بسنت رفعت", gender: "female", typeUser: 'فرد', code: '60', classNumber: 'EC.2'),
  PersonModel(name: "جولیا جرجس", gender: "female", typeUser: 'فرد', code: '61', classNumber: 'EC.2'),
  PersonModel(name: "مارلي محب", gender: "female", typeUser: 'فرد', code: '62', classNumber: 'EC.2'),
  PersonModel(name: "ماریا رزق", gender: "female", typeUser: 'فرد', code: '63', classNumber: 'EC.2'),
  PersonModel(name: "ماریا عاطف", gender: "female", typeUser: 'فرد', code: '64', classNumber: 'EC.2'),
  PersonModel(name: "میریام رامي", gender: "female", typeUser: 'فرد', code: '65', classNumber: 'EC.2'),

  //EC.3 32 person
  PersonModel(name: "أندرو ماجد", gender: "male", typeUser: 'فرد', code: '1', classNumber: 'EC.3'),
  PersonModel(name: "بیشوى أیمن", gender: "male", typeUser: 'فرد', code: '4', classNumber: 'EC.3'),
  PersonModel(name: "بطرس رومانى", gender: "male", typeUser: 'فرد', code: '5', classNumber: 'EC.3'),
  PersonModel(name: "روبرت رومیل", gender: "male", typeUser: 'فرد', code: '10', classNumber: 'EC.3'),
  PersonModel(name: "مینا أشرف", gender: "male", typeUser: 'فرد', code: '16', classNumber: 'EC.3'),
  PersonModel(name: "مایكل ریمون", gender: "male", typeUser: 'فرد', code: '20', classNumber: 'EC.3'),
  PersonModel(name: "مینا مجدى", gender: "male", typeUser: 'فرد', code: '26', classNumber: 'EC.3'),
  PersonModel(name: "یوسف نادر", gender: "male", typeUser: 'فرد', code: '27', classNumber: 'EC.3'),
  PersonModel(name: "كیرلس جورج نجیب", gender: "male", typeUser: 'فرد', code: '28', classNumber: 'EC.3'),
  PersonModel(name: "بافلي سامي", gender: "male", typeUser: 'فرد', code: '29', classNumber: 'EC.3'),
  PersonModel(name: "جرجس ممدوح", gender: "male", typeUser: 'فرد', code: '31', classNumber: 'EC.3'),
  PersonModel(name: "مینا وجیه", gender: "male", typeUser: 'فرد', code: '32', classNumber: 'EC.3'),

  PersonModel(name: "أغابى یوحنا", gender: "female", typeUser: 'فرد', code: '2', classNumber: 'EC.3'),
  PersonModel(name: "إیلاریا ھانى", gender: "female", typeUser: 'فرد', code: '3', classNumber: 'EC.3'),
  PersonModel(name: "ثیؤدورا أمیر", gender: "female", typeUser: 'فرد', code: '6', classNumber: 'EC.3'),
  PersonModel(name: "جیسیكا ریمون", gender: "female", typeUser: 'فرد', code: '7', classNumber: 'EC.3'),
  PersonModel(name: "جیسیكا مجدى", gender: "female", typeUser: 'فرد', code: '8', classNumber: 'EC.3'),
  PersonModel(name: "دمیانة صموئیل", gender: "female", typeUser: 'فرد', code: '9', classNumber: 'EC.3'),
  PersonModel(name: "ساندى ناصر", gender: "female", typeUser: 'فرد', code: '11', classNumber: 'EC.3'),
  PersonModel(name: "فیرونيا أشرف", gender: "female", typeUser: 'فرد', code: '12', classNumber: 'EC.3'),
  PersonModel(name: "كارن إیھاب", gender: "female", typeUser: 'فرد', code: '13', classNumber: 'EC.3'),
  PersonModel(name: "كالیستا مایكل", gender: "female", typeUser: 'فرد', code: '14', classNumber: 'EC.3'),
  PersonModel(name: "كارن یوحنا", gender: "female", typeUser: 'فرد', code: '15', classNumber: 'EC.3'),
  PersonModel(name: "ماریا إدوار", gender: "female", typeUser: 'فرد', code: '17', classNumber: 'EC.3'),
  PersonModel(name: "مارینا دمیان", gender: "female", typeUser: 'فرد', code: '18', classNumber: 'EC.3'),
  PersonModel(name: "ماریز عماد", gender: "female", typeUser: 'فرد', code: '19', classNumber: 'EC.3'),
  PersonModel(name: "مھرائیل رفعت", gender: "female", typeUser: 'فرد', code: '21', classNumber: 'EC.3'),
  PersonModel(name: "مارینا كمیل", gender: "female", typeUser: 'فرد', code: '22', classNumber: 'EC.3'),
  PersonModel(name: "مریم منصف", gender: "female", typeUser: 'فرد', code: '23', classNumber: 'EC.3'),
  PersonModel(name: "ماریز میشیل", gender: "female", typeUser: 'فرد', code: '24', classNumber: 'EC.3'),
  PersonModel(name: "مارتینا ماھر", gender: "female", typeUser: 'فرد', code: '25', classNumber: 'EC.3'),
  PersonModel(name: "یؤنا سامح", gender: "female", typeUser: 'فرد', code: '30', classNumber: 'EC.3'),

  //EC.4 22 person
  PersonModel(name: "ابانوب ھاني", gender: "male", typeUser: 'فرد', code: '2', classNumber: 'EC.4'),
  PersonModel(name: "بافلي امیر", gender: "male", typeUser: 'فرد', code: '5', classNumber: 'EC.4'),
  PersonModel(name: "بیشوي عادل", gender: "male", typeUser: 'فرد', code: '6', classNumber: 'EC.4'),
  PersonModel(name: "عطا جرجس", gender: "male", typeUser: 'فرد', code: '11', classNumber: 'EC.4'),
  PersonModel(name: "فادي وجدي", gender: "male", typeUser: 'فرد', code: '12', classNumber: 'EC.4'),
  PersonModel(name: "كیرلس جورج تواضروس", gender: "male", typeUser: 'فرد', code: '15', classNumber: 'EC.4'),
  PersonModel(name: "مارتیروس جرجس", gender: "male", typeUser: 'فرد', code: '17', classNumber: 'EC.4'),

  PersonModel(name: "سارة یوسف", gender: "female", typeUser: 'فرد', code: '1', classNumber: 'EC.4'),
  PersonModel(name: "ایریني فایز", gender: "female", typeUser: 'فرد', code: '3', classNumber: 'EC.4'),
  PersonModel(name: "ایلاریا اشرف", gender: "female", typeUser: 'فرد', code: '4', classNumber: 'EC.4'),
  PersonModel(name: "جویس جرجس", gender: "female", typeUser: 'فرد', code: '7', classNumber: 'EC.4'),
  PersonModel(name: "ریتشیل مایكل", gender: "female", typeUser: 'فرد', code: '8', classNumber: 'EC.4'),
  PersonModel(name: "ساندرا بیتر", gender: "female", typeUser: 'فرد', code: '9', classNumber: 'EC.4'),
  PersonModel(name: "ساندي ممدوح", gender: "female", typeUser: 'فرد', code: '10', classNumber: 'EC.4'),
  PersonModel(name: "فیرینا جرجس", gender: "female", typeUser: 'فرد', code: '13', classNumber: 'EC.4'),
  PersonModel(name: "كارن محب", gender: "female", typeUser: 'فرد', code: '14', classNumber: 'EC.4'),
  PersonModel(name: "مادونا رفعت", gender: "female", typeUser: 'فرد', code: '16', classNumber: 'EC.4'),
  PersonModel(name: "ماریا حسني", gender: "female", typeUser: 'فرد', code: '18', classNumber: 'EC.4'),
  PersonModel(name: "ماریا وصفي", gender: "female", typeUser: 'فرد', code: '19', classNumber: 'EC.4'),
  PersonModel(name: "میرنا ایمن", gender: "female", typeUser: 'فرد', code: '20', classNumber: 'EC.4'),
  PersonModel(name: "مینا شكري", gender: "female", typeUser: 'فرد', code: '21', classNumber: 'EC.4'),
  PersonModel(name: "یوستینا علاء", gender: "female", typeUser: 'فرد', code: '22', classNumber: 'EC.4'),

];

