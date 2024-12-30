import 'package:flutter/material.dart';

const String _fontFamily = 'Asap';

/// A class containing the app's theme configurations.
///
/// This class handles the visual styling and appearance settings
/// for the application, including color schemes, text styles,
/// and other theme-related properties.
class YolkThemes {
  /// Theme data configuration for the light theme of the application.
  ///
  /// Defines the base theme properties for the application's light mode,
  /// including colors, text styles, widget themes and visual properties used
  /// throughout the app when in light mode.
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: _fontFamily, // Choose a calming font
    primaryColor: Colors.blue[100], // Sky blue
    scaffoldBackgroundColor: Colors.grey[50], // Soft, off-white
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[50], // Slightly darker sky blue
      elevation: 0, // Flat app bar for a clean look
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.grey[700], // Dark grey for contrast
      ),
      bodyMedium: TextStyle(
        color: Colors.grey[600], // Slightly lighter grey for body text
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue[100]!, //  Base color for accents
      secondary: Colors.amber[200], //  Sunrise orange as a secondary
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.amber[300], // Slightly darker sunrise orange
      foregroundColor: Colors.grey[800],
    ),
  );

  /// Creates the dark theme for the application.
  ///
  /// A [ThemeData] instance that defines the dark color scheme and visual
  /// properties used throughout the app when dark mode is enabled.
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: _fontFamily,
    primaryColor: Colors.purple[800], // Deep night sky blue
    scaffoldBackgroundColor: Colors.grey[850], // Dark background
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[850], // Even deeper night sky blue
      elevation: 0,
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        color: Colors.grey[50], // Light grey for contrast
      ),
      bodyMedium: TextStyle(
        color: Colors.grey[300], // Lighter grey for body text
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: Colors.purple[800]!,
      secondary: Colors.pink[300], //  Moonlight purple as secondary
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.pink[400], // Slightly darker moonlight purple
      foregroundColor: Colors.grey[100],
    ),
  );
}
