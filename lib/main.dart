import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yolk/core/di.dart';
import 'package:yolk/core/routing/router.dart';
import 'package:yolk/core/theme/theme.dart';
import 'package:yolk/env.dart';

void main() async {
  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: '<your-supabase-anon-key>',
  );

  // Configures the dependency injection container.
  configureDependencies();
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
    return MaterialApp.router(
      title: 'Yolk: Tasks and Habits',
      theme: YolkThemes.lightTheme,
      darkTheme: YolkThemes.darkTheme,
      routerConfig: router,
    );
  }
}
