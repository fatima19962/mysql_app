import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mysql_app/consts/constants.dart';
import 'package:mysql_app/consts/utilties.dart';
import 'package:mysql_app/models/subscription.dart';
import 'package:mysql_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class PaymentServices {
  saveSubscription(Subscription subs) async {
    try {

      http.Response res = await http.post(
          Uri.parse("$hostUrl/user/create_subscription.php"),
          body: subs.toMap());
      print(res.body);
      if (res.statusCode == 200) {
        print(res.body);
        var backData = jsonDecode(res.body);
        if (backData["success"] == true) {
          Fluttertoast.showToast(msg: "Subscription successfully saved");
        } else {
          Fluttertoast.showToast(msg: "Subscription already exist!");
        }
      }
    } catch (e) {
      print(e);
    }
  }

  readSubscription(context, int id) async {
    try {
      String deviceId=await getDeviceInfo();
      print(deviceId);
      http.Response res = await http.post(
          Uri.parse("$hostUrl/user/read_subscription.php"),
          body: {"user_id": "$id","device_id":deviceId});
      if (res.statusCode == 200) {
        print(res.body);
        var backData = jsonDecode(res.body);
        if (backData["success"] == true) {

          if(backData["isDevice"] == true) {
            Subscription subs = Subscription.fromMap(backData["subsData"]);
            Provider.of<UserProvider>(context, listen: false)
                .setSubscription(subs);
            Fluttertoast.showToast(msg: "Subscription successfully being read!");
          }else{
            Fluttertoast.showToast(msg: "Subscription is not blong to this device");
          }
        } else {
          Fluttertoast.showToast(msg: "not vip");

        }
      }
    } catch (e) {
      print(e);
    }
  }
}
