import 'package:supabase_flutter/supabase_flutter.dart';

/// Repository for handling user authentication
abstract class AuthRepository {
  /// Signs in user with Google
  Future<void> signInWithGoogle();

  /// Signs in user with Apple
  Future<void> signInWithApple();

  /// Signs out the current user
  Future<void> signOut();

  /// Gets the current user
  User? getUser();

  /// Gets the current session
  Session? getSession();
}
