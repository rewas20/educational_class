import 'package:educational_class/Screens/add_name_screen.dart';
import 'package:educational_class/Screens/attendance_screen.dart';
import 'package:educational_class/Screens/bonus_screen.dart';
import 'package:educational_class/Screens/boys_screen.dart';
import 'package:educational_class/Screens/class_screen.dart';
import 'package:educational_class/Screens/girls_screen.dart';
import 'package:educational_class/Screens/home_screen.dart';
import 'package:educational_class/Screens/login_screen.dart';
import 'package:educational_class/Screens/names_screen.dart';
import 'package:educational_class/Screens/questions_screen.dart';
import 'package:educational_class/Screens/scan_screen.dart';
import 'package:educational_class/Screens/scanner_camera_screen.dart';
import 'package:educational_class/Screens/splash_screen.dart';
import 'package:educational_class/Screens/videw_attend_date_screen.dart';
import 'package:educational_class/Screens/view_attendance_screen.dart';
import 'package:educational_class/Screens/view_data_name_screen.dart';
import 'package:educational_class/Services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'الفصل التعليمي',
      theme: ThemeData(
        primaryColor: const Color(0xff3490dc),
      ),
      home: StreamBuilder(
        stream: AuthService().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }
          
          if (snapshot.hasData) {
            return const HomeScreen();
          }
          
          return const LoginScreen();
        },
      ),
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        ScanScreen.routeName: (context) => const ScanScreen(),
        ScannerCameraScreen.routeName: (context) => const ScannerCameraScreen(),
        NamesScreen.routeName: (context) => const NamesScreen(),
        BoysScreen.routeName: (context) => const BoysScreen(),
        GirlsScreen.routeName: (context) => const GirlsScreen(),
        AddNameScreen.routeName: (context) => const AddNameScreen(),
        AttendanceScreen.routeName: (context) => const AttendanceScreen(),
        ViewAttendDateScreen.routeName: (context) => const ViewAttendDateScreen(),
        ViewAttendanceScreen.routeName: (context) => const ViewAttendanceScreen(),
        QuestionsScreen.routeName: (context) => const QuestionsScreen(),
        BonusScreen.routeName: (context) => const BonusScreen(),
        ViewDataNameScreen.routeName: (context) => const ViewDataNameScreen(),
        ClassScreen.routeName: (context) => const ClassScreen(),
      },
    );
  }
}