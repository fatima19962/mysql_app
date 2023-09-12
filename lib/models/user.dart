import 'dart:convert';

import 'package:mysql_app/consts/utilties.dart';

class User {
  final String name;
  final String email;
  final String pass;
  final String? phoneNumber;
  final int level;
  final int? id;

  const User({
    required this.name,
    required this.email,
    required this.pass,
    this.phoneNumber="",
    this.level = 0,
    this.id = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': id.toString(),
      'display_name': name,
      'user_email': email,
      'user_pass': pass,
      'phone_number':phoneNumber,
      'level':level.toString(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['display_name'] ?? "",
      email: map['user_email'] ?? "",
      pass: map['user_pass'] ?? "",
      //when we return the data id field name is like blow example
      id: stringToDouble(map['ID'] ?? "0").toInt(),
      phoneNumber: map['phone_number'] ?? "",
      level: stringToDouble(map['level'] ?? "0").toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(
        json.decode(source),
      );


}
