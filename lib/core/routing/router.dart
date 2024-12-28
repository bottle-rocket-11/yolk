// GoRouter configuration
import 'package:go_router/go_router.dart';
import 'package:yolk/ui/auth/auth_screen.dart';
import 'package:yolk/ui/home/home_screen.dart';

/// Defines navigation routes for the application.
enum Routes {
  /// The home screen route.
  home('/'),

  /// Authentication screen route
  auth('/auth');

  /// Creates a new instance of the [Routes] enum.
  const Routes(this.path);

  /// The path for the route.
  final String path;
}

/// The main application router configuration.
final router = GoRouter(
  initialLocation: Routes.home.path,
  routes: [
    GoRoute(
      // Adding `name` to your routes. Allows you navigate by name
      name: Routes.home.name,
      path: Routes.home.path,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      name: Routes.auth.name,
      path: Routes.auth.path,
      builder: (context, state) => const AuthScreen(),
    ),
  ],
);
