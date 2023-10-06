import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:humble_counter/wolframalpha/wolfram_alpha_result.dart';

Future<int> nthPrime(int n) async {
  final url = Uri.parse('https://api.wolframalpha.com/v2/query?input=prime%20$n&format=plaintext&output=json&appid=J6GGH6-W8PQ67R68G');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final decoded = json.decode(response.body) as Map<String, dynamic>;
    final result = WolframAlphaResult.fromJson(decoded);
    final text = result
        .queryresult
        .pods
        .firstWhere((element) => element.primary == true)
        .subpods
        .first
        .plaintext;
    final number = int.parse(text);
    return number;
  } else {
    throw Exception('Failed to load nth prime');
  }
}