import 'package:humble_counter/wolframalpha/pod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'query_result.g.dart';

@JsonSerializable(explicitToJson: true)
class QueryResult {
  List<Pod> pods;

  QueryResult(this.pods);

  factory QueryResult.fromJson(Map<String, dynamic> json) =>
      _$QueryResultFromJson(json);
  Map<String, dynamic> toJson() => _$QueryResultToJson(this);
}