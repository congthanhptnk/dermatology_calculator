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
      color: BlueLightColor.s100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Developed and owned by Thao Ngoc-Phuong Tran and Thanh Tran. All rights reserved.'.i18n,
          ),
          const Gap(4),
          Text('For any inquiry, please contact Thao Ngoc-Phuong Tran at t4tran3.2@gmail.com'.i18n),
        ],
      ),
    );
  }
}
