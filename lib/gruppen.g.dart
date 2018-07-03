// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gruppen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Gruppen _$GruppenFromJson(Map<String, dynamic> json) =>
    new Gruppen(json['name'] as String, json['maximalzahl'] as String)
      ..members = json['members'] as String
      ..objectID = json['objectID'] as String;

abstract class _$GruppenSerializerMixin {
  String get name;
  String get maximalzahl;
  String get members;
  String get objectID;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'maximalzahl': maximalzahl,
        'members': members,
        'objectID': objectID
      };
}
