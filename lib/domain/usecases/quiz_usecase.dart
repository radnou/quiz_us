import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_us/data/repositories/quiz_repository_impl.dart';
import 'package:quiz_us/domain/entities/question.dart';
import 'package:quiz_us/domain/repositories/quiz_repository.dart';

final quizUseCaseProvider = Provider<QuizUseCase>(
    (ref) => QuizUseCase(ref.read(QuizRepositoryProvider)));

class QuizUseCase {
  final QuizRepository _repository;

  //demande un repository
  QuizUseCase(this._repository);

  Future<List<Question>> getQuestions() {
    return _repository.getQuestions(
        numQuestions: 5, categoryId: Random().nextInt(24) + 9);
  }
}
