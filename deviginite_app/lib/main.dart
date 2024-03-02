import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:deviginite_app/screens/home_screen.dart';
// import 'package:deviginite_app/tabs/dashboard_nav.dart';

import 'routers/routes.dart';
import 'screens/login_screen.dart';
// import 'screens/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.amber),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      getPages: AppRoutes.generateRoutes,
    );
  }
}
