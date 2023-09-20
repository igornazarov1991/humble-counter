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

  void writeFact(Fact fact) async {
    if (_items.map((item) => item.number).toList().contains(fact.number)) {
      return;
    }

    try {
      _items.add(fact);
      final file = await localFile;
      String json = jsonEncode(_items);
      file.writeAsString(json);
      notifyListeners();
    } catch (error) {
      if (kDebugMode) { print(error); }
    }
  }
}