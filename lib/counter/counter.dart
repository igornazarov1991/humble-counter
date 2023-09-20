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
    notifyListeners();
  }

  void increment() {
    value += 1;
    fact = null;
    notifyListeners();
  }

  void randomize() {
    value = Random().nextInt(1000);
    fact = null;
    notifyListeners();
  }

  void zero() {
    value = 0;
    fact = null;
    notifyListeners();
  }

  void getFact() async {
    fact = null;
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
}