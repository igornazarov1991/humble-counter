import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:humble_counter/facts/fact.dart';

class FactsContainer extends ChangeNotifier {
  List<Fact> _items = [];
  UnmodifiableListView<Fact> get items => UnmodifiableListView(_items);

  FactsContainer() {
    read();
  }

  void read() async {
    try {
      final file = await localFile;
      final contents = await file.readAsString();
      List<dynamic> json = jsonDecode(contents);
      List<Fact> facts = json.map((item) => Fact.fromJson(item)).toList();
      _items = facts;
      notifyListeners();
    } catch (error) {
      if (kDebugMode) { print(error); }
    }

    notifyListeners();
  }

  void write() async {
    try {
      final file = await localFile;
      String json = jsonEncode(_items);
      file.writeAsString(json);
    } catch (error) {
      if (kDebugMode) { print(error); }
    }
  }

  void addFact(Fact fact) {
    if (_items.map((item) => item.number).toList().contains(fact.number)) {
      return;
    }

    _items.add(fact);
    notifyListeners();
    write();
  }

  void removeAt(int index) {
    _items.removeAt(index);
    notifyListeners();
    write();
  }
}