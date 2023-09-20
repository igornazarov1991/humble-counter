import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:humble_counter/facts/fact.dart';

class Counter with ChangeNotifier {
  int value = 0;
  String? fact;
  bool isLoadingFact = false;
  bool isSavingFact = false;
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

  void saveFact() {
    final factString = fact;
    if (factString != null) {
      isSavingFact = true;
      notifyListeners();

      final factToWrite = Fact(number: value, fact: factString);
      writeFact(factToWrite);
    }
  }

  void toggleTimer() {
    isTimerOn = !isTimerOn;
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