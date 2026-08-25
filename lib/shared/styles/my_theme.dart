import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/shared/components/constants.dart';
import 'package:todo/shared/styles/text_styles.dart';

import 'app_colors.dart';

class MyTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    // iconTheme: const IconThemeData(color: blackColor),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      iconTheme: IconThemeData(
        size: AppConstants.iconSize,
        color: Colors.white,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(18.r),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(18.r),
      ),
      labelStyle: AppStyles.roboto12White().copyWith(color: Colors.black54),
      floatingLabelStyle: TextStyle(color: AppColors.primaryColor),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primaryColor,
    ),
    textTheme: TextTheme(
      bodyLarge: AppStyles.poppins22White(),
      bodyMedium: AppStyles.poppins18Primary(),
      bodySmall: AppStyles.roboto12Black(),
      displayMedium: AppStyles.poppins18Black(),
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryColor,
      onPrimary: AppColors.lightGreenColor,
      secondary: AppColors.greenColor,
      onSecondary: AppColors.grayColor,
      surface: Colors.white,
      onSurface: Colors.black,
      error: Colors.red,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: AppColors.lightGreenColor,
    iconTheme: IconThemeData(color: Colors.white, size: AppConstants.iconSize),
    cardTheme: CardThemeData(
      elevation: AppConstants.cardElevation,
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      // لضمان قص الـ ListView مع تدويرة حواف الـ Card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
      ),
      margin: const EdgeInsets.all(12.0),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      elevation: AppConstants.bottomNavElevation,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      indicatorColor: Colors.transparent,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        return IconThemeData(
          color: states.contains(WidgetState.selected)
              ? AppColors.primaryColor
              : AppColors.grayColor,
        );
      }),
    ),
    bottomAppBarTheme: BottomAppBarThemeData(shape: CircularNotchedRectangle()),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      iconSize: AppConstants.iconSize,
      shape: CircleBorder(side: BorderSide(color: Colors.white, width: 3)),
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
    ),
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    // iconTheme: const IconThemeData(color: whiteColor),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      iconTheme: IconThemeData(
        size: AppConstants.iconSize,
        color: Colors.black,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(18),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(18),
      ),
      labelStyle: AppStyles.roboto12White(),
      floatingLabelStyle: TextStyle(color: AppColors.primaryColor),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primaryColor,
    ),
    textTheme: TextTheme(
      bodyLarge: AppStyles.poppins22Black(),
      bodyMedium: AppStyles.poppins18Primary(),
      bodySmall: AppStyles.roboto12White(),
      displayMedium: AppStyles.poppins18White(),
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primaryColor,
      onPrimary: AppColors.darkBgColor,
      secondary: AppColors.greenColor,
      onSecondary: AppColors.grayColor,
      surface: AppColors.darkPrimaryColor,
      onSurface: Colors.white,
      error: Colors.red,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: AppColors.darkBgColor,
    cardTheme: CardThemeData(
      elevation: AppConstants.cardElevation,
      // color: darkSecondary,
      clipBehavior: Clip.antiAlias,
      // لضمان قص الـ ListView مع تدويرة حواف الـ Card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        // side: const BorderSide(color: darkPrimary),
      ),
      margin: const EdgeInsets.all(12.0),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      elevation: AppConstants.bottomNavElevation,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      indicatorColor: Colors.transparent,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        return IconThemeData(
          color: states.contains(WidgetState.selected)
              ? AppColors.primaryColor
              : AppColors.grayColor,
        );
      }),
    ),
    bottomAppBarTheme: BottomAppBarThemeData(shape: CircularNotchedRectangle()),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      iconSize: AppConstants.iconSize,
      shape: CircleBorder(side: BorderSide(color: Colors.white, width: 3)),
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
    ),
  );
}
