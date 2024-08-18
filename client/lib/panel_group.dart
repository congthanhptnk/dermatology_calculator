import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PanelGroup extends StatelessWidget {
  final String title;
  final String? description;

  final Widget child;

  const PanelGroup({super.key, required this.title, this.description, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        if (description != null)
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              description!,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        const Gap(8),
        child,
      ],
    );
  }
}
