import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mysql_app/deep_link_handler.dart';
import 'package:mysql_app/providers/user_provider.dart';
import 'package:mysql_app/router.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
 setPathUrlStrategy();

  WidgetsFlutterBinding.ensureInitialized();
  // To turn off landscape mode
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  await Hive.initFlutter();

  ///Hive Adaptors
  //Hive.registerAdapter(adapter);
  ///create box for store data
  //await Hive.openBox<Name>("name");
  runApp( const MyApp(),);
 DeepLinkHandler.handler();
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        ChangeNotifierProvider(create: (context)=>UserProvider()),
    ],
    child:MaterialApp.router(
        title: 'mysql app',
        debugShowCheckedModeBanner: false,
      routerConfig:AppRouter.router ,



    //   initialRoute:SplashScreen.id ,
    // routes:{
    //       LoginScreen.id:(BuildContext context)=>const LoginScreen(),
    //       SignUpScreen.id:(BuildContext context)=>const SignUpScreen(),
    //       PayScreen.id:(BuildContext context)=>const PayScreen(),
    //       ProfileScreen.id:(BuildContext context)=> const ProfileScreen(),
    //       DashboardScreen.id:(BuildContext context)=> DashboardScreen(),
    //       SplashScreen.id:(BuildContext context)=> const SplashScreen(),
    // }
    ));
  }
}
