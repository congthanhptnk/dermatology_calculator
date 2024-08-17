import 'package:flutter/material.dart';

class CustomCalculatorPage extends StatelessWidget {
  const CustomCalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Second page'),
      ),
      body: Text('to be continue'),
    );
  }
}
