/// Defines navigation routes for the application.
enum Routes {
  /// The home screen route.
  home('/'),

  /// The create screen route.
  create('/create'),

  /// Authentication screen route
  auth('/auth');

  /// Creates a new instance of the [Routes] enum.
  const Routes(this.path);

  /// The path for the route.
  final String path;
}
