import 'package:foot_quiz/data/levels.dart';
import 'package:foot_quiz/question_summary.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(
      {super.key,
      required this.chosenAnswer,
      required this.index,
      required this.restartQuiz,
      this.nextLevel});

  final List<String> chosenAnswer;
  final void Function() restartQuiz;
  final void Function(int score)? nextLevel;
  final int index;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];
    for (var i = 0; i < chosenAnswer.length; i++) {
      summary.add({
        'question_index': i,
        'question': levels[index].listQuestion[i].text,
        'correct_answer': levels[index].listQuestion[i].answer[0],
        'user_answer': chosenAnswer[i],
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    String lvl = '';
    if (index == 0) {
      lvl = 'Niveau Facile';
    }

    if (index == 1) {
      lvl = 'Niveau Moyen';
    }

    if (index == 2) {
      lvl = 'Niveau Difficile';
    }

    if (index == 3) {
      lvl = 'Niveau Expert';
    }
    final summaryData = getSummaryData();
    final numTotalQuestion = levels[index].listQuestion.length;
    final int numCorrectQuestion = summaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;
    return SizedBox(
        width: double.infinity,
        child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  lvl,
                  style: GoogleFonts.lato(
                    color: const Color.fromARGB(255, 201, 153, 251),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  'Vous avez $numCorrectQuestion sur $numTotalQuestion  bonnes réponses!',
                  style: GoogleFonts.lato(
                    color: const Color.fromARGB(255, 201, 153, 251),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                QuestionSummary(summaryData: summaryData),
                const SizedBox(
                  height: 30,
                ),
                (numCorrectQuestion <= numTotalQuestion / 2)
                    ? OutlinedButton.icon(
                        onPressed: restartQuiz,
                        label: const Text('Redémarer!'),
                        icon: const Icon(Icons.restart_alt_rounded),
                        style: OutlinedButton.styleFrom(
                          foregroundColor:
                              const Color.fromARGB(255, 237, 223, 252),
                        ),
                      )
                    : OutlinedButton.icon(
                        onPressed: () => {nextLevel!(numCorrectQuestion)},
                        label: const Text('Suivant!'),
                        icon: const Icon(Icons.arrow_right),
                        style: OutlinedButton.styleFrom(
                          foregroundColor:
                              const Color.fromARGB(255, 237, 223, 252),
                        ),
                      ),
              ],
            )));
  }
}
