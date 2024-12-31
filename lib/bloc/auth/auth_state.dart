import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Auth states represent the current authentication state of the user.
abstract class AuthState extends Equatable {
  /// Creates a new [AuthState].
  const AuthState({
    required this.isLoadingApple,
    required this.isLoadingGoogle,
  });

  /// Creates a copy of the [AuthState] state with the provided
  ///
  /// parameters.
  AuthState copyWith({
    bool? isLoadingApple,
    bool? isLoadingGoogle,
  }) {
    return AuthInitialState(
      isLoadingApple: isLoadingApple ?? this.isLoadingApple,
      isLoadingGoogle: isLoadingGoogle ?? this.isLoadingGoogle,
    );
  }

  /// Indicates if the user is currently signing in with Apple.
  final bool isLoadingApple;

  /// Indicates if the user is currently signing in with Google.
  final bool isLoadingGoogle;

  @override
  List<Object?> get props => [isLoadingApple, isLoadingGoogle];
}

/// The [AuthInitialState] authentication state has not been initialized yet.
class AuthInitialState extends AuthState {
  /// Creates a new [AuthInitialState] state.
  const AuthInitialState({
    super.isLoadingApple = false,
    super.isLoadingGoogle = false,
  });
}

/// The [AuthAuthenticatedState] state indicates that the user is authenticated.
class AuthAuthenticatedState extends AuthState {
  /// Creates a new [AuthAuthenticatedState] state.
  const AuthAuthenticatedState({
    required this.user,
    super.isLoadingApple = false,
    super.isLoadingGoogle = false,
  });

  /// Creates a copy of the [AuthAuthenticatedState] state with the provided
  ///
  /// parameters.
  @override
  AuthAuthenticatedState copyWith({
    User? user,
    bool? isLoadingApple,
    bool? isLoadingGoogle,
  }) {
    return AuthAuthenticatedState(
      user: user ?? this.user,
      isLoadingApple: isLoadingApple ?? this.isLoadingApple,
      isLoadingGoogle: isLoadingGoogle ?? this.isLoadingGoogle,
    );
  }

  /// The authenticated user.
  final User user;

  @override
  List<Object?> get props => [user];
}

/// The [AuthErrorState] state indicates that the user is not
///
/// authenticated.
class AuthErrorState extends AuthState {
  /// Creates a new [AuthErrorState] state.
  const AuthErrorState({
    required this.error,
    super.isLoadingApple = false,
    super.isLoadingGoogle = false,
  });

  /// The authentication error.
  final AuthException error;
}

/// The [AuthUnauthenticatedState] state indicates that the user is not
///
/// authenticated.
class AuthUnauthenticatedState extends AuthState {
  /// Creates a new [AuthUnauthenticatedState] state.
  const AuthUnauthenticatedState({
    super.isLoadingApple = false,
    super.isLoadingGoogle = false,
  });
}
