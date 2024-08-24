import 'dart:convert';

import 'package:dental_calculator/custom_calculator_page.dart';
import 'package:dental_calculator/error_panel.dart';
import 'package:dental_calculator/footer.dart';
import 'package:dental_calculator/language_toggle.dart';
import 'package:dental_calculator/panel_group.dart';
import 'package:dental_calculator/patient_info_radio.dart';
import 'package:dental_calculator/result_panel.dart';
import 'package:dental_calculator/simple_panel.dart';
import 'package:dental_calculator/teeth_inputs_form.dart';
import 'package:dental_calculator/theme.dart';
import 'package:dental_calculator/translations.i18n.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:i18n_extension/i18n_extension.dart';
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
              'Teeth Width Prediction'.i18n,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.white),
            ),
            backgroundColor: BlueLightColor.s700,
            scrolledUnderElevation: 2,
            elevation: 2,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const LanguageToggle(),
                    const Gap(32),
                    FilledButton(
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll<Color?>(BlueLightColor.s900),
                      ),
                      onPressed: () {
                        Locale x = I18n.of(context).locale;
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return I18n(initialLocale: x, child: const CustomCalculatorPage());
                        }));
                      },
                      child: Text(
                        'View Alternative Prediction'.i18n,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const Footer(),
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
                        title: 'Select Gender and Arch'.i18n,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              flex: 1,
                              child: SimplePanel(
                                title: 'Gender'.i18n,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                child: _buildGender(context),
                              ),
                            ),
                            const Gap(24),
                            Expanded(
                              flex: 1,
                              child: SimplePanel(
                                title: 'Arch to predict'.i18n,
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
                          title: 'Below measurements are required for the best predictions'.i18n,
                          description:
                              "If you are unable to provide these, click 'I DON'T HAVE THESE MEASUREMENTS' button to evaluate based on other measurements"
                                  .i18n,
                          child: SimplePanel(
                            title: 'Please provide mesiodistal width (mm) of these teeth'.i18n,
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
    return PatientInfoRadio(
      values: const ['R345T', 'R345D'],
      names: const ['Upper', 'Lower'],
      listenable: yName,
    );
  }

  Widget _buildGender(BuildContext context) {
    return PatientInfoRadio(
      values: const ['male', 'female'],
      names: const ['Male', 'Female'],
      listenable: gender,
    );
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
        'Start'.i18n,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
      ),
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
            'Predict'.i18n,
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
            'Reset'.i18n,
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
                  Locale x = I18n.of(context).locale;
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return I18n(initialLocale: x, child: const CustomCalculatorPage());
                  }));
                },
          child: Text(
            "I don't have these measurements".i18n,
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
        error = 'Something went wrong. Click Reset Button to try again'.i18n;
      });
    }

    final double result = evaluateFormula(formula!, featuresValues);

    setState(() {
      finalRes = result;
    });
  }
}
