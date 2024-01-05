import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/end_screen.dart';
import 'package:quiz_app/questions_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Quiz> {
  var currentScreen = 'Quiz';
  late Widget nextScreen;
  List<String> selectedAnswers = [];

  void navigateScreen() {
    setState(() {
      currentScreen = 'questions-screen';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);
    if (selectedAnswers.length == questions.length - 1) {
      setState(() {
        currentScreen = 'end-screen';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentScreen == 'questions-screen') {
      return QuestionsScreen(onSelectAnswer: chooseAnswer);
    }
    if (currentScreen == 'end-screen') {
      return Endscreen(
        chosenAnswers: selectedAnswers,
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to Quiz app!',
            ),
            TextButton(
              onPressed: () {
                navigateScreen();
              },
              child: const Text('Lets Start'),
            ),
          ],
        ),
      ),
    );
  }
}
