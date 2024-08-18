import 'package:dental_calculator/theme.dart';
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
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Developed and owned by Tran Ngoc Phuong Thao. All rights reserved',
          ),
          Gap(4),
          Text('For any inquiry, please contact Tran Ngoc Phuong Thao at'),
        ],
      ),
    );
  }
}
