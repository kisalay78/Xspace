import 'package:flutter/material.dart';

class CodingRoundScreen extends StatelessWidget {
  const CodingRoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Coding Round"),
      ),
      body: const Center(
        child: Text(
          "Coding Problem Will Appear Here",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}