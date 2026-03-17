import 'dart:math';

class RandomHR {

  static List<String> pickQuestions(List<String> list, int count) {
    list.shuffle(Random());
    return list.take(count).toList();
  }

}