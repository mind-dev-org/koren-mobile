import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const title = TextStyle(
    fontFamily: "Fraunces",
    fontSize: 38,
    fontWeight: FontWeight.w700,
    height: 1.1,
    color: AppColors.black,
  );

  static const body = TextStyle(
    fontFamily: "SpaceGrotesk",
    fontSize: 16,
    height: 1.5,
    color: AppColors.dark,
  );

  static const button = TextStyle(
    fontFamily: "ArchivoBlack",
    fontSize: 16,
    letterSpacing: 1,
    color: Colors.white,
  );
}
