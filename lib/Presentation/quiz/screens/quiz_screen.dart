import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_us/Presentation/common/widgets/error.dart';
import 'package:quiz_us/Presentation/quiz/views%20model/quiz_state.dart';
import 'package:quiz_us/Presentation/quiz/views%20model/quiz_view_model.dart';
import 'package:provider/provider.dart';
import 'package:quiz_us/domain/entities/question.dart';

class QuizScreen extends HookConsumerWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();
    final viewModel = ref.watch(QuizViewModelProvider);
    final questionFuture = ref.watch(questionsProvider);

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF22293E),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: questionFuture.when(
            data: (questions) => _buildBody(context,ref,viewModel, pageController, questions),
            error: (error, _) => Error(
                message: error.toString(),
                callback: () => refreshAll(context, ref)),
            loading: () => const Center(child: CircularProgressIndicator())),
      ),
    );
  }

  void refreshAll(BuildContext context, WidgetRef ref) {
    ref.refresh(questionsProvider);
    ref.read(QuizViewModelProvider.notifier).reset();
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, QuizState state,
      PageController pageController, List<Question> questions) {
    if (questions.isEmpty) {
      return Error(
          message: "No Questions found",
          callback: () => refreshAll(context, ref));
    }
    // renvoie soit la page avec le résultat soit la page avec la prochaine question 
    return state.status == QuizStatus.complete ? QuizResult(state:state, totalQuestion:questions.length)

  }
}
