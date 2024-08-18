import 'dart:convert';

import 'package:dental_calculator/custom_calculator_page.dart';
import 'package:dental_calculator/error_panel.dart';
import 'package:dental_calculator/main.dart';
import 'package:dental_calculator/panel_group.dart';
import 'package:dental_calculator/result_panel.dart';
import 'package:dental_calculator/simple_panel.dart';
import 'package:dental_calculator/teeth_inputs_form.dart';
import 'package:dental_calculator/theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CalculatorPage extends StatefulWidget {
  final VoidCallback onReset;

  const CalculatorPage({super.key, required this.onReset});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final ScrollController scrollController = ScrollController();

  final List<String> existingFeatures = ['R1T', 'R1D', 'R2T', 'R2D', 'R6T', 'R6D'];

  final Map<String, double> featuresValues = {};
  double finalRes = 0;

  List<String>? requiredFeatures;
  String? formula;

  final ValueNotifier<String> gender = ValueNotifier('male');
  final ValueNotifier<String> yName = ValueNotifier('R345T');

  bool isLoading = false;
  String? error;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    gender.addListener(resetValues);
    yName.addListener(resetValues);
  }

  void resetValues() {
    setState(() {
      featuresValues.clear();
      requiredFeatures = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyLarge!,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 60),
          child: AppBar(
            title: Text(
              'Dental Machine Learning Demo',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.white),
            ),
            backgroundColor: BlueLightColor.s700,
            scrolledUnderElevation: 2,
            elevation: 2,
          ),
        ),
        bottomNavigationBar: Container(
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
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 32),
          child: Scrollbar(
            controller: scrollController,
            thumbVisibility: true,
            trackVisibility: true,
            thickness: 12,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      PanelGroup(
                        title: 'Select gender and Y',
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              flex: 1,
                              child: SimplePanel(
                                title: 'Gender',
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                child: _buildGender(context),
                              ),
                            ),
                            const Gap(24),
                            Expanded(
                              flex: 1,
                              child: SimplePanel(
                                title: 'Y Name',
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                child: _buildYName(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(24),
                      if (requiredFeatures?.isEmpty ?? true)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: _buildEvaluateBestFeaturesButton(),
                        ),
                      const Gap(24),
                      if (requiredFeatures?.isNotEmpty ?? false)
                        PanelGroup(
                          title: 'Below measurements are required for the best predictions',
                          description:
                              "If you are unable to provide these, click 'I DON'T HAVE THESE MEASUREMENTS' button to evaluate based on other measurements",
                          child: SimplePanel(
                            title: 'Teeth Measurements',
                            child: _buildTeethSelector(context),
                          ),
                        ),
                      const Gap(24),
                      if (isLoading)
                        Center(
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: LoadingAnimationWidget.twistingDots(
                              rightDotColor: SuccessColor.s300,
                              leftDotColor: BlueLightColor.s300,
                              size: 100,
                            ),
                          ),
                        )
                      else if (error?.isNotEmpty ?? false)
                        ErrorPanel(error: error!)
                      else if (finalRes != 0 && formula != null) ...[
                        ResultPanel(
                          formula: formula!,
                          result: finalRes,
                        )
                      ],
                      const Gap(32),
                      if (requiredFeatures?.isNotEmpty ?? false) _buildButtons(context),
                      const Gap(16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildYName(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: yName,
        builder: (context, name, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Text('R345T'),
                value: 'R345T',
                groupValue: name,
                onChanged: (String? value) {
                  if (value == null) {
                    return;
                  }
                  yName.value = value;
                },
              ),
              RadioListTile<String>(
                title: const Text('R345D'),
                value: 'R345D',
                groupValue: name,
                onChanged: (String? value) {
                  if (value == null) {
                    return;
                  }
                  yName.value = value;
                },
              ),
            ],
          );
        });
  }

  Widget _buildEvaluateBestFeaturesButton() {
    return FilledButton(
      style: const ButtonStyle(
        fixedSize: WidgetStatePropertyAll<Size?>(Size(200, 60)),
        backgroundColor: WidgetStatePropertyAll<Color?>(BlueLightColor.s900),
      ),
      onPressed: isLoading
          ? null
          : () async {
              getFormula();
            },
      child: Text(
        'Evaluate',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
      ),
    );
  }

  Widget _buildGender(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: gender,
      builder: (context, gen, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('Male'),
              value: 'male',
              groupValue: gen,
              onChanged: (String? value) {
                if (value == null) {
                  return;
                }
                gender.value = value;
              },
            ),
            RadioListTile<String>(
              title: const Text('Female'),
              value: 'female',
              groupValue: gen,
              onChanged: (String? value) {
                if (value == null) {
                  return;
                }
                gender.value = value;
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTeethSelector(BuildContext context) {
    if (requiredFeatures == null) {
      return const SizedBox.shrink();
    }
    return TeethInputsForm(
      formKey: _formKey,
      features: requiredFeatures!,
      onChanged: (String feature, double value) {
        featuresValues[feature] = value;
      },
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Row(
      children: [
        FilledButton(
          style: const ButtonStyle(
            fixedSize: WidgetStatePropertyAll<Size?>(Size(200, 60)),
            backgroundColor: WidgetStatePropertyAll<Color?>(BlueLightColor.s900),
          ),
          onPressed: isLoading
              ? null
              : () async {
                  calculateFinalRes();
                },
          child: Text(
            'Calculate',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
          ),
        ),
        const Gap(16),
        OutlinedButton(
          onPressed: widget.onReset,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: BlueLightColor.s900, width: 3),
            fixedSize: const Size(200, 60),
          ),
          child: Text(
            'Reset',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const Gap(16),
        FilledButton(
          style: const ButtonStyle(
            fixedSize: WidgetStatePropertyAll<Size?>(Size(400, 60)),
            backgroundColor: WidgetStatePropertyAll<Color?>(ErrorColor.s900),
          ),
          onPressed: isLoading
              ? null
              : () async {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return CustomCalculatorPage();
                  }));
                },
          child: Text(
            "I don't have these measurements",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }

  double evaluateFormula(String formula, Map<String, double> variables) {
    // Replace variables in the formula string
    variables.forEach((key, value) {
      formula = formula.replaceAll(key, value.toString());
    });

    // Split the formula into terms and evaluate each term
    List<String> terms = formula.split(RegExp(r'\s*\+\s*'));
    double result = 0.0;

    for (var term in terms) {
      if (term.contains('*')) {
        List<String> factors = term.split('*');
        double termResult = 1.0;
        for (var factor in factors) {
          termResult *= double.parse(factor);
        }
        result += termResult;
      } else {
        result += double.parse(term);
      }
    }

    return result;
  }

  void getFormula() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });
      Uri uri = Uri.parse('https://thanhthaoml.pythonanywhere.com/ml');
      String requestBody = jsonEncode({
        'gender': gender.value,
        'yName': yName.value,
        'features': existingFeatures,
      });
      http.Response data = await http.post(uri, body: requestBody, headers: {'content-type': 'application/json'});

      dynamic decodedData = jsonDecode(data.body)['content'];
      String? retFormula = decodedData['formula'];
      List<String>? retFeatures =
          List.generate(decodedData['features'].length, (index) => decodedData['features'][index].toString());

      setState(() {
        formula = retFormula;
        requiredFeatures = retFeatures;
      });
    } catch (err, stack) {
      logger.e('HALLO', error: err, stackTrace: stack);
      error = '${err.toString()} $stack';
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void calculateFinalRes() {
    _formKey.currentState?.validate();
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    if (formula == null || featuresValues.isEmpty) {
      setState(() {
        error = 'Something went wrong. Click Reset Button to try again';
      });
    }

    final double result = evaluateFormula(formula!, featuresValues);

    setState(() {
      finalRes = result;
    });
  }
}
