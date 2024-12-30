import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yolk/repository/auth_repository.dart';

/// An implementation of the [AuthRepository] interface.
@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  /// Creates an instance of [AuthRepositoryImpl].
  AuthRepositoryImpl(this._supabase);

  final Supabase _supabase;

  @override
  Future<AuthResponse> signInWithApple() async {
    final rawNonce = _supabase.client.auth.generateRawNonce();
    final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();

    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: hashedNonce,
    );

    final idToken = credential.identityToken;
    if (idToken == null) {
      throw const AuthException(
        'Could not find ID Token from generated credential.',
      );
    }

    return _supabase.client.auth.signInWithIdToken(
      provider: OAuthProvider.apple,
      idToken: idToken,
      nonce: rawNonce,
    );
  }

  @override
  Future<void> signInWithGoogle() async {
    /// Web Client ID that you registered with Google Cloud.
    const webClientId = 'my-web.apps.googleusercontent.com';

    /// iOS Client ID that you registered with Google Cloud.
    const iosClientId = 'my-ios.apps.googleusercontent.com';

    final googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      debugPrint('No Access Token found.');
    }
    if (idToken == null) {
      debugPrint('No ID Token found.');
      return;
    }

    await _supabase.client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  @override
  Session? getCurrentSession() => _supabase.client.auth.currentSession;

  @override
  User? getCurrentUser() => _supabase.client.auth.currentUser;

  @override
  Stream<User?> getCurrentUserStream() =>
      _supabase.client.auth.onAuthStateChange
          .map((event) => event.session?.user);

  @override
  Future<void> signOut() async {
    await _supabase.client.auth.signOut();
  }
}
