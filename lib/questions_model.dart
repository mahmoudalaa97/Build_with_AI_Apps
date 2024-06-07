class QuestionModel {
  final String question;
  final List<String> answers;
  final String correctAnswer;

  QuestionModel(this.question, this.answers, this.correctAnswer);

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      json['question_name'] as String,
      List<String>.from(json['answers']),
      json['correct_answer'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answers': answers,
      'correctAnswer': correctAnswer,
    };
  }
}
