final String tablePerson = 'person';

class PersonFields {
  static final List<String> values = [
    id,name,gender,typeUser,classNumber,code
  ];
  static final String id = '_id';
  static final String name = 'name';
  static final String gender = 'gender';
  static final String typeUser = 'typeUser';
  static final String classNumber = 'class_number';
  static final String code = 'code';
}

class PersonModel {
  final int? id;
  final String name;
  final String gender;
  final String typeUser;
  final String code;
  final String classNumber;

  PersonModel({
    this.id,
    required this.name,
    required this.gender,
    required this.typeUser,
    required this.code,
    required this.classNumber,
  });

  PersonModel copy({
    int? id,
    String? name,
    String? gender,
    String? typeUser,
    String? classNumber,
    String? code,
  }) =>
      PersonModel(
        id: id ?? this.id,
        name: name ?? this.name,
        gender: gender ?? this.gender,
        typeUser: typeUser ?? this.typeUser,
        classNumber: classNumber ?? this.classNumber,
        code: code ?? this.code,
      );
  static PersonModel fromJson(Map<String,Object?> json)=>PersonModel(
    id: json[PersonFields.id] as int,
    name: json[PersonFields.name] as String,
    gender: json[PersonFields.gender] as String,
    typeUser: json[PersonFields.typeUser] as String,
    classNumber: json[PersonFields.classNumber] as String,
    code: json[PersonFields.code] as String,

  );
  Map<String, Object?> getMap() {
    return {
      PersonFields.id: id,
      PersonFields.name: name,
      PersonFields.gender: gender,
      PersonFields.typeUser: typeUser,
      PersonFields.classNumber: classNumber,
      PersonFields.code: code,
    };
  }
}