import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> saveHistory({
  required String roundType,
  required String difficulty,
  required int score,
}) async {
  try {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    await FirebaseFirestore.instance.collection('history').add({
      "userId": user.uid,
      "roundType": roundType,
      "difficulty": difficulty,
      "score": score,
      "date": Timestamp.now(),
    });

    print("✅ History Saved");
  } catch (e) {
    print("❌ Error saving history: $e");
  }
}