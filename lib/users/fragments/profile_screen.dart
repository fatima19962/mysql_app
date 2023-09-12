import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:mysql_app/components/custom_button.dart';
import 'package:mysql_app/consts/constants.dart';
import 'package:mysql_app/consts/utilties.dart';
import 'package:mysql_app/models/subscription.dart';
import 'package:mysql_app/models/user.dart';
import 'package:mysql_app/payment/payment_services.dart';
import 'package:mysql_app/providers/user_provider.dart';
import 'package:mysql_app/users/authentication/login_screen.dart';
import 'package:mysql_app/users/fragments/dashboard.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zarinpal/zarinpal.dart';

class ProfileScreen extends StatefulWidget {
  // static const String id = "/profileScreen";
  static const routeName = '/profileScreen';
  const ProfileScreen({Key? key, this.queryData}) : super(key: key);
  final Map? queryData;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  PaymentRequest paymentRequest = PaymentRequest();
  PaymentServices paymentServices = PaymentServices();

  payOptions(PaymentRequest paymentRequest) {
    int id = Provider.of<UserProvider>(context, listen: false).user!.id!;
    paymentRequest
      ..setIsSandBox(true)
      ..setAmount(1000)
      ..setDescription("description")
      ..setMerchantID("332f20e0-3333-41ce-b15d-aff7476a92ba")
      ..setCallbackURL("https://mlggrand2.ir/#/payScreen?user_id=$id");

    ZarinPal().startPayment(paymentRequest, (status, paymentGatewayUri) {
      print("work till here$status");
      if (status == 100) {
        launchUrl(Uri.parse(paymentGatewayUri!),
            mode: LaunchMode.externalApplication);
      } else {
        Fluttertoast.showToast(
          msg: "error $status on the payment ",
        );
      }
    });
  }

  subscriptionPayment(context, User? user, PaymentRequest paymentRequest,
      PaymentServices paymentServices) async {
    String deviceId = await getDeviceInfo();
    StreamSubscription subscription = linkStream.listen((link) {
      if (link != null) {
        if (link.toLowerCase().contains('status')) {
          String status = link.split("=").last.toString();
          String authority =
              link.split("&")[0].split("?")[1].split("=")[1].toString();

          ZarinPal().verificationPayment(status, authority, paymentRequest,
              (isPaymentSuccess, refID, paymentRequest) {
            if (isPaymentSuccess) {
              Subscription subscription = Subscription(
                id: user!.id!.toInt(),
                user: user,
                level: 1,
                startDate: DateTime.now(),
                description: paymentRequest.description ?? "",
                payAmount: paymentRequest.amount!.toDouble(),
                refId: refID!,
                phoneNumber: user.phoneNumber!,
                email: user.email,
                deviceId: deviceId,
              );
              Provider.of<UserProvider>(context, listen: false)
                  .setSubscription(subscription);
              paymentServices.saveSubscription(subscription);
              Provider.of<UserProvider>(context, listen: false).levelUpUser();
              setState(() {});
            }
          });
        }
      }
    });
  }

  testDeepLink() {}
  @override
  void initState() {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    //subscriptionPayment(context,user,paymentRequest,paymentServices);
    super.initState();
  }

  Widget userInfoItemProfile(IconData icon, String userData) {
    return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blueAccent.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          child: Row(
            children: [
              Icon(icon),
              const SizedBox(
                width: 15,
              ),
              Text(
                userData,
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      body: Consumer<UserProvider>(builder: (context, userProvider, child) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),

          ///condition if user not login ,show button login
          child: userProvider.user == null
              ? SizedBox(
                  height: 20,
                  child: Center(
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white70),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black87),
                        ),
                        onPressed: () {
                          // GoRouter.of(context).pushNamed(LoginScreen);
                          // Beamer.of(context).beamToNamed("/loginScreen");
                          // GoRouter.of(context).pushNamed("/loginScreen");
                          context.go(LoginScreen.routeName);
                        },
                        child: const Text("Login")),
                  ),
                )
              : ListView(
                  children: [
                    userInfoItemProfile(Icons.person, userProvider.user!.name),
                    const SizedBox(
                      height: 20,
                    ),
                    userInfoItemProfile(
                        Icons.person,
                        userProvider.subs == null
                            ? "non"
                            : userProvider.subs!.level.toString()),
                    const SizedBox(
                      height: 20,
                    ),
                    userInfoItemProfile(Icons.email, userProvider.user!.email),
                    const SizedBox(
                      height: 20,
                    ),

                    ///get plan purchases
                    if (userProvider.subs == null)
                      Container(
                        padding: const EdgeInsets.all(30),
                        margin: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.orange),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(
                              "Buy infinity plan!",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomButton(
                              color: Colors.orangeAccent.withBlue(130),
                              text: "Purchase",
                              onPressed: () {
                                payOptions(paymentRequest);
                              },
                            ),
                          ],
                        ),
                      )
                    else
                      const SizedBox(),
                    const SizedBox(
                      height: 40,
                    ),

                    SizedBox(
                      width: 100,
                      child: userProvider.user == null
                          ? null
                          : CustomButton(
                              color: Colors.red,
                              text: "Sign out",
                              onPressed: () {
                                Provider.of<UserProvider>(context,
                                        listen: false)
                                    .removeUser();
                                // GoRouter.of(context).pushNamed(DashboardScreen.id);
                                // Beamer.of(context)
                                //     .beamToNamed("/dashboardScreen");
                                // GoRouter.of(context)
                                //     .pushNamed('/dashboardScreen');
                                context.go(DashboardScreen.routeName);
                              },
                            ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),

                    ///test button
                    CustomButton(
                      color: Colors.orangeAccent.withBlue(130),
                      text: "test subs",
                      onPressed: () {
                        PaymentServices pay = PaymentServices();
                        // pay.readSubscription(context,750);
                        Subscription subs = Subscription(
                            id: 700,
                            deviceId: "test002",
                            user: userGuest,
                            level: 1,
                            startDate: DateTime.now(),
                            description: "description",
                            payAmount: 5400,
                            refId: "5989248",
                            phoneNumber: "phoneNumber",
                            email: "email");
                        //pay.saveSubscription(subs);
                        payOptions(paymentRequest);
                      },
                    ),
                  ],
                ),
        );
      }),
    );
  }
}
