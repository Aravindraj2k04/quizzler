import 'question.dart';


class questionbrain {
  int questionnumber = 0;
  List<Question> questionBank = [
    Question(q: 'You can lead a cow down stairs but not up stairs.', a: false),
    Question(
        q: 'Approximately one quarter of human bones are in the feet.',
        a: true),
    Question(q: 'A slug\'s blood is green.', a: true),
    Question(q: 'Your Heisenburg', a: true),
    Question(q: 'Is the Earth flat?', a: false),
    Question(q: 'Is the sun a planet?', a: false),
    Question(q: 'Is the moon a planet?', a: false),
    Question(q: 'Is the Earth flat?', a: false),
    Question(q: 'Is the sun a planet?', a: false),
    Question(q: 'Is water a solid?', a: false),
    Question(q: 'Is the capital of France London?', a: false),
    Question(q: 'Can you divide by zero?', a: false),
    Question(q: 'Is Python a programming language?', a: true),
    Question(q: 'Is the moon made of cheese?', a: false),
    Question(q: 'Is Flutter a framework for web development?', a: false),
    Question(q: 'Is JavaScript a statically typed language?', a: false),
    Question(
        q: 'Is 42 the answer to the ultimate question of life, the universe, and everything?',
        a: true),
    Question(q: 'Questions gonna start again', a: true),
  ];

  void nextQuestion(int questionnumber) {
    if (questionnumber < questionBank.length - 1) {
      questionnumber++;
    }
    else {
      questionnumber = 0;
    }
  }
}
