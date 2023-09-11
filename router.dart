import 'dart:io';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mysql_app/deep_link_handler.dart';
import 'package:mysql_app/payment/pay_screen.dart';
import 'package:mysql_app/splash_screen.dart';
import 'package:mysql_app/users/authentication/login_screen.dart';
import 'package:mysql_app/users/authentication/signup_screen.dart';
import 'package:mysql_app/users/fragments/dashboard.dart';
import 'package:mysql_app/users/fragments/favorite_screen.dart';
import 'package:mysql_app/users/fragments/home_screen.dart';
import 'package:mysql_app/users/fragments/order_screen.dart';
import 'package:mysql_app/users/fragments/profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';

import 'providers/user_provider.dart';
import 'users/services/user_services.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
// late final BeamerDelegate beamerDelegate;

// void createBeamerDelegate() {
//   beamerDelegate = BeamerDelegate(
//     locationBuilder: RoutesLocationBuilder(
//       routes: {
//         '/splash': (_, __, ___) => const SplashScreen(),
//         '/loginScreen': (_, __, ___) => const LoginScreen(),
//         '/home': (_, __, ___) => const HomeScreen(),
//         '/payScreen': (_, __, ___) => const PayScreen(),
//       },
//     ),
// updateListenable: authenticator,
// guards: [
//   BeamGuard(
//     pathPatterns: ['/splash'],
//     check: (_, __) => authenticator.isLoading,
//     beamToNamed: (_, __, deepLink) =>
//         authenticator.isAuthenticated ? (deepLink ?? '/home') : '/login',
//   ),
//   BeamGuard(
//     pathPatterns: ['/login'],
//     check: (_, __) => authenticator.isNotAuthenticated,
//     beamToNamed: (_, __, deepLink) =>
//         authenticator.isAuthenticated ? (deepLink ?? '/home') : '/splash',
//   ),
//   BeamGuard(
//     pathPatterns: ['/splash', '/login'],
//     guardNonMatching: true,
//     check: (_, __) => authenticator.isAuthenticated,
//     beamToNamed: (_, __, ___) =>
//         authenticator.isNotAuthenticated ? '/login' : '/splash',
//   ),
// ],
// );
// }

// final routerDelegate = BeamerDelegate(
//   // initialPath: '/',
//   locationBuilder: RoutesLocationBuilder(
//     routes: {
//       // Return either Widgets or BeamPages if more customization is needed
//       '/': (context, state, data) => SplashScreen(),
//       '/dashboardScreen': (context, state, data) => DashboardScreen(),
//       '/homeScreen': (context, state, data) => HomeScreen(),
//       '/favoriteScreen': (context, state, data) => FavoriteScreen(),
//       '/profileScreen': (context, state, data) => ProfileScreen(),
//       '/orderScreen': (context, state, data) => OrderScreen(),
//       '/loginScreen': (context, state, data) => LoginScreen(),
//       '/signUpScreen': (context, state, data) => SignUpScreen(),
//       '/payScreen': (context, state, data) => PayScreen(
//             queryData: state.uri.queryParameters,
//           ),
//       // '/books/:bookId': (context, state, data) {
//       //   // Take the path parameter of interest from BeamState
//       //   final bookId = state.pathParameters['bookId']!;
//       //   // Collect arbitrary data that persists throughout navigation
//       //   final info = (data as MyObject).info;
//       //   // Use BeamPage to define custom behavior
//       //   return BeamPage(
//       //     key: ValueKey('book-$bookId'),
//       //     title: 'A Book #$bookId',
//       //     popToNamed: '/',
//       //     type: BeamPageType.scaleTransition,
//       //     child: BookDetailsScreen(bookId, info),
//       //   );
//       // }
//     },
//   ),
// );

class AppRouter {
//   GoRouter(
//   redirect: (context, state) {
//     final isLoggedIn = authRepository.currentUser != null;
//     final path = state.uri.path;
//     // redirect to '/' if the user is signed in and the path is '/signIn'
//     if (isLoggedIn) {
//       if (path == '/signIn') {
//         return '/';
//       }
//     }
//     return null;
//   },
// ),
  static GoRouter router = GoRouter(
    initialLocation: "/",
    // redirect: (context, state) {
    //   // final isLoggedIn = UserServices.userLogin(user, context);
    //   // final isLoggedIn =
    //   //     Provider.of<UserProvider>(context, listen: false).getUser();
    //   final isLoggedIn = UserServices.userLogin != null;
    //   final path = state.uri.path;
    //   // redirect to '/' if the user is signed in and the path is '/signIn'
    //   if (isLoggedIn) {
    //     if (path == '/loginScreen') {
    //       return '/loginScreen';
    //     }
    //   }
    //   return null;
    // },
    // initialLocation: SplashScreen.id,
//     redirect: (context, state) {
//       if (state.uri.path!="/" && state.uri.path!="/splashScreen" ) {
//         print("redirect activated...");
//         print(state.uri.path);
//         print(state.uri.queryParameters);
//         print("redirect activated...end");
// return PayScreen.id;
//       }
//     },
    routes: [
      GoRoute(
        name: "dashboard",
        path: "/dashboardScreen",
        pageBuilder: (context, state) {
          return MaterialPage(child: DashboardScreen());
        },
      ),
      GoRoute(
          name: 'home',
          path: "/homeScreen",
          pageBuilder: (context, state) {
            return const MaterialPage(child: HomeScreen());
          }),
      GoRoute(
          name: "splash",
          path: "/",
          pageBuilder: (context, state) {
            return const MaterialPage(child: SplashScreen());
          }),
      GoRoute(
          name: "favoite",
          path: "/favoriteScreen",
  redirect: (context, state) => _redirect(context),
          pageBuilder: (context, state) {
            return const MaterialPage(child: FavoriteScreen());
          }
          ),
      GoRoute(
          name: "profile",
          path: "/profileScreen",
          pageBuilder: (context, state) {
            return const MaterialPage(child: ProfileScreen());
          }),
      GoRoute(
          name: "order",
          path: "/orderScreen",
          pageBuilder: (context, state) {
            return const MaterialPage(child: OrderScreen());
          }),
      GoRoute(
          name: "login",
          path: "/loginScreen",
          pageBuilder: (context, state) {
            return const MaterialPage(child: LoginScreen());
          }),
      GoRoute(
          name: "signup",
          path: "/signUpScreen",
          pageBuilder: (context, state) {
            return const MaterialPage(child: SignUpScreen());
          }),
      GoRoute(
          name: "payscreen",
          path: "/payScreen",
          pageBuilder: (context, state) {
            return MaterialPage(
                child: PayScreen(
              queryData: state.uri.queryParameters,
            ));
          }),
    ],
  );
   static String? _redirect(BuildContext context) {
   final userProvider =Provider.of<UserProvider>(context, listen: false);
    // int id = Provider.of<UserProvider>(context, listen: false).user!.id!;
    // userProvider!._user == null
    return userProvider.isAuthentificated ? null : context.namedLocation("/loginScreen");
  }
}

// class AppRouter2 {
//   static GoRouter router = GoRouter(
//     initialLocation: SplashScreen.id,
//     routes: [
//       GoRoute(
//           name: "splash",
//           path: SplashScreen.id,
//           builder: (context, state) {
//             return SplashScreen();
//           }),
//       GoRoute(
//           name: "home",
//           path: HomeScreen.id,
//           builder: (context, state) {
//             return HomeScreen();
//           }),
//       GoRoute(
//           name: "favorite",
//           path: FavoriteScreen.id,
//           builder: (context, state) {
//             return FavoriteScreen();
//           }),
//       GoRoute(
//           name: "profile",
//           path: ProfileScreen.id,
//           builder: (context, state) {
//             return ProfileScreen();
//           }),
//       GoRoute(
//           name: "orders",
//           path: OrderScreen.id,
//           builder: (context, state) {
//             return OrderScreen();
//           }),
//       GoRoute(
//           name: "login",
//           path: LoginScreen.id,
//           builder: (context, state) {
//             return LoginScreen();
//           }),
//       GoRoute(
//           name: "signup",
//           path: SignUpScreen.id,
//           builder: (context, state) {
//             return SignUpScreen();
//           }),
//       GoRoute(
//           name: "pay",
//           path: PayScreen.id,
//           builder: (context, state) {
//             return PayScreen();
//           }),
//     ],
//   );
// }
