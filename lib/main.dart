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
   Question(q: 'In Breaking Bad, what is the street name of Walter White\'s blue meth?', a: true),
    Question(q: 'Which Marvel character possesses the power of the Infinity Gauntlet?', a: true),
    Question(q: 'In DC Comics, who is the alter ego of the superhero known as the Green Lantern?', a: true),
    Question(q: 'What is the alias used by the drug lord in Breaking Bad who is known for his meticulousness?', a: true),
    Question(q: 'In the Marvel Universe, what metal is Wolverine\'s adamantium skeleton coated with?', a: true),
    Question(q: 'Who is the primary antagonist in Breaking Bad, known for his bell and wheelchair?', a: true),
    Question(q: 'In DC Comics, which city is the home of the superhero The Flash?', a: true),
    Question(q: 'What is the real name of the superhero Thor in the Marvel Universe?', a: true),
    Question(q: 'In Breaking Bad, what is the name of the lawyer who helps the main characters with their legal troubles?', a: true),
    Question(q: 'In Marvel Comics, who is the arch-enemy of Spider-Man, known for wearing a mechanical suit?', a: true),
    Question(q: 'Which DC Comics villain is often depicted as Batman\'s greatest enemy, known for his purple suit and green hair?', a: true),
    Question(q: 'In Breaking Bad, what is the significance of the pink teddy bear?', a: true),
    Question(q: 'In the Marvel Cinematic Universe, which character wields the power of the Time Stone?', a: true),
    Question(q: 'Which DC superhero is known for using arrows with various trick arrowheads?', a: true),
    Question(q: 'What is the alias of the scientist who becomes the supervillain known as Doctor Octopus in Spider-Man comics?', a: true),

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
