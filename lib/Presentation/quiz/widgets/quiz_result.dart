import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_us/Presentation/common/widgets/customButton.dart';
import 'package:quiz_us/Presentation/quiz/views%20model/quiz_state.dart';
import 'package:quiz_us/Presentation/quiz/views%20model/quiz_view_model.dart';

class QuizResults extends HookConsumerWidget {
  final QuizState state;
  final int nbQuestions;
  const QuizResults({Key? key, required this.state, required this.nbQuestions})
      : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '${state.nbCorrect} / $nbQuestions',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 60.0,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        const Text(
          'CORRECT',
          style: TextStyle(
            color: Colors.white,
            fontSize: 48.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 40.0,
        ),
        CustomButton(
          title: 'New Quiz',
          onTap: () {
            ref.refresh(questionsProvider);
            ref.read(quizViewModelProvider.notifier).reset();
          },
        ),
      ],
    );
  }
}
