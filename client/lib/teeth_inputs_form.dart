import 'package:dental_calculator/input_field.dart';
import 'package:dental_calculator/translations.i18n.dart';
import 'package:flutter/material.dart';

class TeethInputsForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final List<String> features;

  final void Function(String feature, double value) onChanged;

  const TeethInputsForm({
    super.key,
    required this.formKey,
    required this.features,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: GridView.builder(
        itemCount: features.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 24, mainAxisExtent: 120),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          String feature = features[index];
          return InputField(
            label: getFeatureName(feature),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Required'.i18n;
              }

              if (double.tryParse(value!) == null) {
                return 'Please fill in a valid value. Eg: 10.0'.i18n;
              }

              return null;
            },
            onChanged: (String value) {
              if (double.tryParse(value) == null) {
                return;
              }

              onChanged(feature, double.parse(value));
            },
          );
        },
      ),
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
