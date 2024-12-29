import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:yolk/core/di.config.dart';

/// A global instance of the service locator.
final getIt = GetIt.instance;

/// Configures the dependency injection container.
@InjectableInit()
void configureDependencies() => getIt.init();
