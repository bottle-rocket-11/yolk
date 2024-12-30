import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;
import 'package:yolk/bloc/auth/auth_event.dart';
import 'package:yolk/bloc/auth/auth_state.dart';
import 'package:yolk/repository/auth_repository.dart';

/// The [AuthBloc] manages the authentication state of the user.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /// Creates a new [AuthBloc].
  AuthBloc(this._authRepository) : super(AuthInitialState()) {
    on<AuthOnCurrentUserChangedEvent>(_onCurrentUserChanged);
    on<AuthGooglePressedEvent>(_onSignInWithGoogle);
    on<AuthLogoutPressedEvent>(_onSignOut);

    _startUserSubscription();
  }

  final AuthRepository _authRepository;
  StreamSubscription<User?>? _userSubscription;

  Future<void> _onSignInWithGoogle(
    AuthGooglePressedEvent event,
    Emitter<AuthState> emit,
  ) async {}

  Future<void> _onCurrentUserChanged(
    AuthOnCurrentUserChangedEvent event,
    Emitter<AuthState> emit,
  ) async =>
      event.user != null
          ? emit(AuthAuthenticatedState(event.user!))
          : emit(AuthUnauthenticatedState());

  Future<void> _onSignOut(
    AuthLogoutPressedEvent event,
    Emitter<AuthState> emit,
  ) async {}

  void _startUserSubscription() => _userSubscription = _authRepository
      .getCurrentUserStream()
      .listen((user) => add(AuthOnCurrentUserChangedEvent(user)));

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
