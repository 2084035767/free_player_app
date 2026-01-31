// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: (json['id'] as num).toInt(),
  username: json['username'] as String,
  nickname: json['nickname'] as String?,
  email: json['email'] as String?,
  avatar: json['avatar'] as String?,
  phone: json['phone'] as String?,
  gender: (json['gender'] as num?)?.toInt(),
  age: (json['age'] as num?)?.toInt(),
  isVip: json['is_vip'] as bool?,
  createdAt: json['created_at'] as String?,
  lastLogin: json['last_login'] as String?,
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'nickname': instance.nickname,
  'email': instance.email,
  'avatar': instance.avatar,
  'phone': instance.phone,
  'gender': instance.gender,
  'age': instance.age,
  'is_vip': instance.isVip,
  'created_at': instance.createdAt,
  'last_login': instance.lastLogin,
};
