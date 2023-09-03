import 'package:flutter/material.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //backgroundColor: Colors.grey.shade900,
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
  })  : questionText = q,
        questionAnswer = a;
}

class QuestionBrain {
  int _questionNumber = 0;

  List<Question> _questionBank = [
    Question(
        q: "Walter White's alias 'Heisenberg' is inspired by the physicist Werner Heisenberg.",
        a: true),
    Question(
        q: "Marvel's Black Widow, Natasha Romanoff, has superhuman powers.",
        a: false),
    Question(
        q: "In Breaking Bad, Jesse Pinkman becomes a chemistry teacher.",
        a: false),
    Question(q: "The Joker is a primary antagonist in DC Comics.", a: true),
    Question(q: "Marvel's Thor is the Norse god of thunder.", a: true),
    Question(
        q: "In Breaking Bad, Saul Goodman's real name is James Morgan 'Jimmy' McGill.",
        a: true),
    Question(
        q: "The Green Arrow is a DC superhero who primarily uses a sword as his weapon.",
        a: false),
    Question(
        q: "In Marvel Comics, Captain America's shield is made of adamantium.",
        a: false),
    Question(
        q: "The Marvel character Deadpool is known for his accelerated healing factor.",
        a: true),
    Question(
        q: "Lex Luthor is the arch-enemy of Wonder Woman in DC Comics.",
        a: false),
    Question(
        q: "In Breaking Bad, the character Gustavo Fring is a high school chemistry teacher.",
        a: false),
    Question(
        q: "The DC superhero The Flash can travel faster than the speed of light.",
        a: true),
    Question(
        q: "In Marvel Comics, Black Panther is the king of the fictional African nation of Wakanda.",
        a: true),
    Question(
        q: "Breaking Bad is primarily set in the state of Texas.", a: false),
    Question(
        q: "Doctor Strange is a neurosurgeon who gains mystical powers in Marvel Comics.",
        a: true),
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
