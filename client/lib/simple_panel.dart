import 'package:dental_calculator/theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SimplePanel extends StatelessWidget {
  final String title;
  final Widget child;

  final CrossAxisAlignment crossAxisAlignment;

  const SimplePanel({
    super.key,
    required this.title,
    required this.child,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      color: BlueLightColor.s100,
      shadowColor: BlueLightColor.s200,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: crossAxisAlignment,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Gap(16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
