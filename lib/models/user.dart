// user.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'username') required String username,
    @JsonKey(name: 'nickname') String? nickname,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'avatar') String? avatar,
    @JsonKey(name: 'phone') String? phone,
    @JsonKey(name: 'gender') int? gender, // 0: 未知, 1: 男, 2: 女
    @JsonKey(name: 'age') int? age,
    @JsonKey(name: 'is_vip') bool? isVip,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'last_login') String? lastLogin,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
