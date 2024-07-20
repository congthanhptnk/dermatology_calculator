import 'dart:convert';

import 'package:dermatology_calculator/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:http/http.dart' as http;
import 'package:logger/web.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MyApp());
}

var logger = Logger();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: BlueLightColor.s700),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> existingFeatures = ['R1T', 'R1D', 'R2T', 'R2D', 'R6T', 'R6D'];
  final List<String> selectedFeatures = [];

  List<String>? requiredFeatures;
  String? formula;

  final ValueNotifier<String> gender = ValueNotifier('female');
  final ValueNotifier<String> yName = ValueNotifier('R345D');
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: BlueLightColor.s50,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1000),
          alignment: Alignment.center,
          child: ListView(
            children: [
              _buildSections(
                title: 'Teeth',
                body: SizedBox(
                  height: 500,
                  width: 500,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: existingFeatures.length,
                    itemBuilder: (BuildContext context, int index) {
                      bool selected = selectedFeatures.contains(existingFeatures[index]);
                      return ListTile(
                        selectedColor: Colors.red,
                        title: Text(existingFeatures[index]),
                        selected: selected,
                        onTap: () {
                          if (selected) {
                            setState(() {
                              selectedFeatures.remove(existingFeatures[index]);
                            });
                          } else {
                            setState(() {
                              selectedFeatures.add(existingFeatures[index]);
                            });
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),
              _buildSections(
                title: 'Gender',
                body: SizedBox(
                  width: 200,
                  child: ValueListenableBuilder(
                      valueListenable: gender,
                      builder: (context, gen, child) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
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
                          ],
                        );
                      }),
                ),
              ),
              SizedBox(height: 16),
              _buildSections(
                title: 'Y Name',
                body: SizedBox(
                  width: 200,
                  child: ValueListenableBuilder(
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
                      }),
                ),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () async {
                  if (selectedFeatures.isEmpty) {
                    return;
                  }
                  try {
                    Uri uri = Uri.parse('https://thanhthaoml.pythonanywhere.com/ml');
                    String requestBody = jsonEncode({
                      'gender': gender.value,
                      'yName': yName.value,
                      'features': selectedFeatures,
                    });
                    http.Response data =
                        await http.post(uri, body: requestBody, headers: {'content-type': 'application/json'});

                    dynamic decodedData = jsonDecode(data.body)['content'];
                    String? retFormula = decodedData['formula'];
                    List<String>? retFeatures = List.generate(
                        decodedData['features'].length, (index) => decodedData['features'][index].toString());

                    setState(() {
                      formula = retFormula;
                      requiredFeatures = retFeatures;
                    });
                  } catch (err, stack) {
                    logger.e('HALLO', error: err, stackTrace: stack);
                  }
                },
                child: Text('hello world'),
              ),
              SizedBox(height: 16),
              if (formula != null) Text(formula!),
              if (requiredFeatures != null) ...[
                for (String feature in requiredFeatures!) ...[
                  Text(feature),
                  TextField(
                    onChanged: (String? value) {
                      if (value != null && value.isNotEmpty && double.tryParse(value) != null) {
                        setState(() {
                          featuresValues[feature] = double.tryParse(value)!;
                        });
                      }
                    },
                  )
                ]
              ],
              SizedBox(height: 16),
              if (formula != null)
                TextButton(
                  onPressed: () async {
                    if (formula?.isEmpty ?? true) {
                      return;
                    }
                    setState(() {
                      finalRes = evaluateFormula(formula!, featuresValues);
                    });
                  },
                  child: Text('Calculate'),
                ),
              if (finalRes != 0) Text(finalRes.toString()),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, double> featuresValues = {};
  double finalRes = 0;

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

  Widget _buildSections({required String title, required Widget body}) {
    return Card.filled(
      color: BlueLightColor.s100,
      shadowColor: BlueLightColor.s100,
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            body,
          ],
        ),
      ),
    );
  }

  final OutlineInputBorder _fieldBorder = OutlineInputBorder(borderRadius: BorderRadius.circular(16));

  InputDecoration getInput() {
    return InputDecoration(
      alignLabelWithHint: true,
      isDense: false,
      fillColor: GrayLightColor.s100,
      contentPadding: const EdgeInsets.only(
        left: 12,
        top: 12,
        bottom: 8,
      ),
      enabledBorder: _fieldBorder,
      border: _fieldBorder,
      focusedBorder: _fieldBorder.copyWith(
        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1),
      ),
      focusedErrorBorder: _fieldBorder.copyWith(
        borderSide: const BorderSide(color: ErrorColor.s500, width: 1),
      ),
      errorBorder: _fieldBorder.copyWith(borderSide: const BorderSide(color: ErrorColor.s500, width: 1)),
    );
  }
}
