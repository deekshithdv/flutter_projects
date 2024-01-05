import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key, required this.onSelectAnswer});

  final void Function(String answer) onSelectAnswer;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreen();
}

class _QuestionsScreen extends State<QuestionsScreen> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var currentQuestion = questions[currentIndex];
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                currentQuestion.text,
                textAlign: TextAlign.center,
              ),
              ...currentQuestion.answers.map((answer) {
                return ElevatedButton(
                  onPressed: () {
                    nextQuestion(answer);
                  },
                  style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 10, horizontal: 80))),
                  child: Text(
                    answer,
                    textAlign: TextAlign.center,
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void nextQuestion(String selectedAnswer) {
    widget.onSelectAnswer(selectedAnswer);

    setState(() {
      currentIndex++;
    });
  }
}
