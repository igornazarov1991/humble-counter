import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:humble_counter/facts/fact.dart';

class Counter with ChangeNotifier {
  int value = 0;
  String? fact;
  bool isLoadingFact = false;
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
}