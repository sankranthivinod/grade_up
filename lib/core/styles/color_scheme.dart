import 'package:flutter/material.dart';
import 'app_colors.dart';

final ColorScheme lightColorScheme = const ColorScheme(
  brightness: Brightness.light,
  primary: AppColors.primary,
  onPrimary: AppColors.onPrimary,
  secondary: AppColors.secondary,
  onSecondary: AppColors.onSecondary,
  surface: AppColors.surface,
  onSurface: AppColors.onSurface,
  error: AppColors.error,
  onError: AppColors.onError,
  tertiary: AppColors.accent,
  onTertiary: AppColors.onAccent,
);

final ColorScheme darkColorScheme = const ColorScheme(
  brightness: Brightness.dark,
  primary: AppColors.primary,
  onPrimary: AppColors.onPrimary,
  secondary: AppColors.secondary,
  onSecondary: AppColors.onSecondary,
  surface: Color(0xFF1E1E1E),
  onSurface: Colors.white70,
  error: Colors.redAccent,
  onError: Colors.black,
  tertiary: AppColors.accent,
  onTertiary: AppColors.onAccent,
);
