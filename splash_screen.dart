import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mysql_app/providers/user_provider.dart';
import 'package:mysql_app/users/fragments/dashboard.dart';
import 'package:mysql_app/users/fragments/home_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  // static const String id = "/splashScreen";
  static const routeName = '/';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<UserProvider>(context, listen: false).getUser();
    Provider.of<UserProvider>(context, listen: false).getSubscription();
    Future.delayed(const Duration(milliseconds: 2000), () {
      
                // Navigator.pushNamed(context, DashboardScreen.routeName);
      //GoRouter.of(context).pushReplacementNamed(DashboardScreen.id);
        context.go(DashboardScreen.routeName);
      // context.pushReplacementNamed("/");
      // Beamer.of(context).beamToNamed("/dashboardScreen");
      // GoRouter.of(context).pushReplacementNamed(DashboardScreen.routeName);
      // context.pushReplacementNamed("/dashboardScreen");
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => DashboardScreen(),
      //     ));
      // setState(() {
      //   Navigator.of(context).pop(
      //     MaterialPageRoute(builder: (context) => DashboardScreen()),
      //   );
      // });
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   // Navigator.pushReplacement(
      //   //     context, MaterialPageRoute(builder: (_) => DashboardScreen()));
      //   GoRouter.of(context).pushReplacementNamed('/dashboardScreen');
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: const Center(
          child: Text(
            "Splash Screen",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
      ),
    );
  }
}
