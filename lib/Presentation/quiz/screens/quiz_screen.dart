import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_us/Presentation/common/widgets/customButton.dart';
import 'package:quiz_us/Presentation/common/widgets/error.dart';
import 'package:quiz_us/Presentation/quiz/views%20model/quiz_state.dart';
import 'package:quiz_us/Presentation/quiz/views%20model/quiz_view_model.dart';
import 'package:quiz_us/Presentation/quiz/widgets/quiz_question.dart';
import 'package:quiz_us/Presentation/quiz/widgets/quiz_result.dart';
import 'package:quiz_us/domain/entities/question.dart';

class QuizScreen extends HookConsumerWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();
    final viewModel = ref.watch(quizViewModelProvider);
    final questionFuture = ref.watch(questionsProvider);

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF22293E), //0xFF22293E
      ),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF22293E),
            title: Text('Quizz Us',
                style: GoogleFonts.notoSansCham(
                  color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.w400,
                )),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.add_alert),
                tooltip: 'Show Snackbar',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('This is a snackbar')));
                },
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          body: questionFuture.when(
              data: (questions) => _buildBody(
                  context, ref, viewModel, pageController, questions),
              error: (error, _) => Error(
                  message: error.toString(),
                  callback: () => refreshAll(context, ref)),
              loading: () => const Center(child: CircularProgressIndicator())),
          bottomSheet: questionFuture.maybeWhen(
              data: (questions) {
                if (!viewModel.answered) return SizedBox.shrink();
                var currentIndex = pageController.page?.toInt() ?? 0;
                return CustomButton(
                    title: currentIndex + 1 < questions.length
                        ? "Next Question"
                        : "See Results",
                    onTap: () => {
                          ref
                              .read(quizViewModelProvider.notifier)
                              .nextQuestion(questions, currentIndex),
                          if (currentIndex + 1 < questions.length)
                            {
                              pageController.nextPage(
                                  duration: const Duration(microseconds: 250),
                                  curve: Curves.linear)
                            }
                        });
              },
              orElse: () => SizedBox.shrink())),
    );
  }

  void refreshAll(BuildContext context, WidgetRef ref) {
    ref.refresh(questionsProvider);
    ref.read(quizViewModelProvider.notifier).reset();
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, QuizState state,
      PageController pageController, List<Question> questions) {
    // si liste des questions est vide , renvoie une erreur
    if (questions.isEmpty) {
      return Error(
          message: "No Questions found",
          callback: () => refreshAll(context, ref));
    }
    // renvoie soit la page avec le résultat soit la page avec la prochaine question
    return state.status == QuizStatus.complete
        ? QuizResults(state: state, nbQuestions: questions.length)
        : QuizQuestion(pageController, state, questions);
  }
}
