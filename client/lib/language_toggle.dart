import 'package:dental_calculator/theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:i18n_extension/i18n_extension.dart';

class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'English',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
        ),
        const Gap(8),
        SizedBox(
          height: 30,
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: Switch(
              // This bool value toggles the switch.
              value: I18n.localeStr == 'vi_vn',
              trackColor: trackColor,
              thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
                (Set<WidgetState> states) {
                  return const Icon(
                    Icons.language,
                    color: BlueLightColor.s700,
                  );
                },
              ),
              trackOutlineColor: const WidgetStatePropertyAll<Color>(Colors.transparent),
              thumbColor: const WidgetStatePropertyAll<Color>(BlueLightColor.s700),
              onChanged: (bool value) {
                if (!value) {
                  I18n.of(context).locale = const Locale("en", "US");
                } else {
                  I18n.of(context).locale = const Locale("vi", "VN");
                }
              },
            ),
          ),
        ),
        const Gap(8),
        Text(
          'Tiếng Việt',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
        )
      ],
    );
  }

  WidgetStateProperty<Color?> get trackColor => WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          // Track color when the switch is selected.
          // Otherwise return null to set default track color
          // for remaining states such as when the switch is
          // hovered, focused, or disabled.
          return Colors.white;
        },
      );
}
