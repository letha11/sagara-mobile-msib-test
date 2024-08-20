import 'package:flutter/material.dart';
import 'package:weather_app/utils/colors.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    appBarTheme: appBarTheme,
    scaffoldBackgroundColor: AppColors.primary,
    textTheme: textTheme,
  );

  static final AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: AppColors.primary,
    surfaceTintColor: AppColors.primary,
    elevation: 0,
  );

  static final TextTheme textTheme = TextTheme(
    titleLarge: TextStyle(
      fontFamily: 'Lexend',
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w700,
      fontSize: 32,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Lexend',
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w500,
      fontSize: 20,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Lexend',
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w700,
      fontSize: 18,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Lexend',
      color: AppColors.textPrimary,
      fontSize: 18,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Lexend',
      color: AppColors.textPrimary,
      fontSize: 16,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Lexend',
      color: AppColors.textSecondary,
      fontWeight: FontWeight.w300,
      fontSize: 12,
    ),
  );
}
