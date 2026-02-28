import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habits/extension/on_date_time.dart';
import 'package:habits/firebase/auth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'habits_model.g.dart';

@JsonSerializable(converters: [MyConverter()])
class HabitsModel {
  String id;
  int times, streak;
  Timestamp date;
  @JsonKey(name: 'created_at')
  DateTime createdAt = Timestamp.now().toDate();

  String userId = FBAuth.user!.id!;
  String topicId;

  HabitsModel(this.id, this.times, this.streak, this.date, this.topicId);

  factory HabitsModel.fromJson(Map<String, dynamic> map) =>
      _$HabitsModelFromJson(map);

  bool get isThisWeek {
    final now = DateTime.now().withoutTime;
    final habitDate = date.toDate().withoutTime;
    return habitDate.isAfter(now.subtract(Duration(days: 7))) ||
        habitDate.isAtSameMomentAs(now);
  }

  bool get isThisDay {
    final now = DateTime.now().withoutTime;
    final habitDate = date.toDate().withoutTime;
    return habitDate.isAtSameMomentAs(now);
  }

  bool get isThisMonth {
    final now = DateTime.now().withoutTime;
    final habitDate = date.toDate().withoutTime;
    return habitDate.isAfter(now.subtract(Duration(days: 30))) ||
        habitDate.isAtSameMomentAs(now);
  }

  bool get isThis3Months {
    final now = DateTime.now().withoutTime;
    final habitDate = date.toDate().withoutTime;
    return habitDate.isAfter(now.subtract(Duration(days: 90))) ||
        habitDate.isAtSameMomentAs(now);
  }

  int toNextStreak(DateTime next) =>
      next.withoutTime.difference(date.toDate().withoutTime).inDays;

  toJson() => _$HabitsModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitsModel &&
          runtimeType == other.runtimeType &&
          date.withoutTime == other.date.withoutTime;

  @override
  int get hashCode => date.hashCode;
}

class MyConverter implements JsonConverter<Timestamp, dynamic> {
  const MyConverter();

  @override
  Timestamp fromJson(json) {
    return (json is Timestamp
            ? json
            : Timestamp.fromDate(DateTime.parse(json as String)))
        .withoutTime;
  }

  @override
  toJson(Timestamp? object) {
    return object;
  }
}

extension HabitsList on Iterable<HabitsModel> {
  int get totalTimes =>
      fold(0, (previousValue, element) => previousValue + element.times);

  int totalStreak(DateTime startTime) {
    final Timestamp lastDay = this.lastOrNull?.date ?? Timestamp.now();
    final firstDay =
        firstOrNull?.date.toDate().withoutTime ?? startTime.withoutTime;
    final DateTime startDay = firstDay.isBefore(startTime.withoutTime)
        ? firstDay
        : startTime.withoutTime;
    final DateTime endDay =
        DateTime.now().withoutTime.isAfter(lastDay.toDate().withoutTime)
        ? DateTime.now().withoutTime
        : lastDay.toDate().withoutTime;
    final int length = this
        .where(
          (element) =>
              (element.date.toDate() != startDay.withoutTime) &&
              (element.date.toDate() != endDay.withoutTime),
        )
        .toSet()
        .length;

    final days = totalDays(startTime) - (length + 1);

    return days.clamp(0, days.abs());
  }

  int totalDays(DateTime startTime) {
    if (isEmpty)
      return DateTime.now().withoutTime
          .difference(startTime.withoutTime)
          .inDays;

    final lastDay = last.date.toDate().withoutTime;
    final firstDay = first.date.toDate().withoutTime;
    final endTime = DateTime.now().withoutTime.isAfter(lastDay)
        ? DateTime.now().withoutTime
        : lastDay;
    final isBefore = firstDay.isBefore(startTime.withoutTime);
    final DateTime startTime0 = isBefore ? firstDay : startTime.withoutTime;
    final days = (endTime.difference(startTime0).inDays);
    return days;
  }

  List<HabitsModel> get uniqueDates {
    final unique = [];
    return where((element) {
      final date = element.date.toDate();
      if (!unique.contains(date)) {
        unique.add(date);
        return true;
      } else {
        return false;
      }
    }).toList();
  }
}

class Converter {
  static Timestamp? toJson(Timestamp? date) => date;

  static Timestamp? fromJson(dynamic date) => date is Timestamp
      ? date
      : Timestamp.fromDate(DateTime.parse(date as String));
}
