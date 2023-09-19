import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:humble_counter/counter.dart';

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
        useMaterial3: true,
      ),
      home: const CounterPage(title: 'Humble Counter'),
    );
  }
}
