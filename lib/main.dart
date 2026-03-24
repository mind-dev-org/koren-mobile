import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

import 'providers/favorites_provider.dart';
import 'providers/cart_provider.dart';
import 'theme/theme_provider.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koren_mobile/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:dio/dio.dart';
import 'package:koren_mobile/config/app_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  Stripe.publishableKey =
      'pk_test_51TCgo25czPhrBLdahxnOIXQNBYDoJvgzeFfrZdHNKrwNoPYDjlVtMQLuFLdaY5mizfKqOuKq2yBCb1ULUIYZyELV00jATWhWPM';
  await Stripe.instance.applySettings();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>.value(
          value: themeProvider,
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider<FavoritesProvider>(
          create: (_) => FavoritesProvider(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthCubit(
              Dio(
                BaseOptions(
                  baseUrl: AppConfig.baseUrl,
                  connectTimeout: const Duration(seconds: 20),
                  receiveTimeout: const Duration(seconds: 20),
                  sendTimeout: const Duration(seconds: 20),
                ),
              ),
            ),
          ),
        ],
        child: const KorenApp(),
      ),
    ),
  );
}

class KorenApp extends StatelessWidget {
  const KorenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Koren',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          home: const SplashScreen(),
        );
      },
    );
  }
}
