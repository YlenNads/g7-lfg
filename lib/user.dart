import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
part 'user.g.dart';


@JsonSerializable()

class User extends Object with _$UserSerializerMixin{

  User(this.name, this.email,this.pw,this.objectID);

  String name;
  String email;
  String pw;
  String objectID;

  factory User.fromJson(Map<String,dynamic> json)=> _$UserFromJson(json);
// @JsonKey(name: 'registration_date_millis')
//final int registrationDateMillis;


}
