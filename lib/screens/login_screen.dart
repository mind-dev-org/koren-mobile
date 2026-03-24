import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koren_mobile/widgets/app_background.dart';
import 'package:koren_mobile/features/auth/presentation/screens/forgot_password_screen.dart';

import '../theme/app_colors.dart';
import 'root_screen.dart';
import '../features/auth/presentation/cubit/auth_cubit.dart';
import 'package:koren_mobile/features/auth/presentation/screens/create_account_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LoginScreenView();
  }
}

class _LoginScreenView extends StatelessWidget {
  const _LoginScreenView();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final lightCard = Colors.white;
    final darkCard = const Color(0xFF1E1E1E);
    final buttonBorder =
        isDark ? Colors.white.withValues(alpha: 0.25) : AppColors.black;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const RootScreen()),
          );
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red.shade700,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AppBackground(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 26),
                  Text(
                    'KOREN',
                    style: TextStyle(
                      fontFamily: 'Fraunces',
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      height: 1,
                      color: scheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 56),
                  Text(
                    'JOIN US!',
                    style: TextStyle(
                      fontFamily: 'Fraunces',
                      fontSize: 54,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                      height: 0.95,
                      color: scheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Every choice counts.\nYour conscious consumption\nstarts here.',
                    style: TextStyle(
                      fontFamily: 'Fraunces',
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      height: 1.15,
                      color: scheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 42),

                  
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      final isLoading = state is AuthLoading;
                      return _LoginButton(
                        text: isLoading ? 'Loading...' : 'Continue with Google',
                        backgroundColor: isDark ? darkCard : lightCard,
                        textColor: scheme.onSurface,
                        borderColor: buttonBorder,
                        leading: Image.asset(
                          'assets/icons/google.png',
                          width: 22,
                          height: 22,
                        ),
                        onTap: isLoading
                            ? () {}
                            : () => context.read<AuthCubit>().googleLogin(),
                      );
                    },
                  ),

                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                          fontFamily: 'SpaceGrotesk',
                          color: scheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),

                  
                  Tooltip(
                    message: 'Coming soon',
                    child: Opacity(
                      opacity: 0.4,
                      child: AbsorbPointer(
                        child: _LoginButton(
                          text: 'Continue with Apple',
                          backgroundColor: isDark ? darkCard : AppColors.black,
                          textColor: Colors.white,
                          borderColor: buttonBorder,
                          leading: const Icon(
                            Icons.apple,
                            color: Colors.white,
                            size: 28,
                          ),
                          onTap: () {},
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CreateAccountScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                          side: BorderSide(color: buttonBorder, width: 1),
                        ),
                      ),
                      child: const Text(
                        'CREATE ACCOUNT',
                        style: TextStyle(
                          fontFamily: 'ArchivoBlack',
                          fontSize: 13,
                          letterSpacing: 0.3,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final String text;
  final Widget leading;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;

  const _LoginButton({
    required this.text,
    required this.leading,
    required this.onTap,
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          side: BorderSide(color: borderColor, width: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          padding: const EdgeInsets.symmetric(horizontal: 14),
        ),
        child: Row(
          children: [
            SizedBox(width: 28, height: 28, child: Center(child: leading)),
            Expanded(
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontFamily: 'SpaceGrotesk',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 28, height: 28),
          ],
        ),
      ),
    );
  }
}
