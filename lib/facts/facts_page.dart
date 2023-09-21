import 'package:flutter/material.dart';
import 'package:humble_counter/configs.dart';
import 'package:humble_counter/facts/fact.dart';
import 'package:humble_counter/facts/facts_container.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class _FactsListItem extends StatelessWidget {
  _FactsListItem({
    required this.fact,
    required this.onShare,
  }) : super(key: ObjectKey(fact));

  final Fact fact;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () { onShare(); },
      child: Container(
        padding: AppInsets.standard,
        decoration: BoxDecoration(
          borderRadius: Constants.standardRadius,
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(fact.fact),
            ),
          ],
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
      appBar: _buildAppBar(),
      body: Consumer<FactsContainer>(
        builder: (context, container, child) {
          if (container.items.isNotEmpty) {
            return ListView.separated(
              padding: AppInsets.standard,
              itemCount: container.items.length,
              itemBuilder: (BuildContext context, int index) {
                final fact = container.items[index];
                return Dismissible(
                  key: ObjectKey(fact),
                  onDismissed: (direction) { removeAt(index); },
                  child: _FactsListItem(
                    fact: fact,
                    onShare: () { shareAt(index); },
                  ),
                );
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

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: const Text('Facts'),
    );
  }

  Widget _buildEmptyList() {
    return const Center(
      child: Text(
        'No facts',
        style: TextStyle(
          fontSize: 30,
        ),
      ),
    );
  }

  void removeAt(int index) {
    Provider.of<FactsContainer>(context, listen: false).removeAt(index);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Fact removed')));
  }

  void shareAt(int index) {
    final fact = Provider.of<FactsContainer>(context, listen: false).items[index];
    Share.share(fact.fact);
  }
}
