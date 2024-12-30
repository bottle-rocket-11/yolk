import 'package:supabase_flutter/supabase_flutter.dart';

/// Repository for handling user authentication
abstract class AuthRepository {
  /// Signs in user with Google
  Future<void> signInWithGoogle();

  /// Signs in user with Apple
  Future<void> signInWithApple();

  /// Get's a stream of the current user
  Stream<User?> getCurrentUserStream();

  /// Gets the current user
  User? getCurrentUser();

  /// Gets the current session
  Session? getCurrentSession();

  /// Signs out the current user
  Future<void> signOut();
}
