import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Auth events are used to trigger changes in the authentication state.
abstract class AuthEvent extends Equatable {
  /// Creates a new [AuthEvent].
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

/// The [AuthInitialCheckRequestedEvent] is used to check if the user is already
/// authenticated
class AuthInitialCheckRequestedEvent extends AuthEvent {}

/// Auth events that trigger authentication-related state changes
class AuthOnCurrentUserChangedEvent extends AuthEvent {
  /// Creates a new [AuthOnCurrentUserChangedEvent].
  const AuthOnCurrentUserChangedEvent(this.user);

  /// The current user
  final User? user;
}

/// The [AuthGooglePressedEvent] is used to sign in a user with Google
class AuthGooglePressedEvent extends AuthEvent {}

/// The [AuthApplePressedEvent] is used to sign in a user with Appl
class AuthApplePressedEvent extends AuthEvent {}

/// The [AuthLogoutPressedEvent] is used to sign out a user
class AuthLogoutPressedEvent extends AuthEvent {}
