import 'package:dental_calculator/simple_panel.dart';
import 'package:dental_calculator/theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TeethSelector extends StatelessWidget {
  final bool expanded;

  final List<String> existingFeatures;
  final List<String> selectedFeatures;

  final void Function(String feature, bool isOn) toggleOption;
  final void Function(bool isOn) toggleExpanded;

  const TeethSelector({
    super.key,
    required this.existingFeatures,
    required this.expanded,
    required this.selectedFeatures,
    required this.toggleOption,
    required this.toggleExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return SimplePanel(
      title: 'Teeth',
      child: Column(
        children: [
          _buildPartialSelector(context),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Please toggle on the values that you have. Require at least 2',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: GrayLightColor.s400),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartialSelector(BuildContext context) {
    return Wrap(
      children: [
        for (String feature in existingFeatures)
          SizedBox(
            width: 150,
            child: Builder(builder: (context) {
              bool selected = selectedFeatures.contains(feature);
              return ListTile(
                title: Row(
                  children: [
                    Checkbox(
                      value: selected,
                      onChanged: (bool? value) {
                        if (value == null) {
                          return;
                        }
                        toggleOption(feature, value);
                      },
                    ),
                    const Gap(4),
                    Text(
                      feature,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                selected: selected,
                onTap: () {
                  toggleOption(feature, !selected);
                },
              );
            }),
          ),
      ],
    );
  }
}
