import 'dart:convert';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:mysql_app/consts/constants.dart';
import 'package:mysql_app/models/user.dart';
import 'package:mysql_app/payment/payment_services.dart';
import 'package:mysql_app/providers/user_provider.dart';
import 'package:mysql_app/router.dart';
import 'package:mysql_app/users/fragments/dashboard.dart';
import 'package:mysql_app/users/fragments/home_screen.dart';
import 'package:provider/provider.dart';

import '../fragments/profile_screen.dart';

class UserServices {
  ///validate Email
  static Future validateUserEmail(String email) async {
    try {
      var client = http.Client();
      http.Response res = await client
          .post(Uri.parse("$hostUrl/user/validate_email.php"), body: {
        'user_email': email.trim(),
      });

      if (res.statusCode == 200) {
        var resVal = jsonDecode(res.body);
        if (resVal['exists'] == true) {
          Fluttertoast.showToast(msg: "this Email already exists!");
          return false;
        } else {
          return true;
        }
      }
    } catch (e) {
      print("validateUserEmail() function error...$e");
    }
  }

  /// function for register user
  static registerUser(User user, context) async {
    try {
      bool isEmailValidate = await validateUserEmail(user.email);
      if (isEmailValidate) {
        var client = http.Client();
        http.Response res = await client
            .post(Uri.parse("$hostUrl/user/signup.php"), body: user.toMap());
        if (res.statusCode == 200) {
          print(res.body);
          var resOfSignUp = jsonDecode(res.body);
          if (resOfSignUp['success'] == true) {
            User userInfo = User.fromMap((resOfSignUp['userData']));
            Fluttertoast.showToast(msg: "User successfully registered!");

            Provider.of<UserProvider>(context, listen: false).setUser(userInfo);
            final userProvider =
                Provider.of<UserProvider>(context, listen: false);
            userProvider.isAuthentificated = true;
            // Navigator.popAndPushNamed(context, DashboardScreen.id);
            // Beamer.of(context).beamToReplacementNamed("/dashboardScreen");
            // Navigator.popAndPushNamed(context, '/dashboardScreen');
            GoRouter.of(context).go(DashboardScreen.routeName);
          } else {
            Fluttertoast.showToast(msg: "Error Occurred,try Again! ");
          }
        }
      }
    } catch (e) {
      print("sign up error...$e");
      Fluttertoast.showToast(msg: "registerUser function error!");
    }
  }

  ///function for to login user
  static userLogin(User user, context) async {
    try {
      PaymentServices paymentServices = PaymentServices();

      var client = http.Client();
      http.Response res =
          await client.post(Uri.parse("$hostUrl/user/login.php"),
              headers: {
                "Access-Control-Allow-Origin": "*",
                "Access-Control-Allow-Credentials": "true",
                "Access-Control-Allow-Headers":
                    "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale,X-Requested-With,content-type",
                "Access-Control-Allow-Methods": "POST, OPTIONS,PUT,GET"
              },
              body: user.toMap());
      if (res.statusCode == 200) {
        var resOfLogin = jsonDecode(res.body);

        if (resOfLogin['success'] == true) {
          User userInfo = User.fromMap((resOfLogin['userData']));
          final userProvider =
              Provider.of<UserProvider>(context, listen: false);
          Fluttertoast.showToast(msg: "User successfully logged in!");
          print("user id is${userInfo.id!}");
          Provider.of<UserProvider>(context, listen: false).setUser(userInfo);
          await paymentServices.readSubscription(context, userInfo.id!);
          userProvider.isAuthentificated = true;
          Future.delayed(const Duration(milliseconds: 2000));
          // context.push(ProfileScreen.routeName);
          // Navigator.pushReplacementNamed(context, ProfileScreen.routeName);
          // navigator!.push<void>(
          //   MaterialPageRoute<void>(
          //     builder: (BuildContext context) => const ProfileScreen(),
          //   ),
          // );
          // context.go(ProfileScreen);
          GoRouter.of(context).go(DashboardScreen.routeName);
          if (context.mounted) {
            Navigator.pop(context, false);
          }
        } else {
          Fluttertoast.showToast(
            msg: "email or password is not correct! ",
          );
        }
      }
    } catch (e) {
      print("login error...$e");
      Fluttertoast.showToast(
          msg: "userLogin function error!", backgroundColor: Colors.red);
    }
  }
}
