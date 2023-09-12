
import 'dart:convert';

import 'package:mysql_app/consts/constants.dart';
import 'package:mysql_app/consts/utilties.dart';
import 'package:mysql_app/models/user.dart';

class Subscription {

  final int id;
  final User? user;
  final int level;
  final DateTime startDate;
  final String description;
  final double payAmount;
  final String refId;
  final String? phoneNumber;
  final String? email;
  final String? deviceId;

  const Subscription( {
    required this.id,
    this.user,
    required this.level,
    required this.startDate,
    required this.description,
    required this.payAmount,
    required this.refId,
    this.phoneNumber,
    this.email,
    this.deviceId,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id':id.toString(),
      'user':user!=null? user!.toJson():null,
      'level': level.toString(),
      'start_date': startDate.toIso8601String(),
      'description': description,
      'pay_amount': payAmount.toString(),
      'ref_id': refId,
      'phone_number': phoneNumber,
      'email': email,
      'device_id':deviceId
    };
  }

  factory Subscription.fromMap(Map<String, dynamic> map) {
    return Subscription(
      id: stringToDouble(map['user_id']?? "0").toInt() ,
      user:User.fromJson(map['user_info'] ?? userGuest.toJson()),
      level: stringToDouble(map['level'] ?? "0").toInt() ,
      startDate: DateTime.parse(map['start_date'] ?? DateTime.now().toIso8601String()),
      description: map['description'] ?? "",
      payAmount: stringToDouble(map['pay_amount']?? "0") ,
      refId: map['ref_id'] ?? "",
      phoneNumber: map['phone_number'] ?? "",
      email: map['email'] ?? "",
      deviceId:  map['device_id']
    );
  }
  String toJson() => jsonEncode(toMap());

  factory Subscription.fromJson(String source) => Subscription.fromMap(
    jsonDecode(source),
  );
}