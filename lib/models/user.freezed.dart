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

@JsonKey(name: 'id') int get id;@JsonKey(name: 'username') String get username;@JsonKey(name: 'nickname') String? get nickname;@JsonKey(name: 'email') String? get email;@JsonKey(name: 'avatar') String? get avatar;@JsonKey(name: 'phone') String? get phone;@JsonKey(name: 'gender') int? get gender;// 0: 未知, 1: 男, 2: 女
@JsonKey(name: 'age') int? get age;@JsonKey(name: 'is_vip') bool? get isVip;@JsonKey(name: 'created_at') String? get createdAt;@JsonKey(name: 'last_login') String? get lastLogin;
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCopyWith<User> get copyWith => _$UserCopyWithImpl<User>(this as User, _$identity);

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is User&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.email, email) || other.email == email)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.age, age) || other.age == age)&&(identical(other.isVip, isVip) || other.isVip == isVip)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastLogin, lastLogin) || other.lastLogin == lastLogin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,nickname,email,avatar,phone,gender,age,isVip,createdAt,lastLogin);

@override
String toString() {
  return 'User(id: $id, username: $username, nickname: $nickname, email: $email, avatar: $avatar, phone: $phone, gender: $gender, age: $age, isVip: $isVip, createdAt: $createdAt, lastLogin: $lastLogin)';
}


}

/// @nodoc
abstract mixin class $UserCopyWith<$Res>  {
  factory $UserCopyWith(User value, $Res Function(User) _then) = _$UserCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') int id,@JsonKey(name: 'username') String username,@JsonKey(name: 'nickname') String? nickname,@JsonKey(name: 'email') String? email,@JsonKey(name: 'avatar') String? avatar,@JsonKey(name: 'phone') String? phone,@JsonKey(name: 'gender') int? gender,@JsonKey(name: 'age') int? age,@JsonKey(name: 'is_vip') bool? isVip,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'last_login') String? lastLogin
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? nickname = freezed,Object? email = freezed,Object? avatar = freezed,Object? phone = freezed,Object? gender = freezed,Object? age = freezed,Object? isVip = freezed,Object? createdAt = freezed,Object? lastLogin = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,nickname: freezed == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as int?,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,isVip: freezed == isVip ? _self.isVip : isVip // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,lastLogin: freezed == lastLogin ? _self.lastLogin : lastLogin // ignore: cast_nullable_to_non_nullable
as String?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'username')  String username, @JsonKey(name: 'nickname')  String? nickname, @JsonKey(name: 'email')  String? email, @JsonKey(name: 'avatar')  String? avatar, @JsonKey(name: 'phone')  String? phone, @JsonKey(name: 'gender')  int? gender, @JsonKey(name: 'age')  int? age, @JsonKey(name: 'is_vip')  bool? isVip, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'last_login')  String? lastLogin)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.id,_that.username,_that.nickname,_that.email,_that.avatar,_that.phone,_that.gender,_that.age,_that.isVip,_that.createdAt,_that.lastLogin);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'username')  String username, @JsonKey(name: 'nickname')  String? nickname, @JsonKey(name: 'email')  String? email, @JsonKey(name: 'avatar')  String? avatar, @JsonKey(name: 'phone')  String? phone, @JsonKey(name: 'gender')  int? gender, @JsonKey(name: 'age')  int? age, @JsonKey(name: 'is_vip')  bool? isVip, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'last_login')  String? lastLogin)  $default,) {final _that = this;
switch (_that) {
case _User():
return $default(_that.id,_that.username,_that.nickname,_that.email,_that.avatar,_that.phone,_that.gender,_that.age,_that.isVip,_that.createdAt,_that.lastLogin);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'username')  String username, @JsonKey(name: 'nickname')  String? nickname, @JsonKey(name: 'email')  String? email, @JsonKey(name: 'avatar')  String? avatar, @JsonKey(name: 'phone')  String? phone, @JsonKey(name: 'gender')  int? gender, @JsonKey(name: 'age')  int? age, @JsonKey(name: 'is_vip')  bool? isVip, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'last_login')  String? lastLogin)?  $default,) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.id,_that.username,_that.nickname,_that.email,_that.avatar,_that.phone,_that.gender,_that.age,_that.isVip,_that.createdAt,_that.lastLogin);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _User implements User {
  const _User({@JsonKey(name: 'id') required this.id, @JsonKey(name: 'username') required this.username, @JsonKey(name: 'nickname') this.nickname, @JsonKey(name: 'email') this.email, @JsonKey(name: 'avatar') this.avatar, @JsonKey(name: 'phone') this.phone, @JsonKey(name: 'gender') this.gender, @JsonKey(name: 'age') this.age, @JsonKey(name: 'is_vip') this.isVip, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'last_login') this.lastLogin});
  factory _User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

@override@JsonKey(name: 'id') final  int id;
@override@JsonKey(name: 'username') final  String username;
@override@JsonKey(name: 'nickname') final  String? nickname;
@override@JsonKey(name: 'email') final  String? email;
@override@JsonKey(name: 'avatar') final  String? avatar;
@override@JsonKey(name: 'phone') final  String? phone;
@override@JsonKey(name: 'gender') final  int? gender;
// 0: 未知, 1: 男, 2: 女
@override@JsonKey(name: 'age') final  int? age;
@override@JsonKey(name: 'is_vip') final  bool? isVip;
@override@JsonKey(name: 'created_at') final  String? createdAt;
@override@JsonKey(name: 'last_login') final  String? lastLogin;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _User&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.email, email) || other.email == email)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.age, age) || other.age == age)&&(identical(other.isVip, isVip) || other.isVip == isVip)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastLogin, lastLogin) || other.lastLogin == lastLogin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,nickname,email,avatar,phone,gender,age,isVip,createdAt,lastLogin);

@override
String toString() {
  return 'User(id: $id, username: $username, nickname: $nickname, email: $email, avatar: $avatar, phone: $phone, gender: $gender, age: $age, isVip: $isVip, createdAt: $createdAt, lastLogin: $lastLogin)';
}


}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) = __$UserCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') int id,@JsonKey(name: 'username') String username,@JsonKey(name: 'nickname') String? nickname,@JsonKey(name: 'email') String? email,@JsonKey(name: 'avatar') String? avatar,@JsonKey(name: 'phone') String? phone,@JsonKey(name: 'gender') int? gender,@JsonKey(name: 'age') int? age,@JsonKey(name: 'is_vip') bool? isVip,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'last_login') String? lastLogin
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? username = null,Object? nickname = freezed,Object? email = freezed,Object? avatar = freezed,Object? phone = freezed,Object? gender = freezed,Object? age = freezed,Object? isVip = freezed,Object? createdAt = freezed,Object? lastLogin = freezed,}) {
  return _then(_User(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,nickname: freezed == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as int?,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,isVip: freezed == isVip ? _self.isVip : isVip // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,lastLogin: freezed == lastLogin ? _self.lastLogin : lastLogin // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
