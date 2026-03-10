import 'package:flutter/material.dart';

class RoundSelectionScreen extends StatelessWidget {
  const RoundSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Interview Rounds"),
      ),
      body: const Center(
        child: Text(
          "Choose Round: Coding / Aptitude / HR",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}