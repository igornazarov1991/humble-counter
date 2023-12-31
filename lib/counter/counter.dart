import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:humble_counter/wolframalpha/wolfram_alpha.dart';

class Counter with ChangeNotifier {
  int value = 0;
  String? fact;
  bool isLoadingFact = false;
  bool isLoadingNthPrime = false;
  bool isTimerOn = false;

  Timer? _timer;

  void decrement() {
    value -= 1;
    fact = null;
    stopTimerIfNeeded();
    notifyListeners();
  }

  void increment() {
    value += 1;
    fact = null;
    stopTimerIfNeeded();
    notifyListeners();
  }

  void randomize() {
    value = Random().nextInt(1000);
    fact = null;
    stopTimerIfNeeded();
    notifyListeners();
  }

  void zero() {
    value = 0;
    fact = null;
    stopTimerIfNeeded();
    notifyListeners();
  }

  void getFact() async {
    fact = null;
    stopTimerIfNeeded();
    isLoadingFact = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      fact = await fetchFact(value);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }

    isLoadingFact = false;
    notifyListeners();
  }

  void toggleTimer() {
    isTimerOn = !isTimerOn;
    fact = null;
    notifyListeners();

    if (isTimerOn) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        value++;
        notifyListeners();
      });
    } else {
      _timer?.cancel();
    }
  }

  void stopTimerIfNeeded() {
    isTimerOn = false;
    _timer?.cancel();
  }

  bool isPrime() {
    stopTimerIfNeeded();
    notifyListeners();

    if (value <= 1) { return false; }
    if (value <= 3) { return true; }
    for (var i = 2; i <= sqrt(value).toInt(); i++) {
      if (value % i == 0) { return false; }
    }
    return true;
  }

  Future<int> getNthPrime() async {
    isLoadingNthPrime = true;
    notifyListeners();

    final number = await nthPrime(value);

    isLoadingNthPrime = false;
    notifyListeners();

    return number;
  }
}

extension Ordinals on int {
  String get ordinal {
    switch (this % 10) {
      case 1:
        return '${this}st';
      case 2:
        return '${this}nd';
      case 3:
        return '${this}rd';
      default:
        return '${this}th';
    }
  }
}

Future<String> fetchFact(int number) async {
  final url = Uri.parse('http://www.numbersapi.com/$number');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load fact');
  }
}