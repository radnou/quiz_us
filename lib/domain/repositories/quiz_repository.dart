import 'package:quiz_us/domain/entities/question.dart';

// interface implemented
abstract class QuizRepository {
  //conversion de QuestionResponse en Question List quand elle sera délivré par la Présentation
  Future<List<Question>> getQuestions(
      {required int numQuestions, required int categoryId});
}
