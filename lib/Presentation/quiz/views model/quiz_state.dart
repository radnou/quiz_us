import 'package:equatable/equatable.dart';

enum QuizStatus { initial, correct, incorrect, complete }

class QuizState extends Equatable {
  final String selectedAnswer;
  final int nbCorrect;
  final QuizStatus status;

  const QuizState(
      {required this.selectedAnswer,
      required this.nbCorrect,
      required this.status});

  @override
  List<Object?> get props => [selectedAnswer, nbCorrect, status];

  factory QuizState.initial() {
    return const QuizState(
        selectedAnswer: '', nbCorrect: 0, status: QuizStatus.initial);
  }
  /**
   * Renvoie un bool si le status est correct ou incorrecte
   */
  bool get answered =>
      status == QuizStatus.correct || status == QuizStatus.incorrect;

  QuizState copyWith({
    String? selectedAnswer,
    int? nbCorrect,
    QuizStatus? status,
  }) {
    return QuizState(
        selectedAnswer: selectedAnswer ?? this.selectedAnswer,
        nbCorrect: nbCorrect ?? this.nbCorrect,
        status: status ?? this.status);
  }
}
