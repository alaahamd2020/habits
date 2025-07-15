import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habits/extension/on_date_time.dart';
import 'package:json_annotation/json_annotation.dart';

part 'habits_model.g.dart';

@JsonSerializable(converters: [MyConverter()])
class HabitsModel {
  String id;
  int times, streak;
  Timestamp date;
  @JsonKey(name: 'created_at')
  DateTime createdAt = Timestamp.now().toDate();

  String userId = '3XkMSppPiUbDU2fyjme0';
  String topicId;

  HabitsModel(this.id, this.times, this.streak, this.date, this.topicId);

  factory HabitsModel.fromJson(Map<String, dynamic> map) =>
      _$HabitsModelFromJson(map);

  bool get isThisWeek =>
      date.toDate().isAfter(DateTime.now().subtract(Duration(days: 7)));

  bool get isThisDay =>
      date.toDate().isAfter(DateTime.now().subtract(Duration(days: 1)));

  bool get isThisMonth =>
      date.toDate().isAfter(DateTime.now().subtract(Duration(days: 30)));

  int toNextStreak(DateTime next) => next.difference(date.toDate()).inDays;

  toJson() => _$HabitsModelToJson(this);
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
    final firstDay = firstOrNull?.date.toDate() ?? startTime;
    final DateTime startDay = firstDay.isBefore(startTime)
        ? firstDay
        : startTime;
    final DateTime endDay = Timestamp.now().toDate().isAfter(lastDay.toDate())
        ? Timestamp.now().toDate()
        : lastDay.toDate();
    final int length = this
        .where((element) => (element.date.toDate() != startDay.withoutTime) &&
                (element.date.toDate() != endDay.withoutTime),)
        .uniqueDates
        .length;
    print('length $length');

    final days = totalDays(startTime) - (length + 1);

    return days.clamp(0, days.abs());
  }

  int totalDays(DateTime startTime) {
    if (isEmpty) return Timestamp.now().toDate().difference(startTime).inDays;

    final lastDay = last.date.toDate();
    final firstDay = first.date.toDate();
    final endTime = Timestamp.now().toDate().isAfter(lastDay)
        ? Timestamp.now().toDate()
        : lastDay;
    final isBefore = firstDay.isBefore(startTime);
    final DateTime startTime0 = isBefore ? firstDay : startTime;
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
