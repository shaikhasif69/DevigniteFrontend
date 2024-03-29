import 'dart:async';

import 'package:deviginite_app/routers/NamedRoutes.dart';
import 'package:deviginite_app/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    showIntro();
  }

  void showIntro() {
    Timer(const Duration(seconds: 3), () async {
      // Shared preferences should be used here
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      bool? isLoggedIn = prefs.getBool("isLoggedIn");
      print("this is the is logged ins:");
      print(isLoggedIn);

      if (isLoggedIn != null) {
        if (isLoggedIn) {
          print("it is logged in!");
          GoRouter.of(context)
              .pushReplacementNamed(StudentsRoutes.blindHomepage);
          ;
        } else {
          print("the else is working!");
        }
      } else {
        print("hey there it's the else !");
        GoRouter.of(context).pushReplacementNamed(CommonRoutes.signUp);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        body: Container(
          margin: const EdgeInsets.only(top: 10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/ghanoliAppLogo.png",
                  height: 300,
                ),
                const SizedBox(
                  height: 25,
                ),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 54,
                        fontWeight: FontWeight.w500,
                        letterSpacing: .5,
                      ),
                    ),
                    children: const [
                      TextSpan(
                          text: 'We Win ',
                          style: TextStyle(color: Colors.white)),
                      TextSpan(
                        text: 'For SURE!',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  textScaleFactor: 0.5,
                )
              ],
            ),
          ),
        ));
  }
}
