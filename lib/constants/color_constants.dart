// ignore_for_file: constant_identifier_names, use_full_hex_values_for_flutter_colors, non_constant_identifier_names
import 'dart:math' as math;

import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static Color get PRIMARY => const Color(0xFFf76b40);
  static Color get PURPLE => const Color(0xFF693565);

  static Color bgColor(BuildContext context) {
    return const Color(0xFFfef7fb);
  }

  static Color storeBgColor(BuildContext context) {
    return const Color(0xFFF3D1DD);
  }

  static Color primaryGradient(BuildContext context) {
    return const Color(0xFFF76B41);
  }

  static MaterialColor primaryMaterial(BuildContext context) {
    return const Color(0xFFf76b41).mapped;
  }

  static Color primary(BuildContext context) {
    return const Color(0xFFF76B41);
  }

  static Color primaryLight(BuildContext context) {
    return const Color(0xFFFCB78E);
  }

  static Color primaryTint(BuildContext context) {
    return const Color(0xffffeee9);
  }

  static Color lottie_bgColor(BuildContext context) {
    return const Color(0xffEBEBEB);
  }

  static Color primaryTintDark(BuildContext context) {
    return const Color(0xffffd3c3);
  }

  static Color primaryTintPikish(BuildContext context) {
    return const Color(0xffFCDBDB);
  }

  static Color primaryGraph(BuildContext context) {
    return const Color(0xffFF9C65);
  }

  static Color purpleDark(BuildContext context) {
    return const Color(0xFF3F0049);
  }

  static Color purple(BuildContext context) {
    return const Color(0xFF693565);
  }

  static Color purpleMedium(BuildContext context) {
    return const Color(0xFFA058AB);
  }

  static Color purpleLight(BuildContext context) {
    return const Color(0xFFE79DFF);
  }

  static Color purpleLightVariant(BuildContext context) {
    return const Color(0xFFA777AE);
  }

  static Color purpleChat(BuildContext context) {
    return const Color(0xFFC89CF6);
  }

  static Color purple_AE75D4(BuildContext context) {
    return const Color(0xFFAE75D4);
  }

  static Color purple_F3D1DD(BuildContext context) {
    return const Color(0xFFF3D1DD);
  }

  static Color greyPurpleTint(BuildContext context) {
    return const Color(0xFF727288);
  }

  static Color black(BuildContext context) {
    return const Color(0xFF000000);
  }

  static MaterialColor grey(BuildContext context) {
    return Colors.grey;
  }

  static Color greyMedium(BuildContext context) {
    return const Color(0xFF605E5E);
  }

  static Color greyDark_646262(BuildContext context) {
    return const Color(0xFF646262);
  }

  static Color greyDark_797676(BuildContext context) {
    return const Color(0xFF797676);
  }

  static Color onboardingText(BuildContext context) {
    return const Color(0xFF797676);
  }

  static Color onboardingPurple(BuildContext context) {
    return const Color(0xFF62195A);
  }

  static Color white(BuildContext context) {
    return const Color(0xFFFFFFFF);
  }

  static Color whiteReturned(BuildContext context) {
    return const Color(0xffD3D3D3);
  }

  static Color greenDark(BuildContext context) {
    return const Color(0xFF034902);
  }

  static Color green(BuildContext context) {
    return const Color(0xFF038500);
  }

  static Color greenApproved(BuildContext context) {
    return const Color(0xFF2ca444);
  }

  static Color greenLight(BuildContext context) {
    return const Color(0xFFB5E29F);
  }

  static Color greenTint(BuildContext context) {
    return const Color(0xFF71DA6F);
  }

  static Color yellow(BuildContext context) {
    return const Color(0xFFFFFAA0);
  }

  static Color yellowPending(BuildContext context) {
    return const Color(0xFFfac204);
  }

  static Color yellowDark(BuildContext context) {
    return const Color(0xFF9b870c);
  }

  static Color orangeReturnRequest(BuildContext context) {
    return const Color(0xffFF4B33);
  }

  static MaterialColor red(BuildContext context) {
    return Colors.red;
  }

  static Color redDark(BuildContext context) {
    return const Color(0xffaf0404);
  }

  static Color redOutOfStock(BuildContext context) {
    return const Color(0xffdc3444);
  }

  static Color redSchema(BuildContext context) {
    return const Color(0xffB3261E);
  }

  static Color redRejected(BuildContext context) {
    return const Color(0xff8B0000);
  }

  static Color blue(BuildContext context) {
    return const Color(0xff0093fd);
  }

  static Color blueDark(BuildContext context) {
    return const Color(0xff0c498f);
  }

  static Color blueLight(BuildContext context) {
    return const Color(0xff75CBEE);
  }

  static Color random = Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
}

class RandomColorGenerator {
  static Color? _lastColor;
  static final Map<String, Color?> _colorHashTable = {};

  static Color generate(String? key) {
    if (key != null) {
      if (_colorHashTable.keys.contains(key)) {
        Color? c = _colorHashTable[key];
        if (c != null) return c;
      }
    }
    const minDifference = 50;
    Color newColor;

    do {
      newColor = Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    } while (_lastColor != null && _colorDifference(newColor, _lastColor!) < minDifference);

    _lastColor = newColor;
    if (key != null) _colorHashTable[key] = newColor;
    return newColor;
  }

  static int _colorDifference(Color c1, Color c2) {
    final rDiff = (c1.red - c2.red).abs();
    final gDiff = (c1.green - c2.green).abs();
    final bDiff = (c1.blue - c2.blue).abs();
    return rDiff + gDiff + bDiff;
  }
}

class AppGradients {
  const AppGradients._();

  static LinearGradient subscriptionGradient(BuildContext context) {
    const color1 = Color(0xffF76B41);
    const color2 = Color(0xffFCD6C0);
    return const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [color1, color2],
    );
  }
}

extension GetInvertedColor on Color {
  Color get inverted {
    final r = 255 - red;
    final g = 255 - green;
    final b = 255 - blue;
    return Color.fromARGB((opacity * 255).round(), r, g, b);
  }
}

extension GetMaterialColor on Color {
  MaterialColor get mapped {
    Map<int, Color> colorMap = {
      50: _lighten(0.8), // Lightest
      100: _lighten(0.7),
      150: _lighten(0.6),
      200: _lighten(0.5),
      250: _lighten(0.4),
      300: _lighten(0.3),
      350: _lighten(0.2),
      400: this, // Original color
      450: _darken(0.1),
      500: _darken(0.2),
      550: _darken(0.3),
      600: _darken(0.4),
      650: _darken(0.5),
      700: _darken(0.6),
      800: _darken(0.7),
      900: _darken(0.8), // Darkest
    };

    return MaterialColor(value, colorMap);
  }

  Color _lighten(double amount) {
    return Color.fromARGB(
      alpha,
      (red + (255 - red) * amount).toInt(),
      (green + (255 - green) * amount).toInt(),
      (blue + (255 - blue) * amount).toInt(),
    );
  }

  Color _darken(double amount) {
    return Color.fromARGB(
      alpha,
      (red * (1 - amount)).toInt(),
      (green * (1 - amount)).toInt(),
      (blue * (1 - amount)).toInt(),
    );
  }
}

extension GetShade on MaterialColor {
  Color get shade150 => this[150] ?? shade400;
  Color get shade250 => this[250] ?? shade400;
  Color get shade350 => this[350] ?? shade400;
  Color get shade450 => this[450] ?? shade400;
  Color get shade550 => this[550] ?? shade400;
  Color get shade650 => this[650] ?? shade400;
}
