import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habits/firebase/auth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'topic_model.g.dart';

@JsonSerializable()
class TopicModel{
  String? id;
  String title;
  String? description;
  int target;

  DateTime createdAt = Timestamp.now().toDate();
  String userId = FBAuth.user!.id!;

  TopicModel({
    this.id,
    required this.title,
    required this.target,
    required this.createdAt,
    this.description,
  });


  factory TopicModel.fromJson(Map<String, dynamic> json) => _$TopicModelFromJson(json);

  int currentStreak(DateTime? lastHabitDate) {
    final result = Timestamp.now().toDate().difference(lastHabitDate  ?? createdAt).inDays-1;
    return result < 0 ? 0 : result;
  }

  int currentStreakAdd(DateTime? lastHabitDate, DateTime nextHabitDate) {
    final firstDay = lastHabitDate ?? createdAt;
    final lastDay = nextHabitDate;
    final result = lastDay.difference(firstDay).inDays;
    return result > 0?  result-1 : 0;
  }

  Map<String, dynamic> toJson() => _$TopicModelToJson(this);
}