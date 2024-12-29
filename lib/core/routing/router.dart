// GoRouter configuration
import 'package:go_router/go_router.dart';
import 'package:yolk/core/routing/routes.dart';
import 'package:yolk/ui/auth/auth_screen.dart';
import 'package:yolk/ui/create/create_screen.dart';
import 'package:yolk/ui/home/home_screen.dart';

/// The main application router configuration.
final router = GoRouter(
  initialLocation: Routes.home.path,
  routes: [
    GoRoute(
      // Adding `name` to your routes. Allows you navigate by name
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
    GoRoute(
      name: Routes.auth.name,
      path: Routes.auth.path,
      builder: (context, state) => const AuthScreen(),
    ),
  ],
);
