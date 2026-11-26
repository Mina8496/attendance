import 'package:attendance/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class SlidingText extends StatelessWidget {
  const SlidingText({super.key, required this.slidingAnimation});

  final Animation<Offset> slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slidingAnimation,
      builder: (context, child) {
        return SlideTransition(
          position: slidingAnimation,
          child: Text(
            'نظام غياب وحضور كامل',
            style: AppStyles.textStyle16,
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
