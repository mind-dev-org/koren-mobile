import 'package:flutter/material.dart';
import '../widgets/ticker_widget.dart';
import '../widgets/app_header.dart';

class FarmersScreen extends StatelessWidget {
  const FarmersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(),
            const TickerWidget(),
            const SizedBox(height: 40),
            const Center(
              child: Text(
                "Farmers Page",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
