// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QueryResult _$QueryResultFromJson(Map<String, dynamic> json) => QueryResult(
      (json['pods'] as List<dynamic>)
          .map((e) => Pod.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QueryResultToJson(QueryResult instance) =>
    <String, dynamic>{
      'pods': instance.pods.map((e) => e.toJson()).toList(),
    };
