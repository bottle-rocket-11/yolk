import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toastification/toastification.dart';
import 'package:yolk/bloc/auth/auth_bloc.dart';
import 'package:yolk/core/di.dart';
import 'package:yolk/core/routing/router.dart';
import 'package:yolk/core/theme/theme.dart';
import 'package:yolk/env.dart';

void main() async {
  // Initialize Supabase
  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.supabaseApiKey,
  );

  // Configures the dependency injection container.
  configureDependencies();

  // Wrap the app in a MultiBlocProvider to provide blocs to the app.
  final multiBlocProvider = MultiBlocProvider(
    providers: [
      BlocProvider(create: (BuildContext context) => getIt<AuthBloc>()),
    ],
    child: const ToastificationWrapper(child: MyApp()),
  );

  // Initialize Sentry for error tracking.
  await SentryFlutter.init(
    (options) => options
      ..dsn = Env.sentryDsn
      ..release = 'yolk@1.0.0'
      ..environment = 'production',
    appRunner: () => runApp(
      multiBlocProvider,
    ),
  );
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
