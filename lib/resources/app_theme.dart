import 'package:field_services/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get appTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColor,
      hintColor: AppColors.silver,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.primaryColor,
        selectionColor: AppColors.primaryColor,
        selectionHandleColor: AppColors.primaryColor,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.primaryColor,
          ),
        ),
      ),
      textTheme: GoogleFonts.robotoTextTheme(
        const TextTheme(
          headline1: TextStyle(
            color: AppColors.emperor,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          bodyText1: TextStyle(
            color: AppColors.emperor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          bodyText2: TextStyle(
            color: AppColors.emperor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          button: TextStyle(
            color: AppColors.emperor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  static TextStyle get headerTextStyle => appTheme.textTheme.headline1!;

  static TextStyle get titleTextStyle => appTheme.textTheme.bodyText1!;

  static TextStyle get bodyTextStyle => appTheme.textTheme.bodyText2!;

  static TextStyle get buttonTextStyle => appTheme.textTheme.button!;
}
