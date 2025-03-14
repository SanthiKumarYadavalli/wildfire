// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FriendImpl _$$FriendImplFromJson(Map<String, dynamic> json) => _$FriendImpl(
      profile: User.fromJson(json['profile'] as Map<String, dynamic>),
      dates: Map<String, int>.from(json['dates'] as Map),
    );

Map<String, dynamic> _$$FriendImplToJson(_$FriendImpl instance) =>
    <String, dynamic>{
      'profile': instance.profile,
      'dates': instance.dates,
    };
