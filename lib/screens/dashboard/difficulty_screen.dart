import 'package:flutter/material.dart';
import 'round_selection_screen.dart';

class DifficultyScreen extends StatelessWidget {
  const DifficultyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Difficulty"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            difficultyButton(context, "Easy", Colors.green),
            const SizedBox(height: 20),

            difficultyButton(context, "Medium", Colors.orange),
            const SizedBox(height: 20),

            difficultyButton(context, "Hard", Colors.red),

          ],
        ),
      ),
    );
  }

  Widget difficultyButton(BuildContext context, String text, Color color) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RoundSelectionScreen(),
            ),
          );
        },
        child: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}