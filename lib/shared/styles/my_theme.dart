import 'package:flutter/material.dart';
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
        size: AppConstants.actionsIconSize,
        color: Colors.white,
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primaryColor,
    ),
    textTheme: TextTheme(
      bodyLarge: AppStyles.poppins22White(),
      bodyMedium: AppStyles.poppins18Primary(),
      bodySmall: AppStyles.roboto12Black(),
    ),
    // colorScheme: const ColorScheme(
    //   brightness: Brightness.light,
    //   primary: lightPrimary,
    //   onPrimary: whiteColor,
    //   secondary: blackColor,
    //   onSecondary: whiteColor,
    //   surface: whiteColor,
    //   onSurface: blackColor,
    //   error: Colors.red,
    //   onError: Colors.white,
    // ),
    scaffoldBackgroundColor: AppColors.lightGreenColor,
    dividerTheme: const DividerThemeData(
      color: AppColors.primaryColor,
      thickness: AppConstants.dividerThickness,
    ),
    cardTheme: CardThemeData(
      elevation: AppConstants.cardElevation,
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      // لضمان قص الـ ListView مع تدويرة حواف الـ Card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        side: const BorderSide(color: AppColors.primaryColor),
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
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      indicatorColor: Colors.transparent,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        return IconThemeData(
          color: states.contains(WidgetState.selected)
              ? AppColors.primaryColor
              : AppColors.grayColor,
        );
      }),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    // iconTheme: const IconThemeData(color: whiteColor),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      iconTheme: IconThemeData(
        size: AppConstants.actionsIconSize,
        color: Colors.black,
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primaryColor,
    ),
    textTheme: TextTheme(
      bodyLarge: AppStyles.poppins22Black(),
      bodyMedium: AppStyles.poppins18Primary(),
      bodySmall: AppStyles.roboto12White(),
    ),
    // colorScheme: const ColorScheme(
    //   brightness: Brightness.dark,
    //   primary: darkPrimary,
    //   onPrimary: darkSecondary,
    //   secondary: darkPrimary,
    //   onSecondary: darkSecondary,
    //   surface: darkSecondary,
    //   onSurface: darkPrimary,
    //   error: Colors.red,
    //   onError: Colors.white,
    // ),
    scaffoldBackgroundColor: AppColors.darkBgColor,
    dividerTheme: const DividerThemeData(
      // color: darkPrimary,
      thickness: AppConstants.dividerThickness,
    ),
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
        // backgroundColor: darkPrimary,
        // foregroundColor: blackColor,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.black,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      indicatorColor: Colors.transparent,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        return IconThemeData(
          color: states.contains(WidgetState.selected)
              ? AppColors.primaryColor
              : AppColors.grayColor,
        );
      }),
    ),
  );
}
