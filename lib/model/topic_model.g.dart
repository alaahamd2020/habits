// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicModel _$TopicModelFromJson(Map<String, dynamic> json) =>
    TopicModel(
        id: json['id'] as String?,
        title: json['title'] as String,
        target: (json['target'] as num).toInt(),
        description: json['description'] as String?,
      )
      ..userId = json['userId'] as String
      ..createdAt = DateTime.parse(json['createdAt'] as String);

Map<String, dynamic> _$TopicModelToJson(TopicModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'target': instance.target,
      'userId': instance.userId,
      'createdAt': instance.createdAt.toIso8601String(),
    };
