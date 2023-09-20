import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

part 'fact.g.dart';

@JsonSerializable()
class Fact {
  const Fact({required this.number, required this.fact});

  final int number;
  final String fact;

  factory Fact.fromJson(Map<String, dynamic> json) => _$FactFromJson(json);
  Map<String, dynamic> toJson() => _$FactToJson(this);
}

Future<String> fetchFact(int number) async {
  final response = await http
      .get(Uri.parse('http://www.numbersapi.com/$number'));

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load fact');
  }
}

Future<String> get localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get localFile async {
  final path = await localPath;
  return File('$path/counter.txt');
}