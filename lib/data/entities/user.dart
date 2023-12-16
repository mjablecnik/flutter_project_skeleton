import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class User with _$User {
  const User._();

  const factory User({
    required String firstName,
    required String lastName,
    required String userName,
  }) = _User;

  const factory User.anonymous({
    @Default("Anonymous") String firstName,
    @Default("User") String lastName,
    @Default("anonymous") String userName,
  }) = AnonymousUser;

  String get fullName => "$firstName $lastName";

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
