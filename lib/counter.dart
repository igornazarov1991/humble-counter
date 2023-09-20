import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:humble_counter/configs.dart';
import 'package:humble_counter/fact.dart';
import 'package:humble_counter/facts_page.dart';

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

class CounterPage extends StatefulWidget {
  const CounterPage({super.key, required this.title,});

  final String title;

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainBackground,
        foregroundColor: Colors.white,
        title: Text(widget.title),
        actions: [
          TextButton(
            style: Styles.textButtonStyle,
            onPressed: () {
              _showFacts(context);
            },
            child: const Text('Facts'),
          )
        ],
      ),
      backgroundColor: AppColors.mainBackground,
      body: Consumer<Counter>(
        builder: (context, counter, child) => Column(
          children: [
            Text(
              '${counter.value}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 50,
              ),
            ),
            _Section(
                child: Column(
                  children: [
                    Row(
                      children: [
                        TextButton(
                          style: Styles.textButtonStyle,
                          onPressed: counter.decrement,
                          child: const Text('Decrement'),
                        ),
                        const Spacer(),
                      ],
                    ),
                    Row(
                      children: [
                        TextButton(
                          style: Styles.textButtonStyle,
                          onPressed: counter.increment,
                          child: const Text('Increment'),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ],
                )
            ),
            _Section(
              child: Row(
                children: [
                  TextButton(
                    style: Styles.textButtonStyle,
                    onPressed: counter.toggleTimer,
                    child: Text(counter.isTimerOn ? 'Stop timer' : 'Start timer'),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            _Section(
                child: Column(
                  children: [
                    Row(
                      children: [
                        TextButton(
                          style: Styles.textButtonStyle,
                          onPressed: counter.getFact,
                          child: const Text('Get fact'),
                        ),
                        if (counter.isLoadingFact)
                          _ActivityIndicator(),
                      ],
                    ),
                    if (counter.fact != null) Column(
                      children: [
                        Text(
                          '"${counter.fact}"',
                          style: const TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Row(
                          children: [
                            TextButton(
                              style: Styles.textButtonStyle,
                              onPressed: counter.saveFact,
                              child: const Text('Save'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }

  void _showFacts(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const FactsPage(),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final Widget child;

  const _Section({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.standard,
      child: Container(
        padding: AppInsets.standard,
        decoration: const BoxDecoration(
          borderRadius: Constants.standardRadius,
          color: AppColors.secondaryBackground,
        ),
        child: child,
      ),
    );
  }
}

class _ActivityIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20.0,
      width: 20.0,
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 3.0,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }
}