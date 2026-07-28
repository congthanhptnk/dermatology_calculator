import 'package:dental_calculator/theme.dart';
import 'package:dental_calculator/translations.i18n.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 32,
        horizontal: 24,
      ),
      width: double.infinity,
      color: BlueLightColor.s100,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700, maxHeight: 500),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(flex: 2, child: _buildLeftColumn(context)),
            Expanded(flex: 1, child: _buildRightColumn(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileFooter(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Developed and owned by Thao Ngoc-Phuong Tran and Thanh Tran. All rights reserved.'.i18n),
        const Gap(4),
        Text('For any inquiry, please contact Thao Ngoc-Phuong Tran at tranngocphuongthao@gmail.com'.i18n),
      ],
    );
  }

  Widget _buildLeftColumn(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Predicting Sum Widths of Unerupted Canines and Premolars: A Machine Learning Approach and Web-based Application'
              .i18n,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const Gap(8),
        Text(
          'Developed and owned by Thao Ngoc-Phuong Tran and Thanh Tran'.i18n,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const Gap(4),
        Text('For any inquiry, please contact Thao Ngoc-Phuong Tran at tranngocphuongthao@gmail.com'.i18n),
      ],
    );
  }

  Widget _buildRightColumn(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Developed and owned by Thao Ngoc-Phuong Tran and Thanh Tran. All rights reserved.'.i18n),
      ],
    );
  }
}

class BiggerFooter extends StatelessWidget {
  const BiggerFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 32,
        horizontal: 24,
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.width > 700 ? 220 : 440,
      color: BlueLightColor.s100, // Light grey background
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000), // Wider to match design
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Developed to support the research study titled',
                      style: TextStyle(fontSize: 14),
                    ),
                    const Gap(8),
                    Text(
                      'Predicting Sum Widths of Unerupted Canines and Premolars: A Machine Learning Approach and Web-based Application'
                          .i18n,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(16),
                    Text(
                      '© 2026 Thao Ngoc-Phuong Tran & Thanh Tran Cong. All rights reserved.',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    if (MediaQuery.of(context).size.width <= 700) ...[
                      const Gap(32),
                      ..._buildContactInfo(context),
                    ],
                    const Gap(16),
                  ],
                ),
              ),
              if (MediaQuery.of(context).size.width > 700)
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ..._buildContactInfo(context),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildContactInfo(BuildContext context) {
    return [
      Text(
        'Contact Information'.i18n,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      ),
      const Gap(8),
      Text(
        'Thao Ngoc-Phuong Tran'.i18n,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 14,
        ),
      ),
      Text(
        'tranngocphuongthao@gmail.com'.i18n,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 14,
        ),
      ),
      const Gap(16),
      Text(
        'Thanh Tran Cong'.i18n,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 14,
        ),
      ),
      Text(
        'congthanhptnk@gmail.com'.i18n,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 14,
        ),
      ),
    ];
  }
}
