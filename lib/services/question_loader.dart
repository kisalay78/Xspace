import 'dart:convert';
import 'package:flutter/services.dart';

class QuestionLoader {

  static Future<List> loadAptitudeQuestions() async {
    String data = await rootBundle.loadString('assets/questions/aptitude_questions.json');
    return json.decode(data);
  }

  static Future<List> loadCodingQuestions() async {
    String data = await rootBundle.loadString('assets/questions/coding_questions.json');
    return json.decode(data);
  }
}