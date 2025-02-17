// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HabitImpl _$$HabitImplFromJson(Map<String, dynamic> json) => _$HabitImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      createdBy: User.fromJson(json['createdBy'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$HabitImplToJson(_$HabitImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'createdBy': instance.createdBy,
    };
