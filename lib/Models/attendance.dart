final String tableAttendance = 'attendance';

class AttendanceFields {
  static final List<String> values = [
    id,name,gender,typeUser,date,time,answer,grade,total,classNumber,code
  ];
  static final String id = '_id';
  static final String name = 'name';
  static final String gender = 'gender';
  static final String typeUser = 'typeUser';
  static final String date = 'date';
  static final String time = 'time';
  static final String answer = 'answer';
  static final String grade = 'grade';
  static final String total = 'total';
  static final String classNumber = 'class_number';
  static final String code = 'code';
}

class AttendanceModel {
  final int? id;
  final String? answer;
  final String? grade;
  final String? total;
  final String classNumber;
  final String code;
  final String name;
  final String gender;
  final String typeUser;
  final String date;
  final String time;



  AttendanceModel({
    this.id,
    this.answer,
    this.grade,
    this.total,
    required this.classNumber,
    required this.code,
    required this.name,
    required this.gender,
    required this.typeUser,
    required this.date,
    required this.time,

  });

  AttendanceModel copy({
    int? id,
    String? name,
    String? gender,
    String? typeUser,
    String? date,
    String? time,
    String? answer,
    String? grade,
    String? total,
    String? classNumber,
    String? code,
  }) =>
      AttendanceModel(
        id: id ?? this.id,
        name: name ?? this.name,
        gender: gender ?? this.gender,
        typeUser: typeUser ?? this.typeUser,
        date: date ?? this.date,
        time: time ?? this.time,
        answer: answer ?? this.answer,
        grade: grade ?? this.grade,
        total: total ?? this.total,
        classNumber: classNumber ?? this.classNumber,
        code: code ?? this.code,
      );

  static AttendanceModel fromJson(Map<String,Object?> json)=>AttendanceModel(
    id: json[AttendanceFields.id] as int,
    name: json[AttendanceFields.name] as String,
    gender: json[AttendanceFields.gender] as String,
    typeUser: json[AttendanceFields.typeUser] as String,
    date: json[AttendanceFields.date] as String,
    time: json[AttendanceFields.time] as String,
    answer: json[AttendanceFields.answer].toString(),
    grade: json[AttendanceFields.grade].toString(),
    total: json[AttendanceFields.total].toString(),
    classNumber: json[AttendanceFields.classNumber] as String,
    code: json[AttendanceFields.code] as String,
  );
  static String fromJsonToString(Map<String,Object?> json)=>json[AttendanceFields.date] as String;
  Map<String,Object?> getMap(){
    return {
      AttendanceFields.id:id,
      AttendanceFields.name:name,
      AttendanceFields.gender:gender,
      AttendanceFields.typeUser:typeUser,
      AttendanceFields.date:date,
      AttendanceFields.time:time,
      AttendanceFields.answer:answer,
      AttendanceFields.grade:grade,
      AttendanceFields.total:total,
      AttendanceFields.classNumber:classNumber,
      AttendanceFields.code:code,
    };
  }



}