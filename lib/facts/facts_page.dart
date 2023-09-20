import 'package:flutter/material.dart';
import 'package:humble_counter/configs.dart';
import 'package:humble_counter/facts/fact.dart';
import 'package:humble_counter/facts/facts_container.dart';
import 'package:provider/provider.dart';

class _FactsListItem extends StatelessWidget {
  _FactsListItem({required this.fact}) : super(key: ObjectKey(fact));

  final Fact fact;

  @override
  Widget build(BuildContext context) {
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
          ),
      ),
    );
  }
}

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
                return _FactsListItem(fact: fact);
              },
              separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 30),
            );
          } else {
            return _buildEmptyList();
          }
        },
      ),
    );
  }

  Widget _buildEmptyList() {
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
