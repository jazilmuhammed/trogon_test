import 'dart:math';
import 'dart:ui';

class ColorClass{

  static const Color lightMint = Color(0xFFECFFF0);
  static const Color lightPink = Color(0xFFFFECF3);
  static const Color lightPeach = Color(0xFFFFF5E7);
  static const Color lightCyan = Color(0xFFDAFFFF);
  static const Color lightBlue = Color(0xFFECF0FF);
  static const Color mintGreen = Color(0xFFECFFF0);
  static const Color cyan = Color(0xFFDAFFFF);
   static Color getRandomColor() {
    final random = Random();
    // List of all colors
    List<Color> colors = [
      lightMint,
      lightPink,
      lightPeach,
      lightCyan,
      lightBlue,
      mintGreen,
      cyan
    ];
    // Pick a random color from the list
    return colors[random.nextInt(colors.length)];
  }
}