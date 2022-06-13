import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_us/Presentation/quiz/views%20model/quiz_state.dart';
import 'package:quiz_us/domain/entities/question.dart';
import 'package:quiz_us/domain/usecases/quiz_usecase.dart';

final quizViewModelProvider =
    StateNotifierProvider.autoDispose<QuizViewModel, QuizState>(
        (ref) => QuizViewModel(ref.read(quizUseCaseProvider)));

final questionsProvider = FutureProvider.autoDispose<List<Question>>(
    (ref) => ref.watch(quizViewModelProvider.notifier).getQuestions());

class QuizViewModel extends StateNotifier<QuizState> {
  QuizViewModel(this._useCase) : super(QuizState.initial());
  final QuizUseCase _useCase;

  Future<List<Question>> getQuestions() {
    return _useCase.getQuestions();
  }

  void submitAnswer(Question currentQuestion, String answer) {
    if (state.answered) return;
    if (currentQuestion.correctAnswer == answer) {
      state = state.copyWith(
          selectedAnswer: answer,
          nbCorrect: state.nbCorrect + 1,
          status: QuizStatus.correct);
    } else {
      state =
          state.copyWith(selectedAnswer: answer, status: QuizStatus.incorrect);
    }
  }

  void nextQuestion(List<Question> questions, int currentIndex) {
    state = state.copyWith(
        selectedAnswer: '',
        status: currentIndex + 1 < questions.length
            ? QuizStatus.initial
            : QuizStatus.complete);
  }

  void reset() {
    state = QuizState.initial();
  }
}
