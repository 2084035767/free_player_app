// user.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'device_id') required String deviceId,
    @JsonKey(name: 'username') required String username,
    @JsonKey(name: 'nickname') String? nickname,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'avatar') String? avatar,
    @JsonKey(name: 'is_vip') bool? isVip,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'watch_history') List<String>? watchHistory,
    @JsonKey(name: 'favorites') List<String>? favorites,
    @JsonKey(name: 'watch_later') List<String>? watchLater,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}