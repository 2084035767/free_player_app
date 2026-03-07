// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$User {

@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'device_id') String get deviceId;@JsonKey(name: 'username') String get username;@JsonKey(name: 'nickname') String? get nickname;@JsonKey(name: 'email') String? get email;@JsonKey(name: 'avatar') String? get avatar;@JsonKey(name: 'is_vip') bool? get isVip;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'watch_history') List<String>? get watchHistory;@JsonKey(name: 'favorites') List<String>? get favorites;@JsonKey(name: 'watch_later') List<String>? get watchLater;
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCopyWith<User> get copyWith => _$UserCopyWithImpl<User>(this as User, _$identity);

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is User&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.username, username) || other.username == username)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.email, email) || other.email == email)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.isVip, isVip) || other.isVip == isVip)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.watchHistory, watchHistory)&&const DeepCollectionEquality().equals(other.favorites, favorites)&&const DeepCollectionEquality().equals(other.watchLater, watchLater));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,deviceId,username,nickname,email,avatar,isVip,createdAt,const DeepCollectionEquality().hash(watchHistory),const DeepCollectionEquality().hash(favorites),const DeepCollectionEquality().hash(watchLater));

@override
String toString() {
  return 'User(userId: $userId, deviceId: $deviceId, username: $username, nickname: $nickname, email: $email, avatar: $avatar, isVip: $isVip, createdAt: $createdAt, watchHistory: $watchHistory, favorites: $favorites, watchLater: $watchLater)';
}


}

/// @nodoc
abstract mixin class $UserCopyWith<$Res>  {
  factory $UserCopyWith(User value, $Res Function(User) _then) = _$UserCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'device_id') String deviceId,@JsonKey(name: 'username') String username,@JsonKey(name: 'nickname') String? nickname,@JsonKey(name: 'email') String? email,@JsonKey(name: 'avatar') String? avatar,@JsonKey(name: 'is_vip') bool? isVip,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'watch_history') List<String>? watchHistory,@JsonKey(name: 'favorites') List<String>? favorites,@JsonKey(name: 'watch_later') List<String>? watchLater
});




}
/// @nodoc
class _$UserCopyWithImpl<$Res>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? deviceId = null,Object? username = null,Object? nickname = freezed,Object? email = freezed,Object? avatar = freezed,Object? isVip = freezed,Object? createdAt = freezed,Object? watchHistory = freezed,Object? favorites = freezed,Object? watchLater = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,nickname: freezed == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,isVip: freezed == isVip ? _self.isVip : isVip // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,watchHistory: freezed == watchHistory ? _self.watchHistory : watchHistory // ignore: cast_nullable_to_non_nullable
as List<String>?,favorites: freezed == favorites ? _self.favorites : favorites // ignore: cast_nullable_to_non_nullable
as List<String>?,watchLater: freezed == watchLater ? _self.watchLater : watchLater // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [User].
extension UserPatterns on User {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _User value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _User value)  $default,){
final _that = this;
switch (_that) {
case _User():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _User value)?  $default,){
final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'device_id')  String deviceId, @JsonKey(name: 'username')  String username, @JsonKey(name: 'nickname')  String? nickname, @JsonKey(name: 'email')  String? email, @JsonKey(name: 'avatar')  String? avatar, @JsonKey(name: 'is_vip')  bool? isVip, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'watch_history')  List<String>? watchHistory, @JsonKey(name: 'favorites')  List<String>? favorites, @JsonKey(name: 'watch_later')  List<String>? watchLater)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.userId,_that.deviceId,_that.username,_that.nickname,_that.email,_that.avatar,_that.isVip,_that.createdAt,_that.watchHistory,_that.favorites,_that.watchLater);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'device_id')  String deviceId, @JsonKey(name: 'username')  String username, @JsonKey(name: 'nickname')  String? nickname, @JsonKey(name: 'email')  String? email, @JsonKey(name: 'avatar')  String? avatar, @JsonKey(name: 'is_vip')  bool? isVip, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'watch_history')  List<String>? watchHistory, @JsonKey(name: 'favorites')  List<String>? favorites, @JsonKey(name: 'watch_later')  List<String>? watchLater)  $default,) {final _that = this;
switch (_that) {
case _User():
return $default(_that.userId,_that.deviceId,_that.username,_that.nickname,_that.email,_that.avatar,_that.isVip,_that.createdAt,_that.watchHistory,_that.favorites,_that.watchLater);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'device_id')  String deviceId, @JsonKey(name: 'username')  String username, @JsonKey(name: 'nickname')  String? nickname, @JsonKey(name: 'email')  String? email, @JsonKey(name: 'avatar')  String? avatar, @JsonKey(name: 'is_vip')  bool? isVip, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'watch_history')  List<String>? watchHistory, @JsonKey(name: 'favorites')  List<String>? favorites, @JsonKey(name: 'watch_later')  List<String>? watchLater)?  $default,) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.userId,_that.deviceId,_that.username,_that.nickname,_that.email,_that.avatar,_that.isVip,_that.createdAt,_that.watchHistory,_that.favorites,_that.watchLater);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _User implements User {
  const _User({@JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'device_id') required this.deviceId, @JsonKey(name: 'username') required this.username, @JsonKey(name: 'nickname') this.nickname, @JsonKey(name: 'email') this.email, @JsonKey(name: 'avatar') this.avatar, @JsonKey(name: 'is_vip') this.isVip, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'watch_history') final  List<String>? watchHistory, @JsonKey(name: 'favorites') final  List<String>? favorites, @JsonKey(name: 'watch_later') final  List<String>? watchLater}): _watchHistory = watchHistory,_favorites = favorites,_watchLater = watchLater;
  factory _User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'device_id') final  String deviceId;
@override@JsonKey(name: 'username') final  String username;
@override@JsonKey(name: 'nickname') final  String? nickname;
@override@JsonKey(name: 'email') final  String? email;
@override@JsonKey(name: 'avatar') final  String? avatar;
@override@JsonKey(name: 'is_vip') final  bool? isVip;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
 final  List<String>? _watchHistory;
@override@JsonKey(name: 'watch_history') List<String>? get watchHistory {
  final value = _watchHistory;
  if (value == null) return null;
  if (_watchHistory is EqualUnmodifiableListView) return _watchHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _favorites;
@override@JsonKey(name: 'favorites') List<String>? get favorites {
  final value = _favorites;
  if (value == null) return null;
  if (_favorites is EqualUnmodifiableListView) return _favorites;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _watchLater;
@override@JsonKey(name: 'watch_later') List<String>? get watchLater {
  final value = _watchLater;
  if (value == null) return null;
  if (_watchLater is EqualUnmodifiableListView) return _watchLater;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCopyWith<_User> get copyWith => __$UserCopyWithImpl<_User>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _User&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.username, username) || other.username == username)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.email, email) || other.email == email)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.isVip, isVip) || other.isVip == isVip)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._watchHistory, _watchHistory)&&const DeepCollectionEquality().equals(other._favorites, _favorites)&&const DeepCollectionEquality().equals(other._watchLater, _watchLater));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,deviceId,username,nickname,email,avatar,isVip,createdAt,const DeepCollectionEquality().hash(_watchHistory),const DeepCollectionEquality().hash(_favorites),const DeepCollectionEquality().hash(_watchLater));

@override
String toString() {
  return 'User(userId: $userId, deviceId: $deviceId, username: $username, nickname: $nickname, email: $email, avatar: $avatar, isVip: $isVip, createdAt: $createdAt, watchHistory: $watchHistory, favorites: $favorites, watchLater: $watchLater)';
}


}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) = __$UserCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'device_id') String deviceId,@JsonKey(name: 'username') String username,@JsonKey(name: 'nickname') String? nickname,@JsonKey(name: 'email') String? email,@JsonKey(name: 'avatar') String? avatar,@JsonKey(name: 'is_vip') bool? isVip,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'watch_history') List<String>? watchHistory,@JsonKey(name: 'favorites') List<String>? favorites,@JsonKey(name: 'watch_later') List<String>? watchLater
});




}
/// @nodoc
class __$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? deviceId = null,Object? username = null,Object? nickname = freezed,Object? email = freezed,Object? avatar = freezed,Object? isVip = freezed,Object? createdAt = freezed,Object? watchHistory = freezed,Object? favorites = freezed,Object? watchLater = freezed,}) {
  return _then(_User(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,nickname: freezed == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,isVip: freezed == isVip ? _self.isVip : isVip // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,watchHistory: freezed == watchHistory ? _self._watchHistory : watchHistory // ignore: cast_nullable_to_non_nullable
as List<String>?,favorites: freezed == favorites ? _self._favorites : favorites // ignore: cast_nullable_to_non_nullable
as List<String>?,watchLater: freezed == watchLater ? _self._watchLater : watchLater // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

// dart format on
