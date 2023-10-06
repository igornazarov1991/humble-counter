// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wolfram_alpha_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WolframAlphaResult _$WolframAlphaResultFromJson(Map<String, dynamic> json) =>
    WolframAlphaResult(
      QueryResult.fromJson(json['queryresult'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WolframAlphaResultToJson(WolframAlphaResult instance) =>
    <String, dynamic>{
      'queryresult': instance.queryresult.toJson(),
    };
