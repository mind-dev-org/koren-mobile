import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    colorScheme: const ColorScheme.light(
      surface: AppColors.backgroundLight,
      onSurface: AppColors.black,
      primary: AppColors.accent,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    colorScheme: const ColorScheme.dark(
      surface: AppColors.backgroundDark,
      onSurface: Colors.white,
      primary: AppColors.accent,
    ),
  );
}
