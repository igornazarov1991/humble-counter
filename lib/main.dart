import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:humble_counter/configs.dart';
import 'package:humble_counter/counter/counter.dart';
import 'package:humble_counter/counter/counter_page.dart';
import 'package:humble_counter/facts/facts_container.dart';
import 'package:provider/provider.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Counter()),
        ChangeNotifierProvider(create: (context) => FactsContainer()),
      ],
      child: const MyApp(),
    ),
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
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          background: AppColors.background,
          onBackground: Colors.white,
          primary: AppColors.primary,
          onPrimary: Colors.white,
          secondary: Colors.blue,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          surface: AppColors.primary,
          onSurface: Colors.white,
        ),
      ),
      home: const CounterPage(title: 'Humble Counter'),
    );
  }
}
