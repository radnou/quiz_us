import 'package:equatable/equatable.dart';
import 'package:quiz_us/domain/entities/question.dart';

class QuestionResponse extends Equatable {
  final String category;
  final String difficulty;
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  const QuestionResponse({
    required this.category,
    required this.difficulty,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  @override
  List<Object?> get props =>
      [category, difficulty, question, correctAnswer, incorrectAnswers];

  // conversion QuestionResponse en Question

  Question toEntity() {
    return Question(
        category: category,
        difficulty: difficulty,
        question: question,
        correctAnswer: correctAnswer,
        // construction liste de réponses
        // .. retourne la liste et ajoute et mélange la liste
        answers: incorrectAnswers
          ..add(correctAnswer)
          ..shuffle());
  }

  factory QuestionResponse.fromMap(Map<String, dynamic> map) {
    return QuestionResponse(
        category: map['category'],
        difficulty: map['difficulty'],
        question: map['question'],
        correctAnswer: map['correct_answer'],
        incorrectAnswers: List<String>.from(map['incorrect_answers'] ?? []));
  }
}
