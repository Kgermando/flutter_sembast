import 'package:flutter/material.dart';

class AppStyle {
  final ColorScheme _lightScheme = const ColorScheme.light().copyWith(
    primary: const Color(0xFFF59C3B),
    primaryVariant: const Color(0xFFbd6d00),
    onPrimary: const Color(0xFF6638B6),
    secondary: const Color(0xFF6638B6),
    secondaryVariant: const Color(0xFF310885),
    onSecondary: const Color(0xFFF59C3B),
    background: const Color(0xFFDEDEDE),
    onBackground: const Color(0xFF989898),
  );

  final ColorScheme _darkScheme = const ColorScheme.dark().copyWith(
    primary: const Color(0xFF6638B6),
    primaryVariant: const Color(0xFF310885),
    onPrimary: const Color(0xFFF59C3B),
    secondary: const Color(0xFFF59C3B),
    secondaryVariant: const Color(0xFFbd6d00),
    onSecondary: const Color(0xFF6638B6),
    background: const Color(0xFF989898),
    onBackground: const Color(0xFFDEDEDE),
  );

  ThemeData createLightTheme() {
    ThemeData theme = ThemeData.from(colorScheme: _lightScheme);

    return theme.copyWith();
  }

  ThemeData createDarkTheme() {
    ThemeData theme = ThemeData.from(colorScheme: _darkScheme);

    return theme.copyWith();
  }
}
