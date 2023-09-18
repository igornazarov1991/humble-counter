import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CounterPage(title: 'Humble Counter'),
    );
  }
}

class Counter with ChangeNotifier {
  int value = 0;
  String? fact;
  bool isLoadingFact = false;
  bool isTimerOn = false;

  Timer? _timer;

  void decrement() {
    value --;
    notifyListeners();
  }

  void increment() {
    value ++;
    notifyListeners();
  }

  void toggleTimer() {
    isTimerOn = !isTimerOn;
    notifyListeners();

    if (isTimerOn) {
      _timer = Timer.periodic(
          const Duration(seconds: 1),
              (timer) {
            value ++;
            notifyListeners();
          }
      );
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
