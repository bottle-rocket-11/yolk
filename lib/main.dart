import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yolk/bloc/auth/auth_bloc.dart';
import 'package:yolk/core/di.dart';
import 'package:yolk/core/routing/router.dart';
import 'package:yolk/core/theme/theme.dart';
import 'package:yolk/env.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.supabaseApiKey,
  );

  // Configures the dependency injection container.
  configureDependencies();

  await SentryFlutter.init(
    (options) {
      options
        ..dsn = Env.sentryDsn
        // Set tracesSampleRate to 1.0 to capture 100% of transactions for
        // tracing. We recommend adjusting this value in production.
        ..tracesSampleRate = 1.0
        // The sampling rate for profiling is relative to tracesSampleRate
        // Setting to 1.0 will profile 100% of sampled transactions:
        ..profilesSampleRate = 1.0;
    },
    appRunner: () => runApp(const MyApp()),
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthBloc>()),
      ],
      child: MaterialApp.router(
        title: 'Yolk: Tasks and Habits',
        theme: YolkThemes.lightTheme,
        darkTheme: YolkThemes.darkTheme,
        routerConfig: router,
      ),
    );
  }
}
