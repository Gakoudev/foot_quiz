import 'package:flutter/material.dart';
import 'package:foot_quiz/data/levels.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:foot_quiz/answer_button.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen(
      {required this.onSelectedAnswer, required this.index, super.key});
  final void Function(String answer) onSelectedAnswer;
  final int index;

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  var currentQuestionIdex = 0;

  void answerQuestion(String selectedAnswer) {
    widget.onSelectedAnswer(selectedAnswer);
    setState(() {
      currentQuestionIdex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    String lvl = '';
    if (widget.index == 0) {
      lvl = 'Niveau Facile';
    }

    if (widget.index == 1) {
      lvl = 'Niveau Moyen';
    }

    if (widget.index == 2) {
      lvl = 'Niveau Difficile';
    }

    if (widget.index == 3) {
      lvl = 'Niveau Expert';
    }
    final currentQuestion =
        levels[widget.index].listQuestion[currentQuestionIdex];
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              lvl,
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 201, 153, 251),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 100,
            ),
            Text(
              currentQuestion.text,
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 201, 153, 251),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            ...currentQuestion
                .getShuffledAnswer()
                .map((answer) => QuestionButton(
                    answerText: answer,
                    onTap: () {
                      answerQuestion(answer);
                    })),
          ],
        ),
      ),
    );
  }
}
