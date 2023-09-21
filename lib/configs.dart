import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color background = Color.fromRGBO(21, 28, 36, 1.0);
  static const Color primary = Color.fromRGBO(0, 74, 121, 1.0);
}

abstract final class AppInsets {
  static const EdgeInsets standard = EdgeInsets.all(12);
}

abstract final class Constants {
  static const BorderRadius standardRadius = BorderRadius.all(Radius.circular(10));
}

abstract final class Styles {
  static ButtonStyle textButtonStyle = TextButton.styleFrom(
    foregroundColor: Colors.white,
    textStyle: const TextStyle(
      fontSize: 20,
    ),
  );
}