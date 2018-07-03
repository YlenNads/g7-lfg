// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => new User(
    json['name'] as String,
    json['email'] as String,
    json['pw'] as String,
    json['objectID'] as String);

abstract class _$UserSerializerMixin {
  String get name;
  String get email;
  String get pw;
  String get objectID;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'email': email,
        'pw': pw,
        'objectID': objectID
      };
}
