import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// A [StatelessWidget] based application which serves as the root widget of
/// this app.
///
/// This widget defines the basic structure and theme of the application.
/// It is typically used to configure app-wide settings such as themes,
/// localization, and routing.
class MyApp extends StatelessWidget {
  /// A stateless widget that serves as the root of the Yolk application.
  ///
  /// The [MyApp] widget is created with a constant constructor,
  /// allowing Flutter to optimize the widget's rendering performance.
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

/// A stateful widget representing the main home page of the application.
///
/// This widget is the primary container for the home page content and manages
/// its own state, allowing it to update dynamically based on user interactions
/// or other events.
class MyHomePage extends StatefulWidget {
  /// A page widget representing the main home screen of the application.
  ///
  /// Requires a [title] parameter which sets the title of the home page.
  /// This widget is immutable and should be constructed using the const
  /// constructor.
  ///
  /// Example:
  /// ```dart
  /// MyHomePage(title: 'My App Home')
  /// ```
  const MyHomePage({required this.title, super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  /// The title to be displayed.
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
