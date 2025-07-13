import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'habits_model.g.dart';

@JsonSerializable()
class HabitsModel {
  String id;
  int times, streak;
  DateTime date;
  @JsonKey(name: 'created_at')
  DateTime createdAt = Timestamp.now().toDate();

  String userId = '3XkMSppPiUbDU2fyjme0';
  String topicId;

  HabitsModel(this.id, this.times, this.streak, this.date,this.topicId);

  factory HabitsModel.fromJson(Map<String, dynamic> map) =>
      _$HabitsModelFromJson(map);


  bool get isThisWeek => date.isAfter(DateTime.now().subtract(Duration(days: 7)));

  bool get isThisDay => date.isAfter(DateTime.now().subtract(Duration(days: 1)));

  bool get isThisMonth => date.isAfter(DateTime.now().subtract(Duration(days: 30)));

  int toNextStreak(DateTime next) => next.difference(date).inDays;

  toJson() => _$HabitsModelToJson(this);
}

extension HabitsList on Iterable<HabitsModel> {
  int get totalTimes =>
      fold(0, (previousValue, element) => previousValue + element.times);

  int totalStreak(DateTime startTime) {
    final lastDay = lastOrNull?.date;
    return (lastDay?.difference(startTime).inDays ?? 0) - length;
  }
}

class Converter {
  static Timestamp? toJson(Timestamp? date) => date;

  static Timestamp? fromJson(dynamic date) => date is Timestamp
      ? date
      : Timestamp.fromDate(DateTime.parse(date as String));
}
