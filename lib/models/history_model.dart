import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryModel {
  final String userId;
  final String roundType;
  final String difficulty;
  final int score;
  final DateTime date;

  HistoryModel({
    required this.userId,
    required this.roundType,
    required this.difficulty,
    required this.score,
    required this.date,
  });

  // ✅ Convert to Firestore
  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "roundType": roundType,
      "difficulty": difficulty,
      "score": score,
      "date": Timestamp.fromDate(date), // ✅ FIXED
    };
  }

  // ✅ Convert from Firestore
  factory HistoryModel.fromMap(Map<String, dynamic> map) {
    return HistoryModel(
      userId: map["userId"] ?? "",
      roundType: map["roundType"] ?? "",
      difficulty: map["difficulty"] ?? "",
      score: map["score"] ?? 0,
      date: (map["date"] as Timestamp).toDate(), // ✅ FIXED
    );
  }
}