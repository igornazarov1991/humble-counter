import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Counter(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CounterPage(title: 'Humble Counter'),
    );
  }
}

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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Consumer<Counter>(
          builder: (context, counter, child) => Column(
            children: [
              Text('${counter.value}'),
              TextButton(
                onPressed: counter.decrement,
                child: const Text('Decrement'),
              ),
              TextButton(
                onPressed: counter.increment,
                child: const Text('Increment'),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      TextButton(
                        onPressed: counter.getFact,
                        child: const Text('Get fact'),
                      ),
                      if (counter.isLoadingFact) const CircularProgressIndicator(),
                    ],
                  ),
                  if (counter.fact != null) Text('${counter.fact}'),
                ],
              ),
              TextButton(
                onPressed: counter.toggleTimer,
                child: Text(counter.isTimerOn ? 'Stop timer' : 'Start timer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
