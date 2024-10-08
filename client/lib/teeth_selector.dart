import 'package:auto_size_text/auto_size_text.dart';
import 'package:dental_calculator/simple_panel.dart';
import 'package:dental_calculator/theme.dart';
import 'package:dental_calculator/translations.i18n.dart';
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
      title: '',
      child: Column(
        children: [
          _buildPartialSelector(context),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Require at least 2 teeth'.i18n,
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
    var myGroup = AutoSizeGroup();
    return GridView.builder(
      itemCount: existingFeatures.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        String feature = existingFeatures[index];
        bool selected = selectedFeatures.contains(feature);
        return ListTile(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
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
              Expanded(
                child: AutoSizeText(
                  getFeatureName(feature),
                  style: Theme.of(context).textTheme.titleLarge,
                  group: myGroup,
                  minFontSize: 12,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          selected: selected,
          onTap: () {
            toggleOption(feature, !selected);
          },
        );
      },
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 758, mainAxisExtent: 60),
    );
  }

  String getFeatureName(String feature) {
    switch (feature) {
      case 'R1T':
        return 'Upper central incisor'.i18n;
      case 'R2T':
        return 'Upper lateral incisor'.i18n;
      case 'R6T':
        return 'Upper first molar'.i18n;
      case 'R1D':
        return 'Lower central incisor'.i18n;
      case 'R2D':
        return 'Lower lateral incisor'.i18n;
      case 'R6D':
        return 'Lower first molar'.i18n;
      default:
        return 'Some molar';
    }
  }
}
