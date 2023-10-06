import 'package:humble_counter/wolframalpha/query_result.dart';
import 'package:json_annotation/json_annotation.dart';
part 'wolfram_alpha_result.g.dart';

@JsonSerializable(explicitToJson: true)
class WolframAlphaResult {
  QueryResult queryresult;

  WolframAlphaResult(this.queryresult);

  factory WolframAlphaResult.fromJson(Map<String, dynamic> json) =>
      _$WolframAlphaResultFromJson(json);
  Map<String, dynamic> toJson() => _$WolframAlphaResultToJson(this);
}