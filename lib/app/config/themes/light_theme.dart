import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appLightTheme = FlexThemeData.light(
  scheme: FlexScheme.green,
  fontFamily: GoogleFonts.notoSans().fontFamily,
  usedColors: 6,
  subThemesData: const FlexSubThemesData(
    blendOnColors: false,
    useTextTheme: true,
    defaultRadius: 8.0,
    useInputDecoratorThemeInDialogs: true,
    buttonPadding: EdgeInsets.all(12),
    appBarCenterTitle: true,
    cardElevation: 4,
    cardRadius: 12,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3ErrorColors: true,
  useMaterial3: true,
  swapLegacyOnMaterial3: true,
);
