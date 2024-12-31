import 'package:auth_buttons/auth_buttons.dart'
    show AppleAuthButton, AuthButtonStyle, AuthButtonType, GoogleAuthButton;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import 'package:yolk/bloc/auth/auth_bloc.dart';
import 'package:yolk/bloc/auth/auth_event.dart';
import 'package:yolk/bloc/auth/auth_state.dart';
import 'package:yolk/core/configs/onboarding_type.dart';
import 'package:yolk/core/constants/padding.dart';
import 'package:yolk/core/constants/spacing.dart';
import 'package:yolk/core/extensions/onboarding_type_ext.dart';

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
  OnboardingType _onboardingType = OnboardingType.login;

  void _switchAuthType() {
    if (_onboardingType == OnboardingType.login) {
      setState(() {
        _onboardingType = OnboardingType.register;
      });
    } else {
      setState(() {
        _onboardingType = OnboardingType.login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, authState) {
        if (authState is AuthErrorState) {
          toastification.show(
            title: const Text('Error signing in'),
            description: Text(authState.error.message),
          );
        }
      },
      builder: (context, authState) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: AppSpacing.md,
                children: [
                  Image.asset(
                    'assets/icon/icon.png',
                    height: 200,
                  ),
                  Text(
                    _onboardingType.message,
                    textAlign: TextAlign.center,
                    style: textTheme.headlineMedium,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: AppSpacing.xs,
                    children: [
                      Text(
                        'Already have an account?',
                        style: textTheme.bodyLarge,
                      ),
                      GestureDetector(
                        onTap: _switchAuthType,
                        child: Text(
                          'Sign in',
                          style: textTheme.bodyLarge?.copyWith(
                            color: theme.hintColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppSpacing.md,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: AppSpacing.lg,
                    children: [
                      GoogleAuthButton(
                        isLoading: authState.isLoadingGoogle,
                        style: const AuthButtonStyle(
                          elevation: 0,
                          buttonType: AuthButtonType.icon,
                        ),
                        onPressed: () {
                          context
                              .read<AuthBloc>()
                              .add(AuthGooglePressedEvent());
                        },
                      ),
                      if (defaultTargetPlatform == TargetPlatform.iOS)
                        AppleAuthButton(
                          isLoading: authState.isLoadingApple,
                          style: const AuthButtonStyle(
                            elevation: 0,
                            buttonType: AuthButtonType.icon,
                          ),
                          onPressed: () {
                            context
                                .read<AuthBloc>()
                                .add(AuthApplePressedEvent());
                          },
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
