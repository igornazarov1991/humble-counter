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

  static const String appInfo = '''This is a counting app that allows you to: 
          
* check if a number is prime (a number that is only divisible by 1 and itself) 
          
* compute the “nth” prime (this is actually doing an API request to Wolfram Alpha, a scientific computing API)

* ask for a fact about a number (which actually makes a request to an external API service for the fact)

* save and share your favorite facts.

The app is inspired by the series of Point Free episodes and was born as a result of my first steps of learning Flutter. 
''';

  static const String pointFreeUrl = 'https://pointfree.co';
  static const String wolframAlphaUrl = 'https://wolframalpha.com';
  static const String numbersApiUrl = 'http://numbersapi.com';
  static const String flutterUrl = 'https://flutter.dev';
}

abstract final class Styles {
  static ButtonStyle textButtonStyle = TextButton.styleFrom(
    foregroundColor: Colors.white,
    textStyle: const TextStyle(
      fontSize: 20,
    ),
  );

  static TextStyle linkTextStyle = const TextStyle(
    decoration: TextDecoration.underline,
    color: Colors.blue,
  );
}