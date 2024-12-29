import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// A module for registering the Supabase client with the service locator.
@module
abstract class RegisterSupabaseModule {
  /// A singleton instance of the Supabase client.
  Supabase get supabase => Supabase.instance;
}
