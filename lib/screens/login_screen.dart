import 'package:flutter/material.dart';
import 'root_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const RootScreen(),
                ),
              );
            },
            child: const Text("Continue to app"),
          ),
        ),
      ),
    );
  }
}
