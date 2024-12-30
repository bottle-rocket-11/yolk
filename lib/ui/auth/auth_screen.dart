import 'package:auth_buttons/auth_buttons.dart'
    show AppleAuthButton, AuthButtonStyle, AuthButtonType, GoogleAuthButton;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yolk/core/constants/padding.dart';
import 'package:yolk/core/constants/spacing.dart';
import 'package:yolk/core/routing/routes.dart';

/// A screen widget that handles user authentication.
///
/// This screen is responsible for displaying authentication-related UI elements
/// and managing the authentication flow for users to sign in or register.
///
/// The widget is stateless as it likely relies on external state management
/// for handling authentication state and user data.
class AuthScreen extends StatefulWidget {
  /// Creates a new instance of the [AuthScreen] widget.
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: AppSpacing.sm,
            children: [
              Image.asset(
                'assets/icon/icon.png',
                height: 200,
              ),
              Text(
                'Welcome',
                textAlign: TextAlign.center,
                style: textTheme.headlineLarge,
              ),
              Text(
                'Get ready to simplify your life',
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge,
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: AppSpacing.md,
                children: [
                  GoogleAuthButton(
                    style: const AuthButtonStyle(
                      elevation: 0,
                      buttonType: AuthButtonType.icon,
                    ),
                    onPressed: () {
                      context.go(Routes.home.path);
                    },
                  ),
                  AppleAuthButton(
                    style: const AuthButtonStyle(
                      elevation: 0,
                      buttonType: AuthButtonType.icon,
                    ),
                    onPressed: () {
                      context.go(Routes.home.path);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
