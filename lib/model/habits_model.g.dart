// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habits_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HabitsModel _$HabitsModelFromJson(Map<String, dynamic> json) =>
    HabitsModel(
        json['id'] as String,
        (json['times'] as num).toInt(),
        (json['streak'] as num).toInt(),
        DateTime.parse(json['date'] as String),
        json['topicId'] as String,
      )
      ..createdAt = DateTime.parse(json['created_at'] as String)
      ..userId = json['userId'] as String;

Map<String, dynamic> _$HabitsModelToJson(HabitsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'times': instance.times,
      'streak': instance.streak,
      'date': instance.date.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
      'userId': instance.userId,
      'topicId': instance.topicId,
    };
