import 'package:flutter/material.dart';

class PatientInfoRadio extends StatelessWidget {
  final List<String> values;
  final ValueNotifier<String> listenable;

  const PatientInfoRadio({super.key, required this.values, required this.listenable});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: listenable,
      builder: (context, name, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (String value in values)
              Builder(builder: (context) {
                String firstCharacter = value.substring(0, 1);
                String newName = '${firstCharacter.toUpperCase()}${value.substring(1)}';
                return RadioListTile<String>(
                  title: Text(newName),
                  value: value,
                  groupValue: name,
                  onChanged: (String? value) {
                    if (value == null) {
                      return;
                    }
                    listenable.value = value;
                  },
                );
              }),
          ],
        );
      },
    );
  }
}
