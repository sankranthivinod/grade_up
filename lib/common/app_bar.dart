import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final bool showHome;
  final VoidCallback? onBack;
  final String? homeRoute; // 👈 route to navigate when home is tapped

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBack = false,
    this.showHome = false,
    this.onBack,
    this.homeRoute, // 👈 pass your route here
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showBack
          ? IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: onBack ?? () => context.go(homeRoute!),
      )
          : null,
      title: Text(title),
      actions: [
        if (showHome && homeRoute != null)
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => context.go(homeRoute!),
          ),
      ],
    );
  }
}
