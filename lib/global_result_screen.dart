import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlobalResultScreen extends StatelessWidget {
  const GlobalResultScreen(
      {required this.score, required this.startQuiz, super.key});
  final void Function() startQuiz;
  final int score;

  @override
  Widget build(context) {
    String img = 'assets/images/worst.png';
    String result = 'Vous êtes null null null';
    if ((score <= 35) && (score >= 25)) {
      img = 'assets/images/midle.png';
      result = 'Espèce d\'amateur';
    }
    if ((score <= 39) && (score >= 25)) {
      img = 'assets/images/good.png';
      result = 'Vous êtes un connaisseur';
    }
    if (score == 40) {
      img = 'assets/images/king.png';
      result = 'Vous êtes le KING';
    }
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Vous avez un total de $score sur 40 bonnes réponses!',
            style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 201, 153, 251),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Image.asset(
            img,
            width: 400,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            result,
            style: GoogleFonts.lato(
              color: Color.fromARGB(255, 201, 153, 251),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          /**
           * changer l'index de pour les level
           */
          OutlinedButton.icon(
            onPressed: startQuiz,
            label: const Text('Restart Quiz!'),
            icon: const Icon(Icons.restart_alt_rounded),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 237, 223, 252),
            ),
          ),
        ],
      ),
    );
  }
}
