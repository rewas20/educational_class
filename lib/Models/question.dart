final String tableQuestion = 'question';

class QuestionFields {
  static final List<String> values = [
    id,question,grade
  ];
  static final String id = '_id';
  static final String question = 'question';
  static final String grade = 'grade';

}

class QuestionModel {
  final int? id;
  final String question;
  final String grade;

  QuestionModel({
    this.id,
    required this.question,
    required this.grade,
  });

  QuestionModel copy({
    int? id,
    String? question,
    String? check,
    String? grade,
  }) =>
      QuestionModel(
        id: id ?? this.id,
        question: question ?? this.question,
        grade: grade ?? this.grade,
      );

  static QuestionModel fromJson(Map<String,Object?> json)=>QuestionModel(
    id: json[QuestionFields.id] as int,
    question: json[QuestionFields.question] as String,
    grade: json[QuestionFields.grade] as String,
  );

  Map<String,Object?> getMap(){
    return {
      QuestionFields.id:id,
      QuestionFields.question:question,
      QuestionFields.grade:grade,
    };
  }



}