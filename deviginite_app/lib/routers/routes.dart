import 'package:deviginite_app/routers/NamedRoutes.dart';
import 'package:deviginite_app/screens/login_screen.dart';
import 'package:deviginite_app/screens/register_screen.dart';
import 'package:deviginite_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyGoRouter {
  final GoRouter router = GoRouter(routes: [
    GoRoute(
      path: "/",
      name: CommonRoutes.root,
      pageBuilder: (context, state) {
        return MaterialPage(
            child: SplashScreen(
          key: state.pageKey,
        ));
      },
    ),
    GoRoute(
      path: "/root/login",
      name: CommonRoutes.login,
      pageBuilder: (context, state) {
        return MaterialPage(
            child: LoginPage(
          key: state.pageKey,
        ));
      },
    ),
    GoRoute(
      path: "/root/signUp",
      name: CommonRoutes.signUp,
      pageBuilder: (context, state) {
        return MaterialPage(
            child: RegisterPage(
          key: state.pageKey,
        ));
      },
    )
  ]);
}
