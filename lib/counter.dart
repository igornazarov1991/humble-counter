import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:humble_counter/configs.dart';

Future<String> fetchFact(int number) async {
  final response = await http
      .get(Uri.parse('http://www.numbersapi.com/$number'));

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load fact');
  }
}

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
                    if (counter.fact != null) Text(
                      '"${counter.fact}"',
                      style: const TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                )
            ),
          ],
        ),
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