import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import '../theme/app_colors.dart';

class TickerWidget extends StatelessWidget {
  const TickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      color: Colors.black,
      child: Marquee(
        text: " LOCAL FOOD • ECO FARMING • NO PLASTIC • SEASONAL PRODUCTS • ",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        scrollAxis: Axis.horizontal,
        velocity: 40,
        blankSpace: 40,
      ),
    );
  }
}
