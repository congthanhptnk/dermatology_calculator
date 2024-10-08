import 'package:dental_calculator/theme.dart';
import 'package:dental_calculator/translations.i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class ResultPanel extends StatelessWidget {
  final String formula;
  final double result;
  final double? mae;

  final bool showDisclaimer;

  const ResultPanel({
    super.key,
    required this.formula,
    required this.result,
    required this.showDisclaimer,
    this.mae,
  });

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      color: SuccessColor.s700,
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
                  'Result'.i18n,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.white),
                ),
                // const Gap(16),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 24),
                //   child: SelectableText(
                //     'Formula'.i18n + ': $formula',
                //     style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                //   ),
                // ),
                if (showDisclaimer && mae != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SelectableText(
                      'Note: This is an ALTERNATIVE prediction result, may vary by about %s mm from actual value'
                          .i18n
                          .fill([mae!.toStringAsFixed(2)]),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                    ),
                  ),
              ],
            ),
            const Gap(32),
            Center(child: _buildResultBox(context)),
            const Gap(32),
          ],
        ),
      ),
    );
  }

  Widget _buildResultBox(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Clipboard.setData(ClipboardData(text: result.toString())).then(
          (_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Result copied to your clipboard'.i18n,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
                ),
                backgroundColor: SuccessColor.s800,
                duration: const Duration(milliseconds: 4000),
                width: 400,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                // margin: const EdgeInsets.only(bottom: 24),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            );
          },
        );
      },
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.white, width: 3),
        fixedSize: const Size(double.infinity, 80),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 32,
        ),
        overlayColor: SuccessColor.s300,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(
            Icons.copy,
            color: Colors.white,
            size: 28,
          ),
          const Gap(16),
          const VerticalDivider(
            thickness: 3,
            indent: 8,
            endIndent: 8,
            color: Colors.white,
          ),
          const Gap(24),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 100, maxWidth: 300),
            child: Text(
              result.toStringAsFixed(2),
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
