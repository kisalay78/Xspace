import 'package:flutter/material.dart';

class HrRoundScreen extends StatelessWidget {
  const HrRoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HR Interview"),
      ),
      body: const Center(
        child: Text(
          "HR Questions Here",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}