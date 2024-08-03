
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../Data/data.dart';
import '../Models/attendance.dart';
import '../Models/person.dart';
import '../Models/question.dart';
import '../Models/class.dart';



class DatabaseProvider{

  static final DatabaseProvider instance = DatabaseProvider._init();

  Future<bool> _getStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      return true;
    } else{
      var request = await Permission.storage.request();
      if(request == PermissionStatus.granted)
        return true;
      else
        return false;
    }
  }

  static Database? _database;
  DatabaseProvider._init();

  Future<Database> get database async {
    if(_database != null) return _database!;

    _database = await _initDB('educational_class.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async{

    if(await _getStoragePermission()) {
      final dbPath = await getExternalStorageDirectory();
      final path = join(dbPath!.path, filePath);
      return openDatabase(path, version: 1, onCreate: _createDB);
    }else {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, filePath);
      return openDatabase(path, version: 1, onCreate: _createDB);
    }


  }
  //Create DB for first run
  Future _createDB(Database db, int version) async{
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const answerType = 'TEXT NULL';

    await db.execute(''' 
      CREATE TABLE $tableClass (
        ${ClassFields.id} $idType,
        ${ClassFields.name} $textType,
        ${ClassFields.classNumber} $textType )
    ''');
    await db.execute('''
      CREATE TABLE $tablePerson (
        ${PersonFields.id} $idType,
        ${PersonFields.name} $textType,
        ${PersonFields.gender} $textType,
        ${PersonFields.typeUser} $textType,
        ${PersonFields.code} $textType,
        ${PersonFields.classNumber} $textType)
    ''');
    await db.execute('''
      CREATE TABLE $tableAttendance (
        ${AttendanceFields.id} $idType,
        ${AttendanceFields.name} $textType,
        ${AttendanceFields.gender} $textType,
        ${AttendanceFields.typeUser} $textType,
        ${AttendanceFields.date} $textType,
        ${AttendanceFields.time} $textType,
        ${AttendanceFields.answer} $answerType,
        ${AttendanceFields.grade} $answerType,
        ${AttendanceFields.total} $answerType,
        ${AttendanceFields.code} $textType,
        ${AttendanceFields.classNumber} $textType)
    ''');
    await db.execute('''
          CREATE TABLE $tableQuestion (
            ${QuestionFields.id} $idType,
            ${QuestionFields.question} $textType,
            ${QuestionFields.grade} $textType ) 
        ''');

    DATA_PERSONS.forEach((element) async {
      await db.insert(tablePerson,element.getMap());
    });
    CLASSS_DATA.forEach((element) async {
      await db.insert(tableClass,element.getMap());
    });
    QUESTION_DATA.forEach((element) async {
      await db.insert(tableQuestion,element.getMap());
    });
  }
  //=========================== Queries On DataBase ==========================
  //==================== table attendance ===========================
  //Create Attend for user
  Future<AttendanceModel> createAttend(AttendanceModel attendanceModel)async{
    final db = await instance.database;

    // final json = attendanceModel.getMap();
    // final columns = '${AttendanceFields.name}, ${AttendanceFields.gender} ,${AttendanceFields.typeUser} ,${AttendanceFields.date} ,${AttendanceFields.time}';
    // final values = '${attendanceModel.name}, ${attendanceModel.gender} ,${attendanceModel.typeUser} ,${attendanceModel.date} ,${attendanceModel.time}';
    //
    // final id = await db.rawInsert('INSERT INTO table_name($columns) VALUES ($values)');

    final id = await db.insert(tableAttendance, attendanceModel.getMap());
    return attendanceModel.copy(id: id);
  }
  //===========
  //Read one Attend for user by id
  Future<AttendanceModel> readAttendById(int id)async{
    final db = await instance.database;
    final maps = await db.query(
      tableAttendance,
      columns: AttendanceFields.values,
      where: '${AttendanceFields.id} = ?',
      whereArgs: [id],
    );
    if(maps.isNotEmpty){
      return AttendanceModel.fromJson(maps.first);
    }else{
      Fluttertoast.showToast(msg: "ID $id not found");
      throw Exception('ID $id not found');
    }
  }
  //===========
  //Read one Attend for user time attend
  Future<List<AttendanceModel>> readAllAttendTime(String date)async{
    final db = await instance.database;
    final orderBy = '${AttendanceFields.time} ASC';
    final maps = await db.query(
      tableAttendance,
      columns: AttendanceFields.values,
      where: '${AttendanceFields.date} = ?',
      whereArgs: [date],
      orderBy: orderBy,
    );
    if(maps.isNotEmpty){

      return maps.map((json) => AttendanceModel.fromJson(json)).toList();
    }else{
      Fluttertoast.showToast(msg: "Date $date not found");
      throw Exception('Date $date not found');
    }
  }
  //===========
  //Read one Attend for user time attend
  Future<List<AttendanceModel>> readAllAttendTimeByClass(String date,String classNumber)async{
    final db = await instance.database;
    final orderBy = '${AttendanceFields.time} ASC';
    final maps = await db.query(
      tableAttendance,
      columns: AttendanceFields.values,
      where: '${AttendanceFields.date} = ? AND ${AttendanceFields.classNumber} = ?',
      whereArgs: [date,classNumber],
      orderBy: orderBy,
    );
    if(maps.isNotEmpty){

      return maps.map((json) => AttendanceModel.fromJson(json)).toList();
    }else{
      Fluttertoast.showToast(msg: "Date $date not found");
      throw Exception('Date $date not found');
    }
  }
  //===========
  // Read one Attend for user team attend
  Future<List<AttendanceModel>> readAllAttendTeamOrderTime(String classNumber)async{
    final db = await instance.database;
    final orderBy = '${AttendanceFields.time} ASC';
    final maps = await db.query(
      tableAttendance,
      columns: AttendanceFields.values,
      where: '${AttendanceFields.classNumber} = ?',
      whereArgs: [classNumber],
      orderBy: orderBy,
    );
    if(maps.isNotEmpty){

      return maps.map((json) => AttendanceModel.fromJson(json)).toList();
    }else{
      Fluttertoast.showToast(msg: "الفصل $classNumber ليس موجد");
      throw Exception('team $classNumber not found');
    }
  }
  //===========
  // Read one Attend for user team attend
  Future<List<AttendanceModel>> readAllAttendTeamOrderClassNumber(String classNumber)async{
    final db = await instance.database;
    final orderBy = '${AttendanceFields.classNumber} ASC';
    final maps = await db.query(
      tableAttendance,
      columns: AttendanceFields.values,
      where: '${AttendanceFields.classNumber} = ?',
      whereArgs: [classNumber],
      orderBy: orderBy,
    );
    if(maps.isNotEmpty){

      return maps.map((json) => AttendanceModel.fromJson(json)).toList();
    }else{
      Fluttertoast.showToast(msg: "الفصل $classNumber ليس موجد");
      throw Exception('team $classNumber not found');
    }
  }
  //===========
  Future<List<AttendanceModel>> readAllAttendType(String typeUser)async{
    final db = await instance.database;
    final orderBy = '${AttendanceFields.time} ASC';
    final maps = await db.query(
      tableAttendance,
      columns: AttendanceFields.values,
      where: '${AttendanceFields.typeUser} = ?',
      whereArgs: [typeUser],
      orderBy: orderBy,
    );
    if(maps.isNotEmpty){

      return maps.map((json) => AttendanceModel.fromJson(json)).toList();
    }else{
      throw Exception('typeUser $typeUser not found');
    }
  }//===========
  Future<List<AttendanceModel>> readAllAttendClassNumber(String classNumber)async{
    final db = await instance.database;
    final orderBy = '${AttendanceFields.time} ASC';
    final maps = await db.query(
      tableAttendance,
      columns: AttendanceFields.values,
      where: '${AttendanceFields.classNumber} = ?',
      whereArgs: [classNumber],
      orderBy: orderBy,
    );
    if(maps.isNotEmpty){

      return maps.map((json) => AttendanceModel.fromJson(json)).toList();
    }else{
      throw Exception('typeUser $classNumber not found');
    }
  }
  //===========
  //Read one Attend for user Name attend
  Future<AttendanceModel> readAllAttendByName(String name)async{
    final db = await instance.database;
    final maps = await db.query(
      tableAttendance,
      columns: AttendanceFields.values,
      where: '${AttendanceFields.name} = ?',
      whereArgs: [name],
    );
    if(maps.isNotEmpty){
      return AttendanceModel.fromJson(maps.first);
    }else{
      Fluttertoast.showToast(msg: "name $name not found");
      throw Exception('ID $name not found');
    }
  } //===========
  //Read one Attend for user code attend
  Future<AttendanceModel> readAllAttendByCodeAndClassNumber(String name,String date,String code,String classNumber)async{
    final db = await instance.database;
    final maps = await db.query(
      tableAttendance,
      columns: AttendanceFields.values,
      where: '${AttendanceFields.name} = ? AND ${AttendanceFields.date} = ? AND ${AttendanceFields.code} = ? AND ${AttendanceFields.classNumber} = ?',
      whereArgs: [name,date,code,classNumber],
    );
    if(maps.isNotEmpty){
      return AttendanceModel.fromJson(maps.first);
    }else{
      Fluttertoast.showToast(msg: "هذا $code ليس موجود");
      throw Exception('ID $code not found');
    }
  }
  Future<List<AttendanceModel>> readAllAttendsByName(String name)async{
    final db = await instance.database;
    final maps = await db.query(
      tableAttendance,
      columns: AttendanceFields.values,
      where: '${AttendanceFields.name} = ?',
      whereArgs: [name],
    );
    if(maps.isNotEmpty){
      return maps.map((json) => AttendanceModel.fromJson(json)).toList();
    }else{
      Fluttertoast.showToast(msg: "name $name not found");
      throw Exception('ID $name not found');
    }
  } Future<List<AttendanceModel>> readAllAttendsByCodeAndClassNumber(String name,String code,String classNumber)async{
    final db = await instance.database;
    final maps = await db.query(
      tableAttendance,
      columns: AttendanceFields.values,
      where: '${AttendanceFields.name} = ? AND ${AttendanceFields.code} = ? AND ${AttendanceFields.classNumber} = ?',
      whereArgs: [name,code,classNumber],
    );
    if(maps.isNotEmpty){
      return maps.map((json) => AttendanceModel.fromJson(json)).toList();
    }else{
      Fluttertoast.showToast(msg: "code $code not found");
      throw Exception('ID $code not found');
    }
  }
  //===========
  //Read one Attend for user by time attend
  Future<List<String>> readAllAttendByDate()async{
    final db = await instance.database;
    final orderBy = '${AttendanceFields.date} Desc';
    final groupBy = AttendanceFields.date;
    final maps = await db.query(tableAttendance,
        groupBy: groupBy,
        orderBy: orderBy);
    if(maps.isNotEmpty){
      return maps.map((json) => AttendanceModel.fromJsonToString(json)).toList();
    }else{
      Fluttertoast.showToast(msg: "Date not found");
      throw Exception('Date not found');
    }
  }
  //===========
  //Read one Attend for user by time attend
  Future<List<String>> readAllAttendByDateByClass(String classNumber)async{
    final db = await instance.database;
    final orderBy = '${AttendanceFields.date} Desc';
    final groupBy = AttendanceFields.date;
    final maps = await db.query(tableAttendance,
        where: '${AttendanceFields.classNumber} = ?',
        whereArgs: [classNumber],
        groupBy: groupBy,
        orderBy: orderBy);
    if(maps.isNotEmpty){
      return maps.map((json) => AttendanceModel.fromJsonToString(json)).toList();
    }else{
      Fluttertoast.showToast(msg: "Date not found");
      throw Exception('Date not found');
    }
  }
  //===========
  //Read all Attend for users
  Future<List<AttendanceModel>> readAllAttend()async{
    final db = await instance.database;
    final orderBy = '${AttendanceFields.time} ASC';
    final maps = await db.query(
      tableAttendance,
      orderBy: orderBy,
    );
    if(maps.isNotEmpty){
      return maps.map((json) => AttendanceModel.fromJson(json)).toList();
    }else{
      Fluttertoast.showToast(msg: "No Data");
      throw Exception('NO DATA');
    }
  }
  //===========
  //Edit on user attend By model
  Future<int> updateAttend(AttendanceModel attendanceModel)async{
    final db = await instance.database;
    return db.update(tableAttendance,
      attendanceModel.getMap(),
      where: '${AttendanceFields.id} = ?',
      whereArgs: [attendanceModel.id],
    );
  }
  //===========
  //Delete on table attend By Id
  Future<int> deleteAttend(int id)async{
    final db = await instance.database;
    return db.delete(tableAttendance,
      where: '${AttendanceFields.id} = ?',
      whereArgs: [id],
    );
  }//===========
  //Delete on table attend By code
  Future<int> deleteAttendByCodeAndClassNumber(String name,String code,String classNumber)async{
    final db = await instance.database;
    return db.delete(tableAttendance,
      where: '${AttendanceFields.name} = ? AND ${AttendanceFields.code} = ? AND ${AttendanceFields.classNumber} = ?',
      whereArgs: [name,code,classNumber],
    );
  }
  //===========
  //Delete on table attend By Date
  Future deleteAttendByDate(String date)async{
    final db = await instance.database;
    return db.delete(tableAttendance,
      where: '${AttendanceFields.date} = ?',
      whereArgs: [date],
    );
  }
  //===========
  //Delete on table attend By Date
  Future deleteAttendByDateWithClassNumber(String date,String classNumber)async{
    final db = await instance.database;
    return db.delete(tableAttendance,
      where: '${AttendanceFields.date} = ? And ${AttendanceFields.classNumber} = ?',
      whereArgs: [date,classNumber],
    );
  }
  //===========
  //Check attend By Id
  Future<bool> checkAttendCodeAndClass(String code,String classNumber)async{
    final db = await instance.database;
    final maps = await db.query(
      tableAttendance,
      columns: AttendanceFields.values,
      where: '${AttendanceFields.code} = ? AND ${AttendanceFields.classNumber} = ?',
      whereArgs: [code,classNumber],
    );
    if(maps.isNotEmpty){
      return true;
    }else{
      return false;
    }
  } //===========
  //Check attend By Id
  Future<bool> checkAttend(String name,String date,String code,String classNumber)async{
    final db = await instance.database;
    final maps = await db.query(
      tableAttendance,
      columns: AttendanceFields.values,
      where: '${AttendanceFields.name} = ? AND ${AttendanceFields.date} = ? AND ${AttendanceFields.code} = ? AND ${AttendanceFields.classNumber} = ?',
      whereArgs: [name,date,code,classNumber],
    );
    if(maps.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }
  Future<bool> checkAttendId(int id)async{
    final db = await instance.database;
    final maps = await db.query(
      tableAttendance,
      columns: AttendanceFields.values,
      where: '${AttendanceFields.id} = ?',
      whereArgs: [id],
    );
    if(maps.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }
  Future<bool> checkAttendName(String name)async{
    final db = await instance.database;
    final maps = await db.query(
      tableAttendance,
      columns: AttendanceFields.values,
      where: '${AttendanceFields.name} = ?',
      whereArgs: [name],
    );
    if(maps.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }


  Future<bool> checkAllAttend()async{
    final db = await instance.database;
    final orderBy = '${AttendanceFields.time} ASC';
    final maps = await db.query(
      tableAttendance,
      orderBy: orderBy,
    );
    if(maps.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }
  //==================== end table attendance ===========================

  //==================== table person ===============================
  //Create Person for user
  Future<PersonModel> createPerson(PersonModel personModel)async{
    final db = await instance.database;

    final id = await db.insert(tablePerson, personModel.getMap());
    return personModel.copy(id: id);
  }
  //===========
  //Read one Person for user by id
  Future<PersonModel> readPersonById(int id)async{
    final db = await instance.database;
    final maps = await db.query(
      tablePerson,
      columns: PersonFields.values,
      where: '${PersonFields.id} = ?',
      whereArgs: [id],
    );
    if(maps.isNotEmpty){
      return PersonModel.fromJson(maps.first);
    }else{
      Fluttertoast.showToast(msg: "ID $id not found");
      throw Exception('ID $id not found');
    }
  }

  //===========
  //Read one Person for user by Name
  Future<PersonModel> readPersonByName(String name)async{
    final db = await instance.database;
    final orderBy = '${PersonFields.gender} ASC';
    final maps = await db.query(
      tablePerson,
      columns: PersonFields.values,
      where: '${PersonFields.name} = ?',
      whereArgs: [name],
      orderBy: orderBy,
    );
    if(maps.isNotEmpty){
      return PersonModel.fromJson(maps.first);
    }else{
      Fluttertoast.showToast(msg: "name $name not found");
      throw Exception('name $name not found');
    }
  }
  //===========
  //Read one Person for user by Name
  Future<PersonModel> readPersonByCodeAndClass(String name,String code,String classNumber)async{
    final db = await instance.database;
    final maps = await db.query(
      tablePerson,
      columns: PersonFields.values,
      where: '${PersonFields.name} = ? AND ${PersonFields.code} = ? AND ${PersonFields.classNumber} = ?',
      whereArgs: [name,code,classNumber],
    );
    if(maps.isNotEmpty){
      return PersonModel.fromJson(maps.first);
    }else{
      Fluttertoast.showToast(msg: "name $name not found");
      throw Exception('name $name not found');
    }
  }
  //===========
  //Read one Person for user by Name order team number
  Future<PersonModel> readPersonByNameOrderClassNumber(String name)async{
    final db = await instance.database;
    final orderBy = '${PersonFields.classNumber} ASC';
    final maps = await db.query(
      tablePerson,
      columns: PersonFields.values,
      where: '${PersonFields.name} = ?',
      whereArgs: [name],
      orderBy: orderBy,
    );
    if(maps.isNotEmpty){
      return PersonModel.fromJson(maps.first);
    }else{
      Fluttertoast.showToast(msg: "name $name not found");
      throw Exception('name $name not found');
    }
  }
  //===========
  //Read all Person for user by gender
  Future<List<PersonModel>> readPersonByGender(String gender)async{
    final db = await instance.database;
    final orderBy = '${PersonFields.gender} ASC';
    final maps = await db.query(
      tablePerson,
      columns: PersonFields.values,
      where: '${PersonFields.gender} = ?',
      whereArgs: [gender],
      orderBy: orderBy,
    );
    if(maps.isNotEmpty){
      return maps.map((json) => PersonModel.fromJson(json)).toList();
    }else{
      Fluttertoast.showToast(msg: "gender $gender not found");
      throw Exception('gender $gender not found');
    }
  }
  //===========
  // Read all Person for user by team
  Future<List<PersonModel>> readAllPersonByClassNumber(String classNumber)async{
    final db = await instance.database;
    final orderBy = '${PersonFields.code} ASC';
    final maps = await db.query(
      tablePerson,
      columns: PersonFields.values,
      where: '${PersonFields.classNumber} = ?',
      whereArgs: [classNumber],
      orderBy: orderBy,
    );
    if(maps.isNotEmpty){
      return maps.map((json) => PersonModel.fromJson(json)).toList();
    }else{
      Fluttertoast.showToast(msg: "class $classNumber not found");
      throw Exception('class $classNumber not found');
    }
  }
  //===========
  // Read all Person for user by name of team
 /* Future<List<PersonModel>> readAllPersonByNameTeam(String nameTeam)async{
    final db = await instance.database;
    final orderBy = '${PersonFields.team} ASC';
    final maps = await db.query(
      tablePerson,
      columns: PersonFields.values,
      where: '${PersonFields.nameTeam} = ?',
      whereArgs: [nameTeam],
      orderBy: orderBy,
    );
    if(maps.isNotEmpty){
      return maps.map((json) => PersonModel.fromJson(json)).toList();
    }else{
      Fluttertoast.showToast(msg: "nameTeam $nameTeam not found");
      throw Exception('nameTeam $nameTeam not found');
    }
  }*/
  //===========
  //Read all Persons for users
  Future<List<PersonModel>> readAllPersons()async{
    final db = await instance.database;
    final maps = await db.query(
        tablePerson
    );
    if(maps.isNotEmpty){
      return maps.map((json) => PersonModel.fromJson(json)).toList();
    }else{
      Fluttertoast.showToast(msg: "No Data");
      throw Exception('NO DATA');
    }
  }
  //===========
  //Edit on user Person By model
  Future<int> updatePerson(PersonModel personModel)async{
    final db = await instance.database;
    return db.update(tablePerson,
      personModel.getMap(),
      where: '${PersonFields.id} = ?',
      whereArgs: [personModel.id],
    );
  }
  //===========
  //Delete on table person By Id
  Future<int> deletePerson(int id)async{
    final db = await instance.database;
    return db.delete(tablePerson,
      where: '${PersonFields.id} = ?',
      whereArgs: [id],
    );
  }
  //===========
  //Delete on table person By Id
  Future<int> deletePersonCode(String name,String classNumber,String code)async{
    final db = await instance.database;
    return db.delete(tablePerson,
      where: '${PersonFields.name} = ? AND ${PersonFields.code} = ? AND ${PersonFields.classNumber} = ?',
      whereArgs: [name,code,classNumber],
    );
  }
  //===========
  //Check exit By Id
  Future<bool> checkPerson(String name)async{
    final db = await instance.database;
    final maps = await db.query(
      tablePerson,
      columns: PersonFields.values,
      where: '${PersonFields.name} = ?',
      whereArgs: [name],
    );
    if(maps.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }
  //===========
  //Check exit By Id
  Future<bool> checkPersonWithCodeAndClass(String name,String code, String classNumber)async{
    final db = await instance.database;
    final maps = await db.query(
      tablePerson,
      columns: PersonFields.values,
      where: '${PersonFields.name} = ? AND ${PersonFields.classNumber} = ? AND ${PersonFields.code} = ?',
      whereArgs: [name,classNumber,code],
    );
    if(maps.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }
  Future<bool> checkPersonId(int id)async{
    final db = await instance.database;
    final maps = await db.query(
      tablePerson,
      columns: PersonFields.values,
      where: '${PersonFields.id} = ?',
      whereArgs: [id],
    );
    if(maps.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }
  Future<bool> checkPersonCode(String name,String classNumber,String code)async{
    final db = await instance.database;
    final maps = await db.query(
      tablePerson,
      columns: PersonFields.values,
      where: '${PersonFields.name} = ? AND ${PersonFields.code} = ? AND ${PersonFields.classNumber} = ?',
      whereArgs: [name,code,classNumber],
    );
    if(maps.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }

  Future<bool> checkAllPerson()async{
    final db = await instance.database;
    final maps = await db.query(
        tablePerson
    );
    if(maps.isNotEmpty){
      return true;
    }else{
     return false;
    }
  }
  //==================== end table person ===========================

  //==================== table class ===============================
  //Create Leader for user
  Future<ClassModel> createClass(ClassModel classModel)async{
    final db = await instance.database;

    final id = await db.insert(tableClass, classModel.getMap());
    return classModel.copy(id: id);
  }
  //===========
  //Read one Leader for user by id
  Future<ClassModel> readClessesById(int id)async{
    final db = await instance.database;
    final maps = await db.query(
      tableClass,
      columns: ClassFields.values,
      where: '${ClassFields.id} = ?',
      whereArgs: [id],
    );
    if(maps.isNotEmpty){
      return ClassModel.fromJson(maps.first);
    }else{
      Fluttertoast.showToast(msg: "ID $id not found");
      throw Exception('ID $id not found');
    }
  }
  //===========
  //Read one Leader for user by Name
  Future<ClassModel> readClassesByName(String name)async{
    final db = await instance.database;
    final orderBy = '${ClassFields.classNumber} ASC';
    final maps = await db.query(
      tableClass,
      columns: ClassFields.values,
      where: '${ClassFields.name} = ?',
      whereArgs: [name],
      orderBy: orderBy,
    );
    if(maps.isNotEmpty){
      return ClassModel.fromJson(maps.first);
    }else{
      Fluttertoast.showToast(msg: "name $name not found");
      throw Exception('name $name not found');
    }
  }
  //===========
  //Read one Leader for user by Name
  Future<ClassModel> readClassesByClassNumber(String classNumber)async{
    final db = await instance.database;
    final orderBy = '${ClassFields.id} ASC';
    final maps = await db.query(
      tableClass,
      columns: ClassFields.values,
      where: '${ClassFields.classNumber} = ?',
      whereArgs: [classNumber],
      orderBy: orderBy,
    );
    if(maps.isNotEmpty){
      return ClassModel.fromJson(maps.first);
    }else{
      Fluttertoast.showToast(msg: "number $classNumber not found");
      throw Exception('number $classNumber not found');
    }
  }
  //===========
  //Read all Leader for users
  Future<List<ClassModel>> readAllClasses()async{
    final db = await instance.database;
    final orderBy = '${ClassFields.classNumber} ASC';
    final maps = await db.query(
        tableClass,
          orderBy: orderBy,
    );
    if(maps.isNotEmpty){
      return maps.map((json) => ClassModel.fromJson(json)).toList();
    }else{
      Fluttertoast.showToast(msg: "No Data");
      throw Exception('NO DATA');
    }
  }
  //===========
  //Read all Leader for users
  Future<List<String>> readAllClassesString()async{
    final db = await instance.database;
    final orderBy = '${ClassFields.classNumber} ASC';
    final maps = await db.query(
        tableClass,
          orderBy: orderBy,
    );
    if(maps.isNotEmpty){
      return maps.map((json) => ClassModel.fromJsonToString(json)).toList();
    }else{
      Fluttertoast.showToast(msg: "No Data");
      throw Exception('NO DATA');
    }
  }
  //===========
  //Edit on user Leader By model
  Future<int> updateClass(ClassModel classModel)async{
    final db = await instance.database;
    return db.update(tableClass,
      classModel.getMap(),
      where: '${ClassFields.id} = ?',
      whereArgs: [classModel.id],
    );
  }
  //===========
  //Delete on table leader By Id
  Future<int> deleteClass(int id)async{
    final db = await instance.database;
    return db.delete(tableClass,
      where: '${ClassFields.id} = ?',
      whereArgs: [id],
    );
  }
  //===========
  //Check exit By Id
  Future<bool> checkClass(String classNumber)async{
    final db = await instance.database;
    final maps = await db.query(
      tableClass,
      columns: ClassFields.values,
      where: '${ClassFields.classNumber} = ?',
      whereArgs: [classNumber],
    );
    if(maps.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }
  //==================== end table leader ===========================

  //==================== table question ===============================
  //Create question
  Future<QuestionModel> createQuestion(QuestionModel questionModel)async{
    final db = await instance.database;

    final id = await db.insert(tableQuestion, questionModel.getMap());
    return questionModel.copy(id: id);
  }
  //===========
  //Read one question by id
  Future<QuestionModel> readQuestionById(int id)async{
    final db = await instance.database;
    final maps = await db.query(
      tableQuestion,
      columns: QuestionFields.values,
      where: '${QuestionFields.id} = ?',
      whereArgs: [id],
    );
    if(maps.isNotEmpty){
      return QuestionModel.fromJson(maps.first);
    }else{
      Fluttertoast.showToast(msg: "ID $id not found");
      throw Exception('ID $id not found');
    }
  }
  //===========
  //Read one question by question
  Future<QuestionModel> readQuestionByName(String question)async{
    final db = await instance.database;
    final orderBy = '${QuestionFields.id} ASC';
    final maps = await db.query(
      tableQuestion,
      columns: QuestionFields.values,
      where: '${QuestionFields.question} = ?',
      whereArgs: [question],
      orderBy: orderBy,
    );
    if(maps.isNotEmpty){
      return QuestionModel.fromJson(maps.first);
    }else{
      Fluttertoast.showToast(msg: "name $question not found");
      throw Exception('name $question not found');
    }
  }
  //===========
  //Read all questions
  Future<List<QuestionModel>> readAllQuestion()async{
    final db = await instance.database;
    final maps = await db.query(
        tableQuestion
    );
    if(maps.isNotEmpty){
      return maps.map((json) => QuestionModel.fromJson(json)).toList();
    }else{
      Fluttertoast.showToast(msg: "No Data");
      throw Exception('NO DATA');
    }
  }
  //===========
  //Edit on question By model
  Future<int> updateQuestion(QuestionModel questionModel)async{
    final db = await instance.database;
    return db.update(tableQuestion,
      questionModel.getMap(),
      where: '${QuestionFields.id} = ?',
      whereArgs: [questionModel.id],
    );
  }
  //===========
  //Delete on table question By Id
  Future<int> deleteQuestion(int id)async{
    final db = await instance.database;
    return db.delete(tableQuestion,
      where: '${QuestionFields.id} = ?',
      whereArgs: [id],
    );
  }
  //===========
  //Check exit By name
  Future<bool> checkQuestion(String question)async{
    final db = await instance.database;
    final maps = await db.query(
      tableQuestion,
      columns: QuestionFields.values,
      where: '${QuestionFields.question} = ?',
      whereArgs: [question],
    );
    if(maps.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }
  //==================== end table question ===========================

  //============================ End Queries On DataBase ==========================

  //=========== Close File db ==============
  Future close() async{
    final db = await instance.database;
    db.close();
  }
}