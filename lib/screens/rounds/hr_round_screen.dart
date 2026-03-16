import 'package:flutter/material.dart';
import '../../services/hr_questions.dart';
import '../../utils/random_hr_question.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../result/result_screen.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:camera/camera.dart';

class HRRoundScreen extends StatefulWidget {
  const HRRoundScreen({super.key});

  @override
  State<HRRoundScreen> createState() => _HRRoundScreenState();
}

class _HRRoundScreenState extends State<HRRoundScreen> {

  FlutterTts tts = FlutterTts();
  SpeechToText speech = SpeechToText();

  CameraController? controller;
  List<CameraDescription>? cameras;

  List<String> questions = [];
  int currentQuestion = 0;

  String userAnswer = "";
  bool isListening = false;

  @override
  void initState() {
    super.initState();

    initCamera();

    questions = RandomHR.pickQuestions(HRQuestions.questions, 5);

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        speakQuestion(questions[currentQuestion]);
      }
    });
  }

  // Initialize camera
  Future<void> initCamera() async {

    cameras = await availableCameras();

    controller = CameraController(
      cameras![0],
      ResolutionPreset.medium,
    );

    await controller!.initialize();

    if (mounted) {
      setState(() {});
    }
  }

  // AI voice asks question
  void speakQuestion(String question) async {
    await tts.stop();
    await tts.setLanguage("en-US");
    await tts.setSpeechRate(0.5);
    await tts.speak(question);
  }

  // Start speech recognition
  void startListening() async {

    bool available = await speech.initialize();

    if (available) {

      setState(() {
        isListening = true;
      });

      speech.listen(
        onResult: (result) {
          setState(() {
            userAnswer = result.recognizedWords;
          });
        },
      );
    }
  }

  // Next question
  void nextQuestion() {

    speech.stop();

    if (currentQuestion < questions.length - 1) {

      setState(() {
        currentQuestion++;
        userAnswer = "";
      });

      speakQuestion(questions[currentQuestion]);

    } else {

      goToResult();
    }
  }

  // Navigate to result screen
  void goToResult() {

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const ResultScreen(
          aptitudeScore: 0,
          codingScore: 0,
        ),
      ),
    );
  }

  @override
  void dispose() {
    tts.stop();
    speech.stop();
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (questions.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    String question = questions[currentQuestion];

    return Scaffold(

      appBar: AppBar(
        title: const Text("HR Interview Round"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: SingleChildScrollView(
          child: Column(
            children: [

              // Camera Preview
              controller == null || !controller!.value.isInitialized
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      height: 200,
                      child: CameraPreview(controller!),
                    ),

              const SizedBox(height: 20),

              Text(
                "Question ${currentQuestion + 1} / ${questions.length}",
                style: const TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 30),

              Text(
                question,
                style: const TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  speakQuestion(question);
                },
                child: const Text("🔊 Listen Question"),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: startListening,
                child: const Text("🎤 Start Answer"),
              ),

              const SizedBox(height: 20),

              Text(
                userAnswer,
                style: const TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: nextQuestion,
                child: const Text("Next Question"),
              ),

            ],
          ),
        ),
      ),
    );
  }
}