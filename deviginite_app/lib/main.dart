import 'package:deviginite_app/ThemeData/ThemeData.dart';
import 'package:deviginite_app/routers/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ProviderScope(child: MyApp()));
}

myThemeData themeData = myThemeData();
final route = MyGoRouter();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    return MaterialApp.router(
      routeInformationParser: route.router.routeInformationParser,
      routeInformationProvider: route.router.routeInformationProvider,
      routerDelegate: route.router.routerDelegate,
      theme: themeData.lightTheme,
      darkTheme: themeData.darkTheme,
      themeMode: themeData.themeMode,
    );
  }
}
