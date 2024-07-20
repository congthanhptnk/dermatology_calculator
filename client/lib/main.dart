import 'package:dermatology_calculator/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

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
              _buildSections(title: 'Gender', body: Text('hello world')),
              SizedBox(height: 16),
              _buildSections(
                title: 'Gender',
                body: SizedBox(
                  width: 200,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Bro'),
                      TextField(
                        decoration: getInput(),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              _buildSections(title: 'Gender', body: Text('hello world')),
              SizedBox(height: 16),
              _buildSections(title: 'Gender', body: Text('hello world')),
              SizedBox(height: 16),
              _buildSections(title: 'Gender', body: Text('hello world')),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
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
