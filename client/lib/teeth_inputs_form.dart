import 'package:dental_calculator/input_field.dart';
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
            label: feature,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Required';
              }

              if (double.tryParse(value!) == null) {
                return 'Please fill in a valid value';
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
}
