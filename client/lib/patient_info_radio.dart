import 'package:dental_calculator/translations.i18n.dart';
import 'package:flutter/material.dart';

class PatientInfoRadio extends StatelessWidget {
  final List<String> values;
  final List<String> names;
  final ValueNotifier<String> listenable;

  const PatientInfoRadio({
    super.key,
    required this.values,
    required this.listenable,
    required this.names,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: listenable,
      builder: (context, name, child) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: values.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            String selectedName = names[index];
            String firstCharacter = selectedName.substring(0, 1);
            String newName = '${firstCharacter.toUpperCase()}${selectedName.substring(1)}';
            return RadioListTile<String>(
              title: Text(newName.i18n),
              value: values[index],
              groupValue: name,
              onChanged: (String? value) {
                if (value == null) {
                  return;
                }
                listenable.value = value;
              },
            );
          },
        );
      },
    );
  }
}
