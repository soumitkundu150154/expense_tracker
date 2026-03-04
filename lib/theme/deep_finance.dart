import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ─────────────────────────────────────────────
//  EXPENSE TRACKER — DARK THEME
//  File: lib/theme/app_theme.dart
// ─────────────────────────────────────────────

class AppTheme {
  AppTheme._();

  // ── Core Palette ──────────────────────────────
  static const Color background     = Color(0xFF0D0F14); // near-black canvas
  static const Color surface        = Color(0xFF161A23); // card / sheet base
  static const Color surfaceAlt     = Color(0xFF1E2330); // elevated surfaces
  static const Color border         = Color(0xFF252A38); // subtle dividers

  // ── Brand Accent ──────────────────────────────
  static const Color primary        = Color(0xFF7B61FF); // electric violet
  static const Color primaryLight   = Color(0xFF9E8BFF); // hover / lighter tint
  static const Color primaryDim     = Color(0x267B61FF); // 15 % alpha fill

  // ── Semantic Colors ───────────────────────────
  static const Color income         = Color(0xFF00C896); // emerald green
  static const Color incomeDim      = Color(0x1A00C896);
  static const Color expense        = Color(0xFFFF5C5C); // coral red
  static const Color expenseDim     = Color(0x1AFF5C5C);
  static const Color warning        = Color(0xFFFFB02E); // amber
  static const Color warningDim     = Color(0x1AFFB02E);

  // ── Text Hierarchy ────────────────────────────
  static const Color textPrimary    = Color(0xFFF0F2F8);
  static const Color textSecondary  = Color(0xFF8A90A8);
  static const Color textMuted      = Color(0xFF4E5570);

  // ── Balance Card Gradient ─────────────────────
  static const LinearGradient balanceGradient = LinearGradient(
    colors: [Color(0xFF3D2FBF), Color(0xFF7B61FF), Color(0xFF9F6BFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.55, 1.0],
  );

  // ── Income / Expense Gradient chips ───────────
  static const LinearGradient incomeGradient = LinearGradient(
    colors: [Color(0xFF00A97A), Color(0xFF00C896)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient expenseGradient = LinearGradient(
    colors: [Color(0xFFD94040), Color(0xFFFF5C5C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ── Glow Shadows (for cards) ──────────────────
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: Colors.black.withOpacity(0.45),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ];

  static List<BoxShadow> get primaryGlow => [
        BoxShadow(
          color: primary.withOpacity(0.35),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
      ];

  static List<BoxShadow> get incomeGlow => [
        BoxShadow(
          color: income.withOpacity(0.25),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get expenseGlow => [
        BoxShadow(
          color: expense.withOpacity(0.25),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ];

  // ── ThemeData ─────────────────────────────────
  static ThemeData darkTheme = ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: background,
        colorScheme: const ColorScheme.dark(
          background:       background,
          surface:          surface,
          primary:          primary,
          onPrimary:        Colors.white,
          onSurface:        textPrimary,
          secondary:        income,
          onSecondary:      Colors.white,
          error:            expense,
          onError:          Colors.white,
          outline:          border,
          surfaceVariant:   surfaceAlt,
          onSurfaceVariant: textSecondary,
        ),

        // ── AppBar ──────────────────────────────
        appBarTheme: const AppBarTheme(
          backgroundColor: background,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
          iconTheme: IconThemeData(color: textPrimary),
          titleTextStyle: TextStyle(
            color: textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: background,
          ),
        ),

        // ── Cards ───────────────────────────────
        cardTheme: CardThemeData(
          color: surface,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: border, width: 1),
          ),
        ),

        // ── FAB ─────────────────────────────────
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: StadiumBorder(),
        ),

        // ── Input / TextField ────────────────────
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: surfaceAlt,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primary, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: expense),
          ),
          hintStyle: const TextStyle(color: textMuted, fontSize: 14),
          labelStyle: const TextStyle(color: textSecondary),
          prefixIconColor: textSecondary,
          suffixIconColor: textSecondary,
        ),

        // ── ElevatedButton ───────────────────────
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            foregroundColor: Colors.white,
            elevation: 0,
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
        ),

        // ── OutlinedButton ───────────────────────
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: primary,
            side: const BorderSide(color: primary),
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
        ),

        // ── TextButton ───────────────────────────
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: primary,
            textStyle: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),

        // ── BottomNavigationBar ──────────────────
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: surface,
          selectedItemColor: primary,
          unselectedItemColor: textMuted,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
          unselectedLabelStyle: TextStyle(fontSize: 11),
        ),

        // ── BottomSheet ──────────────────────────
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: surface,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
        ),

        // ── Divider ──────────────────────────────
        dividerTheme: const DividerThemeData(
          color: border,
          thickness: 1,
          space: 1,
        ),

        // ── ListTile ─────────────────────────────
        listTileTheme: const ListTileThemeData(
          tileColor: Colors.transparent,
          textColor: textPrimary,
          iconColor: textSecondary,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        ),

        // ── Chip ─────────────────────────────────
        chipTheme: ChipThemeData(
          backgroundColor: surfaceAlt,
          selectedColor: primaryDim,
          labelStyle: const TextStyle(color: textPrimary, fontSize: 13),
          side: const BorderSide(color: border),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        ),

        // ── Dialog ───────────────────────────────
        dialogTheme: DialogThemeData(
          backgroundColor: surface,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          titleTextStyle: const TextStyle(
            color: textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          contentTextStyle: const TextStyle(color: textSecondary, fontSize: 14),
        ),

        // ── SnackBar ─────────────────────────────
        snackBarTheme: SnackBarThemeData(
          backgroundColor: surfaceAlt,
          contentTextStyle: const TextStyle(color: textPrimary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          behavior: SnackBarBehavior.floating,
        ),

        // ── Typography ───────────────────────────
        textTheme: const TextTheme(
          displayLarge:  TextStyle(color: textPrimary, fontWeight: FontWeight.w800),
          displayMedium: TextStyle(color: textPrimary, fontWeight: FontWeight.w700),
          headlineLarge: TextStyle(color: textPrimary, fontWeight: FontWeight.w700),
          headlineMedium:TextStyle(color: textPrimary, fontWeight: FontWeight.w600),
          headlineSmall: TextStyle(color: textPrimary, fontWeight: FontWeight.w600),
          titleLarge:    TextStyle(color: textPrimary, fontWeight: FontWeight.w600, fontSize: 18),
          titleMedium:   TextStyle(color: textPrimary, fontWeight: FontWeight.w500, fontSize: 15),
          titleSmall:    TextStyle(color: textSecondary, fontWeight: FontWeight.w500, fontSize: 13),
          bodyLarge:     TextStyle(color: textPrimary, fontSize: 15),
          bodyMedium:    TextStyle(color: textSecondary, fontSize: 13),
          bodySmall:     TextStyle(color: textMuted, fontSize: 12),
          labelLarge:    TextStyle(color: textPrimary, fontWeight: FontWeight.w600, fontSize: 14),
          labelSmall:    TextStyle(color: textMuted, fontSize: 11),
        ),
      );
}