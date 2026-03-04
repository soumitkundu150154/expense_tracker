import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // colors

  static const Color background = Color(0xFF0D1117);
  static const Color secondaryBackground = Color(0xFF161B22);

  static const Color primaryAccent = Color(0xFF3B82F6); // Electric Blue
  static const Color secondaryAccent = Color(0xFF8B5CF6); // Neon Purple

  static const Color success = Color(0xFF22C55E); // Income
  static const Color danger = Color(0xFFEF4444); // Expense

  static const Color textPrimary = Color(0xFFE6EDF3);
  static const Color textSecondary = Color(0xFF8B949E);

  static const Color borderColor = Color(0xFF30363D);

  // gradient _____________

  static const LinearGradient balanceGradient = LinearGradient(
    colors: [primaryAccent, secondaryAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ===== ThemeData =====

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: background,

    primaryColor: primaryAccent,

    colorScheme: const ColorScheme.dark(
      primary: primaryAccent,
      secondary: secondaryAccent,
      surface: background,
      error: danger,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: background,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: textPrimary),
    ),
  );

  // text theme

  TextTheme textTheme = const TextTheme(
    headlineLarge: TextStyle(
      color: textPrimary,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(
      color: textPrimary,
      fontSize: 24,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(color: textPrimary, fontSize: 16),
    bodyMedium: TextStyle(color: textSecondary, fontSize: 14),
  );

  // card theme

  CardTheme cardTheme = CardTheme(
    color: secondaryBackground,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: borderColor, width: 1),
    ),
  );

  FloatingActionButtonThemeData floatingActionButtonTheme =
      FloatingActionButtonThemeData(
        backgroundColor: primaryAccent,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: const CircleBorder(),
      );

  // Input fields
  InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: secondaryBackground,

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: borderColor, width: 1),
    ),

    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: borderColor),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: primaryAccent,
          width: 2,
        ),
      ),

      labelStyle: const TextStyle(
        color: textSecondary,
      ),

      prefixIconColor: textSecondary,
      suffixIconColor: textSecondary,
  );

  // buttons

  ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(primaryAccent),
      foregroundColor: WidgetStatePropertyAll(Colors.white),
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      ),
      padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 14, horizontal: 20)),
    ),
  );

  // buttom navigation

  BottomNavigationBarThemeData bottomNavigationBarTheme = BottomNavigationBarThemeData(
    backgroundColor: secondaryBackground,
      selectedItemColor: primaryAccent,
      unselectedItemColor: textSecondary,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
  );
}
