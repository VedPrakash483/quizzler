import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:flutter/cupertino.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int finalScore=0;
  QuestionBank qb =
      QuestionBank(); //making object of class QuestionBank from quiz_dart file

  void checkAnswer(bool userpickedAnswer) {
    bool correctAnswer = qb.getQuestionAnswer();
    setState(() {
      if (qb.isfinished() == true) {

        Alert(
          context: context,
          title: "Quiz Over",
          desc: "Your final Score is: $finalScore",
        ).show();
        finalScore=0;
        qb.reset();
        scoreKeeper = [];
      } else {
        if (userpickedAnswer == correctAnswer) {
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green[900],
          ));
          finalScore=finalScore+100;
        } else {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red[700],
          ));
        }
        qb.nextQuestion();
      }
    });
  }

  List<Icon> scoreKeeper = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                // qb.questionBank[questionnumber].questionText,
                qb.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              child: Container(
                color: Colors.green,
                height: 100,
                width: 400,
                child: const Center(
                  child: Text(
                    'True',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              onTap: () {
                checkAnswer(true);
                // bool correctAnswer=qb.questionBank[questionnumber].questionanswer;
                //The user picked true.
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              child: Container(
                height: 100,
                width: 400,
                color: Colors.red,
                child: const Center(
                  child: Text(
                    'False',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              onTap: () {
                checkAnswer(false);
                setState(() {
                  qb.nextQuestion();
                });
                //The user picked false.
              },
            ),
          ),
        ),

        Row(
          children: scoreKeeper,
        ),
        //TODO: Add a Row here as your score keeper
      ],
    );
  }
}
