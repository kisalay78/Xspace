import 'package:flutter/material.dart';

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

            roundButton("Coding Round", Colors.blue),
            const SizedBox(height: 20),

            roundButton("Aptitude Round", Colors.orange),
            const SizedBox(height: 20),

            roundButton("HR Interview", Colors.green),

          ],
        ),
      ),
    );
  }

  Widget roundButton(String text, Color color) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
        onPressed: () {},
        child: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}