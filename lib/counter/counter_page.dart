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
            Expanded(
              child: ListView(
                children: [
                  _buildCounterChanger(counter),
                  _buildTimer(counter),
                  _buildFact(counter),
                  _buildPrimerVerifier(counter),
                ],
              ),
            ),
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
            ListTile(
              leading: const Icon(Icons.remove),
              title: const Text('Decrement'),
              splashColor: Colors.transparent,
              onTap: counter.decrement,
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Increment'),
              splashColor: Colors.transparent,
              onTap: counter.increment,
            ),
            ListTile(
              leading: const Icon(Icons.shuffle),
              title: const Text('Random'),
              splashColor: Colors.transparent,
              onTap: counter.randomize,
            ),
            ListTile(
              leading: const Icon(Icons.exposure_zero),
              title: const Text('Zero'),
              splashColor: Colors.transparent,
              onTap: counter.zero,
            ),
          ],
        ),
    );
  }
  
  Widget _buildTimer(Counter counter) {
    return _Section(
      child: ListTile(
        leading: const Icon(Icons.timer_outlined),
        title: Text(counter.isTimerOn ? 'Stop timer' : 'Start timer'),
        splashColor: Colors.transparent,
        onTap: counter.toggleTimer,
      ),
    );
  }
  
  Widget _buildFact(Counter counter) {
    return _Section(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.fact_check_outlined),
              trailing: counter.isLoadingFact ? _ActivityIndicator() : null,
              title: const Text('Get fact'),
              splashColor: Colors.transparent,
              onTap: counter.getFact,
            ),
            if (counter.fact != null) _buildFactDisplay(counter),
          ],
        ),
    );
  }
  
  Widget _buildFactDisplay(Counter counter) {
    return Column(
      children: [
        Text('"${counter.fact}"'),
        ListTile(
          leading: const Icon(Icons.save_outlined),
          title: const Text('Save'),
          splashColor: Colors.transparent,
          onTap: () { _saveFact(counter: counter); },
        ),
      ],
    );
  }

  Widget _buildPrimerVerifier(Counter counter) {
    return _Section(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.task_outlined),
            title: const Text('Is this prime?'),
            splashColor: Colors.transparent,
            onTap: () { checkIsPrime(counter); },
          ),
          ListTile(
            leading: const Icon(Icons.task_outlined),
            trailing: counter.isLoadingNthPrime ? _ActivityIndicator() : null,
            title: Text('What is the ${counter.value.ordinal} prime?'),
            splashColor: Colors.transparent,
            onTap: () { checkNthPrime(counter); },
          ),
        ],
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
        icon: isPrime ? const Icon(Icons.check) : const Icon(Icons.warning),
        iconColor: Colors.white,
        content: Text(
          isPrime
              ? '${counter.value} is a prime number'
              : '${counter.value} is not a prime number',
        ),
      ),
    );
  }

  void checkNthPrime(Counter counter) async {
    if (counter.value <= 0) {
      showErrorDialog('Counter should be greater than 0 to calculate prime numbers');
      return;
    }

    final number = await counter.getNthPrime();
    final title = 'The ${counter.value.ordinal} prime is $number';
    showNthPrimeDialog(title);
  }

  void showErrorDialog(String title) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text(title),
      ),
    );
  }

  void showNthPrimeDialog(String title) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text(title),
      ),
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
      child: child,
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