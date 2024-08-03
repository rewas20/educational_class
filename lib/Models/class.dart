final String tableClass = 'class';

class ClassFields {
  static final List<String> values = [
    id,name,classNumber
  ];
  static final String id = '_id';
  static final String name = 'name';
  static final String classNumber = 'class_number';
}

class ClassModel {
  final int? id;
  final String name;
  final String classNumber;

  ClassModel({
    this.id,
    required this.name,
    required this.classNumber,
  });

  ClassModel copy({
    int? id,
    String? name,
    String? classNumber,
  }) =>
      ClassModel(
        id: id ?? this.id,
        name: name ?? this.name,
        classNumber: classNumber ?? this.classNumber,
      );
  static ClassModel fromJson(Map<String,Object?> json)=>ClassModel(
    id: json[ClassFields.id] as int,
    name: json[ClassFields.name] as String,
    classNumber: json[ClassFields.classNumber] as String,

  );

  static String fromJsonToString(Map<String,Object?> json)=>json[ClassFields.classNumber] as String;
  Map<String,Object?> getMap(){
    return {
      ClassFields.id: id,
      ClassFields.name: name,
      ClassFields.classNumber: classNumber,
    };
  }
}