import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:html_character_entities/html_character_entities.dart';
import 'package:quiz_us/Presentation/common/widgets/circular_Icon.dart';

class AnswerCard extends HookConsumerWidget {
  final String answer;
  final bool isSelected;
  final bool isCorrect;
  final bool isDisplayingAnswer;
  final VoidCallback onTap;

  const AnswerCard(
      {Key? key,
      required this.answer,
      required this.isSelected,
      required this.isCorrect,
      required this.isDisplayingAnswer,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: const Color(0xffCCDCE7),
          border: Border.all(
              color: isDisplayingAnswer
                  ? isCorrect
                      ? Colors.green
                      : isSelected
                          ? Colors.red
                          : Colors.white10
                  : const Color(0xffCCDCE7),
              width: 4.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                child: Text(
              HtmlCharacterEntities.decode(answer),
              style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: isDisplayingAnswer && isCorrect
                      ? FontWeight.bold
                      : FontWeight.normal),
            )),
            if (isDisplayingAnswer)
              isCorrect
                  ? const CircularIcon(icon: Icons.check, color: Colors.green)
                  : isSelected
                      ? const CircularIcon(icon: Icons.close, color: Colors.red)
                      : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
