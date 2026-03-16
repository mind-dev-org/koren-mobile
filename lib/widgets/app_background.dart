import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColors.backgroundLight,
        ),
        Positioned.fill(
          child: Opacity(
            opacity: 0.06,
            child: Image.asset(
              "assets/texture/background.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
        child,
      ],
    );
  }
}
