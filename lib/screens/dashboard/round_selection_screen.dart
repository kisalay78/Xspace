import 'package:flutter/material.dart';
import '../rounds/coding_round_screen.dart';
import '../rounds/aptitude_round_screen.dart';
import '../rounds/hr_round_screen.dart';

class RoundSelectionScreen extends StatelessWidget {
  const RoundSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Interview Rounds"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            roundButton(context, "Coding Round", Colors.blue),
            const SizedBox(height: 20),

            roundButton(context, "Aptitude Round", Colors.orange),
            const SizedBox(height: 20),

            roundButton(context, "HR Interview", Colors.green),

          ],
        ),
      ),
    );
  }

  Widget roundButton(BuildContext context, String text, Color color) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
        onPressed: () {

          if (text == "Coding Round") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CodingRoundScreen(),
              ),
            );
          }

          else if (text == "Aptitude Round") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AptitudeRoundScreen(),
              ),
            );
          }

          else if (text == "HR Interview") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HrRoundScreen(),
              ),
            );
          }

        },
        child: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}