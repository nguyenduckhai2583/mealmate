import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:triller/app/constants/constants.dart';
import 'package:triller/app/config/config.dart';

AppColorsExtension lightThemeColor = const AppColorsExtension(
  textColor: Color(0xff333333),
  textColorSecondary: Color(0xffB3B3B3),
  weakColor: Color(0xff999999),
  lightColor: Color(0xffCCCCCC),
  borderColor: Color(0xffEEEEEE),
  backgroundColor: Color(0xffFFFFFF),
  boxColor: Color(0xffF5F5F5),
  white: Color(0xffFFFFFF),
  black: Color(0xff000000),
  success: Color(0xff00B578),
  warning: Color(0xffFF8F1F),
  badge: Color(0xffFF411C),
  darkTextColor: Color(0xffE6E6E6),
  darkTextColorSecondary: Color(0xffB3B3B3),
  darkWeakColor: Color(0xff808080),
  darkLightColor: Color(0xff4d4d4d),
  darkBorderColor: Color(0xff2b2b2b),
  darkBoxColor: Color(0xff0a0a0a),
  darkBackgroundColor: Color(0xff1a1a1a),
  dangerColor: Color(0xffFF3141),
  messageCriticalColor: Color(0xffF5222D),
  messageUrgentColor: Color(0xffFAAD14),
  messageInformativeColor: Color(0xff898989),
  messageNormalColor: Color(0xff2F54EB),
  primaryBackground: Color(0xff1f1621),
);

ThemeData appLightTheme = FlexThemeData.light(
  colors: const FlexSchemeColor(
    primary: Color(0xFFE7C401),
    primaryContainer: Color(0xFF544600),
    secondary: Color(0xFFD0C7A2),
    secondaryContainer: Color(0xFF4D472B),
    tertiary: Color(0xFFD1C88F),
    tertiaryContainer: Color(0xFF4D481C),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w700,
      color: AppColors.textColor,
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.w400,
      color: AppColors.textColor,
    ),
  ),
  usedColors: 1,
  blendLevel: 0,
  surfaceMode: FlexSurfaceMode.level,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 10,
    blendOnColors: false,
    useTextTheme: true,
    useM2StyleDividerInM3: true,
    defaultRadius: 8.0,
    useInputDecoratorThemeInDialogs: true,
    buttonPadding: EdgeInsets.all(12),
    buttonMinSize: AppProperties.minButtonSize,
    elevatedButtonRadius: 4,
    outlinedButtonRadius: 4,
    textButtonRadius: 4,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  swapLegacyOnMaterial3: true,
  //To use the Playground font, add GoogleFonts package and uncomment
  fontFamily: AppDefines.fontFamilyName,
  scaffoldBackground: AppColors.main.withOpacity(.05),
  splashFactory: NoSplash.splashFactory,
  extensions: <ThemeExtension<dynamic>>[lightThemeColor],
).copyWith(
  listTileTheme: const ListTileThemeData(horizontalTitleGap: 10),
  expansionTileTheme: const ExpansionTileThemeData(
    tilePadding: EdgeInsets.symmetric(horizontal: 16),
    iconColor: AppColors.darkLightColor,
    collapsedIconColor: AppColors.darkLightColor,
    childrenPadding: EdgeInsets.symmetric(horizontal: 16),
  ),
  appBarTheme: AppBarTheme(
    actionsIconTheme: const IconThemeData(color: AppColors.darkTextColor),
    iconTheme: const IconThemeData(color: AppColors.darkTextColor),
    titleTextStyle: const TextStyle(
      fontWeight: FontWeight.w700,
      color: AppColors.darkTextColor,
      fontFamily: AppDefines.fontFamilyName,
    ).px18,
  ),
  tabBarTheme: TabBarTheme(
    dividerHeight: 0,
    indicatorColor: Colors.transparent,
    indicatorSize: TabBarIndicatorSize.tab,
    unselectedLabelStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: AppDefines.fontFamilyName,
      color: AppColors.darkTextColor,
    ).px15,
    labelStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: AppDefines.fontFamilyName,
      color: Colors.black,
    ).px15,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    shape: CircleBorder(),
    iconSize: 32,
  ),
  badgeTheme: const BadgeThemeData(smallSize: 10),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColors.main,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionHandleColor: AppColors.main,
  ),
);
