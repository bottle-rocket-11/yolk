import 'package:yolk/core/configs/onboarding_type.dart';

/// Extension methods for the [OnboardingType] enum.
extension OnboardingTypeExt on OnboardingType {
  /// Returns the message for the onboarding type.
  String get message {
    switch (this) {
      case OnboardingType.login:
        return 'Sign in';
      case OnboardingType.register:
        return 'Create an account';
    }
  }
}
