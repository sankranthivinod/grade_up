import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  // Branding colors
  static const Color primary = Color(0xFF185895);      // Logo blue (cap)
  static const Color onPrimary = Colors.white;

  static const Color secondary = Color(0xFF0BF5BE);    // Logo green (arrow)
  static const Color onSecondary = Colors.black;

  static const Color accent = Color(0xFFFFC107);       // Amber highlight
  static const Color onAccent = Colors.black;

  // Backgrounds and surfaces
  static const Color background = Color(0xFFFAFAFA);   // Light screen background
  static const Color onBackground = Color(0xFF212121); // Text on light background

  static const Color surface = Colors.white;           // Card, modal surfaces
  static const Color onSurface = Color(0xFF212121);    // Text on surface

  // Error
  static const Color error = Colors.red;
  static const Color onError = Colors.white;

  // Neutrals
  static const Color white = Colors.white;
  static const Color black = Colors.black;
}
