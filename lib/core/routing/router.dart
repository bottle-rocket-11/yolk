// GoRouter configuration
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yolk/bloc/auth/auth_bloc.dart';
import 'package:yolk/bloc/auth/auth_state.dart';
import 'package:yolk/core/di.dart';
import 'package:yolk/core/routing/routes.dart';
import 'package:yolk/ui/auth/auth_screen.dart';
import 'package:yolk/ui/create/create_screen.dart';
import 'package:yolk/ui/home/home_screen.dart';

/// The main application router configuration.
final GoRouter router = GoRouter(
  initialLocation: Routes.home.path,
  refreshListenable: StreamToListenable([getIt<AuthBloc>().stream]),
  redirect: (context, state) {
    final isAuthenticated = getIt<AuthBloc>().state is AuthAuthenticatedState;
    final isUnAuthenticated =
        getIt<AuthBloc>().state is AuthUnauthenticatedState;

    // Redirect to the login page if the user is not authenticated,
    //
    // and if authenticated, do not show the login page
    if (isUnAuthenticated &&
        !state.matchedLocation.contains(Routes.home.path)) {
      return Routes.auth.path;
    }
    // Redirect to the home page if the user is authenticated
    else if (isAuthenticated) {
      return Routes.home.path;
    }
    return null;
  },
  routes: [
    // Adding `name` to your routes. Allows you navigate by name
    GoRoute(
      name: Routes.auth.name,
      path: Routes.auth.path,
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      name: Routes.home.name,
      path: Routes.home.path,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          name: Routes.create.name,
          path: Routes.create.path,
          builder: (context, state) => const CreateTaskScreen(),
        ),
      ],
    ),
  ],
);

/// A [ChangeNotifier] that listens to a list of streams and notifies listeners
class StreamToListenable extends ChangeNotifier {
  /// Creates a new [StreamToListenable] instance.
  StreamToListenable(List<Stream<dynamic>> streams) {
    subscriptions = [];
    for (final e in streams) {
      final s = e.asBroadcastStream().listen(_tt);
      subscriptions.add(s);
    }
    notifyListeners();
  }

  /// The list of subscriptions
  late final List<StreamSubscription<dynamic>> subscriptions;

  @override
  void dispose() {
    for (final e in subscriptions) {
      e.cancel();
    }
    super.dispose();
  }

  void _tt(event) => notifyListeners();
}
