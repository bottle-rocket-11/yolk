import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Auth states represent the current authentication state of the user.
abstract class AuthState extends Equatable {
  /// Creates a new [AuthState].
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// The [AuthInitialState] authentication state has not been initialized yet.
class AuthInitialState extends AuthState {}

/// The [AuthAuthenticatedState] state indicates that the user is authenticated.
class AuthAuthenticatedState extends AuthState {
  /// Creates a new [AuthAuthenticatedState] state.
  const AuthAuthenticatedState(this.user);

  /// The authenticated user.
  final User user;

  @override
  List<Object?> get props => [user];
}

/// The [AuthUnauthenticatedState] state indicates that the user is not
///
/// authenticated.
class AuthUnauthenticatedState extends AuthState {}
