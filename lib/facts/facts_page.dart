import 'package:flutter/material.dart';
import 'package:humble_counter/configs.dart';

class FactsPage extends StatefulWidget {
  const FactsPage({super.key});

  @override
  State<FactsPage> createState() => _FactsPageState();
}

class _FactsPageState extends State<FactsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainBackground,
        foregroundColor: Colors.white,
        title: const Text('Facts'),
      ),
      body: const Center(
        child: Text('Facts list'),
      ),
    );
  }
}
