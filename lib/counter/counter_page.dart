import 'package:flutter/material.dart';
import 'package:humble_counter/facts/facts_container.dart';
import 'package:provider/provider.dart';
import 'package:humble_counter/counter/counter.dart';
import 'package:humble_counter/configs.dart';
import 'package:humble_counter/facts/fact.dart';
import 'package:humble_counter/facts/facts_page.dart';

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
                              onPressed: () {
                                _saveFact(counter: counter);
                              },
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

  void _saveFact({required Counter counter}) {
    final fact = counter.fact;
    if (fact == null) { return; }
    final factToSave = Fact(number: counter.value, fact: fact);
    Provider.of<FactsContainer>(context, listen: false).writeFact(factToSave);
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