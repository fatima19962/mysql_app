import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mysql_app/providers/user_provider.dart';
import 'package:mysql_app/users/authentication/login_screen.dart';
import 'package:mysql_app/users/fragments/favorite_screen.dart';
import 'package:mysql_app/users/fragments/home_screen.dart';
import 'package:mysql_app/users/fragments/order_screen.dart';
import 'package:mysql_app/users/fragments/profile_screen.dart';
import 'package:mysql_app/users/user_preferences/current_user.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  // static const String id="/dashboardScreen";
  static const routeName = '/dashboardScreen';
  DashboardScreen({Key? key}) : super(key: key);
  final CurrentUser _currentUser = Get.put(CurrentUser());
  final List<Widget> _fragmentScreens = [
    const HomeScreen(),
    const FavoriteScreen(),
    const OrderScreen(),
    ProfileScreen(),
  ];

  final List _navigationButtons = [
    {
      "active_button": Icons.home,
      "non_active_button": Icons.home_outlined,
      "label": "Home",
    },
    {
      "active_button": Icons.favorite,
      "non_active_button": Icons.favorite_outlined,
      "label": "Favorite",
    },
    {
      "active_button": FontAwesomeIcons.boxOpen,
      "non_active_button": FontAwesomeIcons.box,
      "label": "Orders",
    },
    {
      "active_button": Icons.person,
      "non_active_button": Icons.person_outlined,
      "label": "Profile",
    }
  ];
  final RxInt _indexNumber = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("Dashboard"),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: userProvider.user != null
                    ? Text(
                        "Hi ${userProvider.user!.name}",
                        style: TextStyle(
                            color: userProvider.subs == null
                                ? null
                                : Colors.orangeAccent,
                            fontSize: 20),
                      )
                    : ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white70),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black87),
                        ),
                        onPressed: () {
                          // context.pushNamed('/loginScreen');
                          //  context.beamToNamed('/loginScreen');
                            context.go(LoginScreen.routeName);
                        },
                        child: const Text("Login")),
              )
            ],
          ),
          bottomNavigationBar: Obx(() => BottomNavigationBar(
                currentIndex: _indexNumber.value,
                onTap: (val) {
                  _indexNumber.value = val;
                },
                showSelectedLabels: true,
                showUnselectedLabels: true,
                unselectedItemColor: Colors.black38,
                selectedItemColor: Colors.blue,
                items: List.generate(4, (index) {
                  var navBtn = _navigationButtons[index];
                  return BottomNavigationBarItem(
                    label: navBtn["label"],
                    icon: Icon(navBtn["non_active_button"]),
                    activeIcon: Icon(navBtn["active_button"]),
                  );
                }),
              )),
          body:
              SafeArea(child: Obx(() => _fragmentScreens[_indexNumber.value])));
    });
  }
}
