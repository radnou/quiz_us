

class QuizUseCase {
  final QuizRepository _repository;

  //demande un repository
  QuizUseCase(this._repository);

  Future<List<Question>> getQuestions() {
    return _repository;
  }
}
