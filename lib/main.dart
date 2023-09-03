import 'package:flutter/material.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class Question {
  String questionText;
  bool questionAnswer;

  Question({
    required String q,
    required bool a,
  })   : questionText = q,
        questionAnswer = a;
}

class QuestionBrain {
  int _questionNumber = 0;

  List<Question> _questionBank = [
    Question(q: 'Is the Earth flat?', a: false),
    Question(q: 'Is the sun a planet?', a: false),
    Question(q: 'Is water a solid?', a: false),
    Question(q: 'Is the capital of France London?', a: false),
    Question(q: 'Can you divide by zero?', a: false),
    Question(q: 'Is Walter White the main character in Breaking Bad?', a: true),
    Question(q: 'Is Heisenberg a drug lord in Breaking Bad?', a: true),
    Question(q: 'Is Jesse Pinkman a chemist in Breaking Bad?', a: false),
    Question(q: 'Is Los Pollos Hermanos a fast-food chain in Breaking Bad?', a: true),
    Question(q: 'Is Gustavo Fring a major antagonist in Breaking Bad?', a: true),
    Question(q: 'Is Skyler White Walter White\'s wife in Breaking Bad?', a: true),
    Question(q: 'Is Breaking Bad set in Albuquerque, New Mexico?', a: true),
    Question(q: 'Is Marvel Comics the publisher of Spider-Man comics?', a: true),
    Question(q: 'Is Tony Stark also known as Iron Man in Marvel Comics?', a: true),
    Question(q: 'Is Gotham City the home of Batman in DC Comics?', a: true),
    Question(q: 'Is Wonder Woman a member of the Justice League in DC Comics?', a: true),
    Question(q: 'Is Bruce Wayne\'s secret identity Batman in DC Comics?', a: true),
    Question(q: 'Is Thor a Norse god and a superhero in Marvel Comics?', a: true),
    Question(q: 'Is the Hulk a member of the Avengers in Marvel Comics?', a: true),
    Question(q: 'Is Black Widow a Russian spy and Avenger in Marvel Comics?', a: true),
  ];

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getCorrectAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  bool isFinished() {
    return _questionNumber >= _questionBank.length - 1;
  }

  void reset() {
    _questionNumber = 0;
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  QuestionBrain qBrain = QuestionBrain();

  void checkAnswer(bool userAnswer) {
    bool correctAnswer = qBrain.getCorrectAnswer();
    
    if (userAnswer == correctAnswer) {
      scoreKeeper.add(Icon(Icons.check, color: Colors.green));
    } else {
      scoreKeeper.add(Icon(Icons.close, color: Colors.red));
    }
    
    setState(() {
      if (!qBrain.isFinished()) {
        qBrain.nextQuestion();
      } else {
        // Show a dialog or navigate to a results screen when the quiz is finished.
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Quiz Completed'),
              content: Text('You have completed the quiz!'),
              actions: <Widget>[
                TextButton(
                  child: Text('Restart Quiz'),
                  onPressed: () {
                    setState(() {
                      qBrain.reset();
                      scoreKeeper.clear();
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                qBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
