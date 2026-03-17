import 'dart:math';

class RandomQuestion {

  static List getRandom(List questions, int count) {
    questions.shuffle(Random());
    return questions.take(count).toList();
  }

}