import 'package:quiz_us/data/api/remote_api.dart';
import 'package:quiz_us/data/models/request/question_request.dart';
import 'package:quiz_us/domain/entities/question.dart';
import 'package:quiz_us/domain/repositories/quiz_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/**
 * Implementation de l'interface du domaine 
 */
//côte useCase => utilisation du provider
final quizRepositoryProvider = Provider<QuizRepository>(
    (ref) => QuizRepositoryImpl(ref.read(remoteApiProvider)));

class QuizRepositoryImpl extends QuizRepository {
  // accès aux webService
  final RemoteApi _remoteApi;

  QuizRepositoryImpl(this._remoteApi);
/**
 * Override de la function qui va récupérer les question 
 * pour la var value
 */
  @override
  Future<List<Question>> getQuestions(
      {required int numQuestions, required int categoryId}) {
    return _remoteApi
        .getQuestions(QuestionRequest(
            type: 'multiple', amount: numQuestions, category: categoryId))
        //sur les QuestionResponse, on convertit en utilisant Map puis on appelle la fonction toEntity de la classe
        .then((value) => value
            .map((uneQuestionResponse) => uneQuestionResponse.toEntity())
            .toList());
    //uneQuestionResponse.toEntity()).toList());
  }
}
