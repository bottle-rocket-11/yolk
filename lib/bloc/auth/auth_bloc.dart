import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;
import 'package:toastification/toastification.dart';
import 'package:yolk/bloc/auth/auth_event.dart';
import 'package:yolk/bloc/auth/auth_state.dart';
import 'package:yolk/repository/auth_repository.dart';

@lazySingleton

/// The [AuthBloc] manages the authentication state of the user.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /// Creates a new [AuthBloc].
  AuthBloc(this._authRepository) : super(const AuthInitialState()) {
    on<AuthOnCurrentUserChangedEvent>(_onCurrentUserChanged);
    on<AuthGooglePressedEvent>(_onSignInWithGoogle);
    on<AuthApplePressedEvent>(_onSignInWithApple);
    on<AuthLogoutPressedEvent>(_onSignOut);

    _startUserSubscription();
  }

  final AuthRepository _authRepository;
  StreamSubscription<User?>? _userSubscription;

  void _startUserSubscription() => _userSubscription = _authRepository
      .getUserStream()
      .listen((user) => add(AuthOnCurrentUserChangedEvent(user)));

  Future<void> _onSignInWithGoogle(
    AuthGooglePressedEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final currentState = state;
      emit(currentState.copyWith(isLoadingGoogle: true));
      final response = await _authRepository.signInWithGoogle();
      final description = response.user?.email;
      final descriptionWidget = description == null ? null : Text(description);
      toastification.show(
        title: const Text('Signed in'),
        description: descriptionWidget,
      );
      emit(currentState.copyWith(isLoadingGoogle: false));
    } on AuthException catch (error) {
      emit(AuthErrorState(error: error));
    }
  }

  Future<void> _onSignInWithApple(
    AuthApplePressedEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final currentState = state;
      emit(currentState.copyWith(isLoadingApple: true));
      final response = await _authRepository.signInWithApple();
      final description = response.user?.email;
      final descriptionWidget = description == null ? null : Text(description);
      toastification.show(
        title: const Text('Signed in'),
        description: descriptionWidget,
      );
      emit(currentState.copyWith(isLoadingApple: false));
    } on AuthException catch (error) {
      emit(AuthErrorState(error: error));
    } on SignInWithAppleAuthorizationException catch (error) {
      emit(AuthErrorState(error: AuthException(error.toString())));
    } on SignInWithAppleException catch (error) {
      emit(
        AuthErrorState(
          error: AuthException(error.toString()),
        ),
      );
    }
  }

  Future<void> _onCurrentUserChanged(
    AuthOnCurrentUserChangedEvent event,
    Emitter<AuthState> emit,
  ) async =>
      event.user != null
          ? emit(AuthAuthenticatedState(user: event.user!))
          : emit(const AuthUnauthenticatedState());

  Future<void> _onSignOut(
    AuthLogoutPressedEvent event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepository.signOut();
    emit(const AuthUnauthenticatedState());
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
