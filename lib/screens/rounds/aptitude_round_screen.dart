import 'package:flutter/material.dart';

class AptitudeRoundScreen extends StatelessWidget {
  const AptitudeRoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aptitude Round"),
      ),
      body: const Center(
        child: Text(
          "Aptitude Questions Here",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}