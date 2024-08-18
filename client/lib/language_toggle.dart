import 'package:country_flags/country_flags.dart';
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
        CountryFlag.fromLanguageCode(
          'en',
          height: 24,
          width: 40,
        ),
        const Gap(8),
        SizedBox(
          height: 30,
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: Switch(
              // This bool value toggles the switch.
              value: I18n.localeStr == 'vi_vn',
              overlayColor: overlayColor,
              trackColor: trackColor,
              thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
                (Set<WidgetState> states) {
                  return const Icon(
                    Icons.language,
                    color: Colors.white,
                  );
                },
              ),
              thumbColor: const WidgetStatePropertyAll<Color>(Colors.white),
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
        CountryFlag.fromCountryCode(
          'VN',
          height: 24,
          width: 40,
        ),
      ],
    );
  }

  WidgetStateProperty<Color?> get trackColor => WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          // Track color when the switch is selected.
          if (states.contains(WidgetState.selected)) {
            return Colors.redAccent;
          }
          // Otherwise return null to set default track color
          // for remaining states such as when the switch is
          // hovered, focused, or disabled.
          return Colors.amber.shade300;
        },
      );
  WidgetStateProperty<Color?> get overlayColor => WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          // Material color when switch is selected.
          if (states.contains(WidgetState.selected)) {
            return Colors.yellow.withOpacity(0.54);
          }
          // Material color when switch is disabled.
          if (states.contains(WidgetState.disabled)) {
            return Colors.grey.shade400;
          }
          // Otherwise return null to set default material color
          // for remaining states such as when the switch is
          // hovered, or focused.
          return null;
        },
      );
}
