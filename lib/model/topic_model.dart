import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habits/firebase/firebase.dart';
import 'package:json_annotation/json_annotation.dart';

part 'topic_model.g.dart';

@JsonSerializable()
class TopicModel{
  String? id;
  String title;
  String? description;
  int target;

  String userId = '3XkMSppPiUbDU2fyjme0';

  DateTime createdAt = Timestamp.now().toDate();
  TopicModel({
    this.id,
    required this.title,
    required this.target,
    this.description,
  });

  factory TopicModel.fromJson(Map<String, dynamic> json) => _$TopicModelFromJson(json);

  int currentStreak(DateTime? lastHabitDate) {
    print(lastHabitDate);
    print(createdAt);
    return DateTime.now().difference(lastHabitDate  ?? createdAt).inDays-1;
  }

  Map<String, dynamic> toJson() => _$TopicModelToJson(this);
}