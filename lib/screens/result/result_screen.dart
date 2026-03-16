import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {

  final int aptitudeScore;
  final int codingScore;

  const ResultScreen({
    super.key,
    required this.aptitudeScore,
    required this.codingScore,
  });

  String getRating(int aptitude, int coding){

    int total = aptitude + coding;

    if(total >= 3) return "Excellent";
    if(total == 2) return "Good";
    return "Needs Improvement";
  }

  @override
  Widget build(BuildContext context) {

    String rating = getRating(aptitudeScore, codingScore);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Interview Result"),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text(
              "Your Performance",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            Text(
              "Aptitude Score: $aptitudeScore / 2",
              style: const TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 10),

            Text(
              "Coding Score: $codingScore / 2",
              style: const TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 20),

            Text(
              "Performance Rating: $rating",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),

          ],
        ),
      ),
    );
  }
}