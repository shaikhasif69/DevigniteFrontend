import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class myThemeData {
  myThemeData();
  ThemeMode themeMode = ThemeMode.light;

  void toggleTheme(bool isDark) {
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  ThemeData lightTheme = FlexThemeData.light(
    colors: const FlexSchemeColor(
      primary: Color(0xff19647e),
      primaryContainer: Color(0xffa1cbcf),
      secondary: Color(0xfffeb716),
      secondaryContainer: Color(0xffffdea5),
      tertiary: Color(0xff0093c7),
      tertiaryContainer: Color(0xffc3e7ff),
      appBarColor: Color(0xffffdea5),
      error: Color(0xffb00020),
    ),
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 7,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 10,
      blendOnColors: false,
      useTextTheme: true,
      useM2StyleDividerInM3: true,
      // alignedDropdown: true,
      useInputDecoratorThemeInDialogs: true,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    textTheme: GoogleFonts.latoTextTheme(),
    swapLegacyOnMaterial3: true,
    // To use the Playground font, add GoogleFonts package and uncomment
  );

  ThemeData darkTheme = FlexThemeData.dark(
    colors: const FlexSchemeColor(
      primary: Color(0xff82bace),
      primaryContainer: Color(0xff04666f),
      secondary: Color(0xffffd682),
      secondaryContainer: Color(0xff9e7910),
      tertiary: Color(0xff243e4d),
      tertiaryContainer: Color(0xff426173),
      appBarColor: Color(0xff9e7910),
      error: Color(0xffcf6679),
    ),
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 13,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 20,
      useTextTheme: true,
      useM2StyleDividerInM3: true,
      useInputDecoratorThemeInDialogs: true,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    // To use the Playground font, add GoogleFonts package and uncomment
    // fontFamily: GoogleFonts.notoSans().fontFamily,
  );
}
