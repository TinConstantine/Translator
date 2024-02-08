import 'package:flutter/material.dart';

const colorWhite = Color.fromRGBO(255, 255, 255, 100);
const colorAppBar = Color.fromRGBO(0, 51, 102, 100);
const colorPurple = Color.fromRGBO(103, 80, 164, 5);
const colorGrey = Color.fromRGBO(255, 251, 254, 100);
const colorOrange = Color.fromRGBO(255, 102, 0, 100);
const colorBlack = Colors.black;
const homePageIcon = 'assets/icons/icon_translate.png';
const cameraIcon = 'assets/icons/icon_camera.png';
const historyIcon = 'assets/icons/icon_history.png';
const starIcon = 'assets/icons/icon_star.png';
const bookIcon = 'assets/icons/icon_book.png';
const flagVie = 'assets/icons/icon_vietnam.png';
const flagEng = 'assets/icons/icon_english.png';
const logo = 'assets/icons/logo.png';

TextStyle robotoMedium({double size = 18, required Color color}) {
  return TextStyle(
      color: color, fontFamily: 'Roboto', fontWeight: FontWeight.w500);
}

TextStyle robotoRegular({double? size, Color? color}) {
  return TextStyle(
      color: color, fontFamily: 'Roboto', fontWeight: FontWeight.w400);
}

Color mixColorsWithRatio(Color color1, Color color2, double ratio) {
  int red = ((color1.red * ratio) + (color2.red * (1.0 - ratio))).round();
  int green = ((color1.green * ratio) + (color2.green * (1.0 - ratio))).round();
  int blue = ((color1.blue * ratio) + (color2.blue * (1.0 - ratio))).round();

  return Color.fromARGB(255, red, green, blue);
}
