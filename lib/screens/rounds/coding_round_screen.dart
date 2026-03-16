import 'dart:async';
import 'package:flutter/material.dart';
import '../result/result_screen.dart';

class CodingRoundScreen extends StatefulWidget {
  const CodingRoundScreen({super.key});

  @override
  State<CodingRoundScreen> createState() => _CodingRoundScreenState();
}

class _CodingRoundScreenState extends State<CodingRoundScreen> {

  // TIMER
  Timer? timer;
  int timeLeft = 2400; // 40 minutes

  // SCORE
  int passedQuestions = 0;

  // SAMPLE CODING QUESTIONS
  List codingQuestions = [
    {
      "problem": "Find max element in array",
      "testCases": [
        {"input": "[1,2,3,4]", "output": "4"},
        {"input": "[10,5,7]", "output": "10"}
      ]
    },
    {
      "problem": "Find sum of array",
      "testCases": [
        {"input": "[1,2,3]", "output": "6"},
        {"input": "[5,5,5]", "output": "15"}
      ]
    }
  ];

  int currentQuestion = 0;

  TextEditingController codeController = TextEditingController();

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

  // CHECK TEST CASE
  bool checkAnswer(String userOutput, String expectedOutput){
    return userOutput.trim() == expectedOutput.trim();
  }

  // SUBMIT CODE
  void submitAnswer() {

    var question = codingQuestions[currentQuestion];

    int passedTestCases = 0;

    for(var test in question["testCases"]) {

      String expected = test["output"];

      // here userOutput should come from your code execution API
      String userOutput = codeController.text;

      if(checkAnswer(userOutput, expected)) {
        passedTestCases++;
      }

    }

    if(passedTestCases >= 2) {
      passedQuestions++;
    }

    if(currentQuestion < codingQuestions.length - 1) {
      setState(() {
        currentQuestion++;
      });
    } else {
      goToResult();
    }
  }

  void goToResult() {
    timer?.cancel();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          aptitudeScore: 0,
          codingScore: passedQuestions,
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    int minutes = timeLeft ~/ 60;
    int seconds = timeLeft % 60;

    var question = codingQuestions[currentQuestion];

    return Scaffold(
      appBar: AppBar(title: const Text("Coding Round")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            Text(
              "Time Left: $minutes:$seconds",
              style: const TextStyle(fontSize: 22),
            ),

            const SizedBox(height: 20),

            Text(
              question["problem"],
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: codeController,
              maxLines: 10,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Write your code output here...",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: submitAnswer,
              child: const Text("Submit"),
            )

          ],
        ),
      ),
    );
  }
}