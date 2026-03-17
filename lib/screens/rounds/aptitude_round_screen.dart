import 'dart:async';
import 'package:flutter/material.dart';
import '../result/result_screen.dart';
import '../../services/history_service.dart'; // ✅ ADD THIS

class AptitudeRoundScreen extends StatefulWidget {
  const AptitudeRoundScreen({super.key});

  @override
  State<AptitudeRoundScreen> createState() => _AptitudeRoundScreenState();
}

class _AptitudeRoundScreenState extends State<AptitudeRoundScreen> {

  // TIMER
  Timer? timer;
  int timeLeft = 900; // 15 minutes

  // SCORE
  int score = 0;

  // QUESTIONS
  List questions = [
    {
      "question": "25% of 200?",
      "options": ["25","50","75","100"],
      "answer": "50"
    },
    {
      "question": "Next number: 2,6,12,20,?",
      "options": ["28","30","32","34"],
      "answer": "30"
    }
  ];

  int currentQuestion = 0;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  // TIMER FUNCTION
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (timeLeft == 0) {
        t.cancel();
        goToResult();
      }

      setState(() {
        timeLeft--;
      });
    });
  }

  // CHECK ANSWER
  void checkAnswer(String selected) {
    var question = questions[currentQuestion];

    if (selected == question['answer']) {
      score++;
    }

    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
      });
    } else {
      goToResult();
    }
  }

  // ✅ RESULT + SAVE HISTORY
  Future<void> goToResult() async {
    timer?.cancel();

    // 🔥 SAVE HISTORY
    await saveHistory(
      roundType: "aptitude",
      difficulty: "easy",
      score: score,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          aptitudeScore: score,
          codingScore: 0,
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    int minutes = timeLeft ~/ 60;
    int seconds = timeLeft % 60;

    var question = questions[currentQuestion];

    return Scaffold(
      appBar: AppBar(title: const Text("Aptitude Round")),

      body: Column(
        children: [

          const SizedBox(height: 20),

          Text(
            "Time Left: $minutes:$seconds",
            style: const TextStyle(fontSize: 22),
          ),

          const SizedBox(height: 30),

          Text(
            question['question'],
            style: const TextStyle(fontSize: 18),
          ),

          const SizedBox(height: 20),

          ...question['options'].map<Widget>((option) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ElevatedButton(
                onPressed: () {
                  checkAnswer(option);
                },
                child: Text(option),
              ),
            );
          }).toList(),

        ],
      ),
    );
  }
}