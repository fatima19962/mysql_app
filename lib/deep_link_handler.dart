import 'dart:async';

import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:mysql_app/payment/pay_screen.dart';
import 'package:mysql_app/router.dart';
import 'package:uni_links/uni_links.dart';
import 'package:zarinpal/zarinpal.dart';

class DeepLinkHandler {
  static handler() {
    StreamSubscription subscription = linkStream.listen((String? link) {
      String recievedLink = '';
      recievedLink = link!;
      Map VIPPays = {};
      if (link != null && recievedLink.toLowerCase().contains('status')) {
        String status = recievedLink.split("=").last;
        String authority =
            recievedLink.split('?')[1].split('&')[0].split('=')[1];
        PaymentRequest paymentRequest = PaymentRequest();
        // String fullPath = link.split("https://mlggrand2.ir/#").last;
        // String route = fullPath.split("?").first;
        // Map<String, dynamic> params =
        //     Uri.splitQueryString(fullPath.split("?").last);
        ZarinPal().verificationPayment(status, authority, paymentRequest,
            (isPaymentSuccess, refID, paymentRequest) async {
          if (isPaymentSuccess) {
            Box box = await Hive.openBox('vip');
            box.put(VIPPays[authority], true);

            debugPrint('Success');
          } else {
            debugPrint('error');
          }
        });
        // AppRouter.router.goNamed("/payScreen", queryParameters: params);
        // AppRouter.router.goNamed(PayScreen.id, queryParameters: params);
        // routerDelegate.beamToNamed(data:PayScreen,"https://mlggrand2.ir/#");
        // routerDelegate.beamToNamed(data: params, "/profileScreen");
        print("my config...");
        // print(params);
        // print(route);
      }
    }, onError: (err) {
      debugPrint(err);
    });
  }
}
