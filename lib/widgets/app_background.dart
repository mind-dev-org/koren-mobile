import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        Container(
          color: scheme.surface,
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: Opacity(
              opacity: isDark ? 0.08 : 0.16,
              child: Image.asset(
                'assets/texture/background.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
