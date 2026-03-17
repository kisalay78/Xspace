import 'dart:async';
import 'package:flutter/material.dart';
import '../result/result_screen.dart';
import '../../services/code_runner.dart';
import '../../services/history_service.dart'; // ✅ ADDED

class CodingRoundScreen extends StatefulWidget {
  const CodingRoundScreen({super.key});

  @override
  State<CodingRoundScreen> createState() => _CodingRoundScreenState();
}

class _CodingRoundScreenState extends State<CodingRoundScreen> {

  Timer? timer;
  int timeLeft = 2400;

  int passedQuestions = 0;
  int currentQuestion = 0;

  bool checked = false;
  List<bool?> testResults = [];

  TextEditingController codeController = TextEditingController();

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

  @override
  void initState() {
    super.initState();
    startTimer();
  }

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

  // ✅ RUN TEST CASES USING BACKEND
  Future<void> checkTestCases() async {
    var question = codingQuestions[currentQuestion];

    List<bool?> results = [];

    for (var test in question["testCases"]) {

      String input = test["input"];
      String expected = test["output"];

      try {
        String result = await runPythonCode(
          codeController.text,
          input,
        );

        if (result.trim() == expected.trim()) {
          results.add(true);
        } else {
          results.add(false);
        }

      } catch (e) {
        results.add(false);
      }
    }

    setState(() {
      testResults = results;
      checked = true;
    });
  }

  // ✅ FINAL RESULT + SAVE HISTORY
  Future<void> goToResult() async {
    timer?.cancel();

    // 🔥 SAVE HISTORY HERE
    await saveHistory(
      roundType: "coding",
      difficulty: "easy",
      score: passedQuestions,
    );

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

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              // ⏱ TIMER
              Text(
                "Time Left: $minutes:$seconds",
                style: const TextStyle(fontSize: 22),
              ),

              const SizedBox(height: 20),

              // 🧠 QUESTION + EXAMPLE
              Text(
                question["problem"],
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Example:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    ...question["testCases"].map<Widget>((test) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Input: ${test["input"]}\nOutput: ${test["output"]}",
                        ),
                      );
                    }).toList(),

                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 💻 CODE BOX
              TextField(
                controller: codeController,
                maxLines: 10,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Write your Python code here...\nExample: print(max(arr))",
                ),
              ),

              const SizedBox(height: 20),

              // ▶ RUN BUTTON
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await checkTestCases();
                  },
                  child: const Text("Run Code"),
                ),
              ),

              const SizedBox(height: 30),

              // 📊 TEST CASES
              const Text(
                "Test Cases:",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              ...question["testCases"].asMap().entries.map((entry) {

                int index = entry.key;
                var test = entry.value;

                bool? result;

                if (checked && testResults.length > index) {
                  result = testResults[index];
                }

                return Card(
                  child: ListTile(
                    title: Text("Input: ${test["input"]}"),
                    subtitle: Text("Expected: ${test["output"]}"),
                    trailing: result == null
                        ? const Text("Not Checked")
                        : Icon(
                            result
                                ? Icons.check_circle
                                : Icons.cancel,
                            color: result
                                ? Colors.green
                                : Colors.red,
                          ),
                  ),
                );
              }).toList(),

              const SizedBox(height: 30),

              // ⬅ ➡ NAVIGATION
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                children: [

                  ElevatedButton(
                    onPressed: currentQuestion > 0
                        ? () {
                            setState(() {
                              currentQuestion--;
                              codeController.clear();
                              checked = false;
                              testResults = [];
                            });
                          }
                        : null,
                    child: const Text("Previous"),
                  ),

                  ElevatedButton(
                    onPressed: () {

                      int passed = testResults
                          .where((e) => e == true)
                          .length;

                      if (passed >= 2) {
                        passedQuestions++;
                      }

                      if (currentQuestion <
                          codingQuestions.length - 1) {

                        setState(() {
                          currentQuestion++;
                          codeController.clear();
                          checked = false;
                          testResults = [];
                        });

                      } else {

                        goToResult(); // ✅ FINAL CALL
                      }
                    },
                    child: const Text("Next"),
                  ),

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}