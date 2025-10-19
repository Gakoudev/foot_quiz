import 'package:foot_quiz/data/levels.dart';
import 'package:foot_quiz/result_screen.dart';
import 'package:flutter/material.dart';

import 'package:foot_quiz/start_screen.dart';
import 'package:foot_quiz/question_screen.dart';

import 'global_result_screen.dart';

class Quiz extends StatefulWidget {
  Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int index = 0;
  int score = 0;
  var activeScreen = 'start-screen';
  List<String> selectedAnswer = [];

  void chooseAnswer(String answer) {
    selectedAnswer.add(answer);
    if (selectedAnswer.length == levels[index].listQuestion.length) {
      setState(() {
        activeScreen = 'results-screen';
      });
    }
  }

  void switchScreen() {
    setState(() {
      index = 0;
      score = 0;
      selectedAnswer = [];
      activeScreen = 'questions-screen';
    });
  }

  void nextLevelScreen(int nbCorrectAnswer) {
    setState(() {
      score += nbCorrectAnswer;
      selectedAnswer = [];
      activeScreen = 'questions-screen';
      index++;
    });
    if (index >= 4) {
      globalResultScreen();
    }
  }

  void globalResultScreen() {
    setState(() {
      index = 0;
      activeScreen = 'global-result-screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = StartScreen(switchScreen);

    if (activeScreen == 'questions-screen') {
      screenWidget = QuestionScreen(
        onSelectedAnswer: chooseAnswer,
        index: index,
      );
    }
    if (activeScreen == 'results-screen') {
      screenWidget = ResultScreen(
        chosenAnswer: selectedAnswer,
        restartQuiz: switchScreen,
        index: index,
        nextLevel: nextLevelScreen,
      );
    }
    if (activeScreen == 'global-result-screen') {
      screenWidget = GlobalResultScreen(
        score: score,
        startQuiz: switchScreen,
      );
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 78, 13, 151),
                Color.fromARGB(255, 107, 15, 168)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
