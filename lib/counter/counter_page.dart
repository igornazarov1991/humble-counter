import 'package:flutter/material.dart';
import 'package:humble_counter/configs.dart';
import 'package:humble_counter/counter/counter.dart';
import 'package:humble_counter/facts/fact.dart';
import 'package:humble_counter/facts/facts_container.dart';
import 'package:humble_counter/facts/facts_page.dart';
import 'package:provider/provider.dart';

import '../info/info_page.dart';

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
      appBar: _buildAppBar(),
      body: Consumer<Counter>(
        builder: (context, counter, child) => Column(
          children: [
            _buildCounterDisplay(counter),
            _buildCounterChanger(counter),
            _buildTimer(counter),
            _buildFact(counter),
            _buildPrimerVerifier(counter),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Text(widget.title),
      leading: IconButton(
        icon: const Icon(Icons.info_outline),
        iconSize: 30,
        onPressed: () { _showInfo(context); },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.list),
          iconSize: 30,
          onPressed: () { _showFacts(context); },
        ),
      ],
    );
  }
  
  Widget _buildCounterDisplay(Counter counter) {
    return Text(
      '${counter.value}',
      style: const TextStyle(
        fontSize: 50,
      ),
    );
  }
  
  Widget _buildCounterChanger(Counter counter) {
    return _Section(
        child: Column(
          children: [
            _ActionButton(
              onPressed: counter.decrement,
              title: const Text('Decrement'),
            ),
            _ActionButton(
                onPressed: counter.increment,
                title: const Text('Increment'),
            ),
            _ActionButton(
              onPressed: counter.randomize,
              title: const Text('Random'),
            ),
            _ActionButton(
              onPressed: counter.zero,
              title: const Text('Zero'),
            ),
          ],
        ),
    );
  }
  
  Widget _buildTimer(Counter counter) {
    return _Section(
      child: _ActionButton(
        onPressed: counter.toggleTimer,
        title: Text(counter.isTimerOn ? 'Stop timer' : 'Start timer'),
      ),
    );
  }
  
  Widget _buildFact(Counter counter) {
    return _Section(
        child: Column(
          children: [
            _ActionButton(
              onPressed: counter.getFact,
              title: const Text('Get fact'),
              hasActivityIndicator: counter.isLoadingFact,
            ),
            if (counter.fact != null) _buildFactDisplay(counter),
          ],
        ),
    );
  }
  
  Widget _buildFactDisplay(Counter counter) {
    return Column(
      children: [
        Container(
          padding: AppInsets.standard,
          child: Text('"${counter.fact}"'),
        ),
        _ActionButton(
          onPressed: () { _saveFact(counter: counter); },
          title: const Text('Save'),
        ),
      ],
    );
  }

  Widget _buildPrimerVerifier(Counter counter) {
    return _Section(
      child: _ActionButton(
        onPressed: () { checkIsPrime(counter); },
        title: const Text('Is prime?'),
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
    Provider.of<FactsContainer>(context, listen: false).addFact(factToSave);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Fact saved')));
  }

  void _showInfo(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const InfoPage(),
        fullscreenDialog: true,
      ),
    );
  }

  void checkIsPrime(Counter counter) async {
    Future.delayed(const Duration(milliseconds: 1000));

    final isPrime = counter.isPrime();
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          isPrime
              ? '${counter.value} is a prime number'
              : '${counter.value} is not a prime number',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.onPressed,
    required this.title,
    this.hasActivityIndicator = false,
  });

  final VoidCallback onPressed;
  final Widget title;
  final bool hasActivityIndicator;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          style: Styles.textButtonStyle,
          onPressed: onPressed,
          child: title,
        ),
        const Spacer(),
        if (hasActivityIndicator == true) _ActivityIndicator(),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.standard,
      child: Container(
        padding: AppInsets.standard,
        decoration: BoxDecoration(
          borderRadius: Constants.standardRadius,
          color: Theme.of(context).colorScheme.primary,
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