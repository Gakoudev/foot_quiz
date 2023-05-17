import 'package:foot_quiz/models/quiz_question.dart';

class LevelQuestion {
  LevelQuestion(this.level, this.listQuestion);

  final int level;
  List<QuizQuestion> listQuestion;
}
