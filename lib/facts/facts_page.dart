import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:humble_counter/configs.dart';
import 'package:humble_counter/facts/facts_container.dart';

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
      backgroundColor: AppColors.mainBackground,
      body: Consumer<FactsContainer>(
        builder: (context, container, child) {
          if (container.items.isNotEmpty) {
            return ListView.separated(
              padding: AppInsets.standard,
              itemCount: container.items.length,
              itemBuilder: (BuildContext context, int index) {
                final fact = container.items[index];
                return Container(
                  padding: AppInsets.standard,
                  decoration: const BoxDecoration(
                    borderRadius: Constants.standardRadius,
                    color: AppColors.secondaryBackground,
                  ),
                  child: Text(
                      fact.fact,
                      style: const TextStyle(
                        color: Colors.white,
                        // fontSize: 30,
                      )
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 30),
            );
          } else {
            return const Center(
              child: Text(
                'No facts',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            );
          }
        }
      ),
    );
  }
}
