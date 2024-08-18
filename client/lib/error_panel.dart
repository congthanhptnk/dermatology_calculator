import 'package:dental_calculator/theme.dart';
import 'package:dental_calculator/translations.i18n.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ErrorPanel extends StatelessWidget {
  final String error;

  const ErrorPanel({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      color: ErrorColor.s300,
      shadowColor: BlueLightColor.s200,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Error'.i18n,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                ),
                const Gap(16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SelectableText(
                    error.toString(),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
            const Gap(32),
          ],
        ),
      ),
    );
  }
}
