// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicModel _$TopicModelFromJson(Map<String, dynamic> json) => TopicModel(
  id: json['id'] as String?,
  title: json['title'] as String,
  target: (json['target'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  description: json['description'] as String?,
)..userId = json['userId'] as String;

Map<String, dynamic> _$TopicModelToJson(TopicModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'target': instance.target,
      'createdAt': instance.createdAt.toIso8601String(),
      'userId': instance.userId,
    };
