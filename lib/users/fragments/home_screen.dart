import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mysql_app/providers/user_provider.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  // static const String id="/homeScreen";
    static const routeName = '/homeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserProvider>(
        builder: (context,userProvider,child) {

          int level=userProvider.subs!=null?userProvider.subs!.level:404 ;
          return Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                CircleAvatar(
                 radius: 50,
                  backgroundColor: level!=1?Colors.blue:Colors.orange,
                  child: const Icon(FontAwesomeIcons.star,size: 50,),
                ),
                const SizedBox(height: 20,),
                Text("Your Level is :$level "),
              ],
            ),
          );
        }
      )
    );
  }
}
