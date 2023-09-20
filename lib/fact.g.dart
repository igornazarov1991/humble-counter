// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fact _$FactFromJson(Map<String, dynamic> json) => Fact(
      number: json['number'] as int,
      fact: json['fact'] as String,
    );

Map<String, dynamic> _$FactToJson(Fact instance) => <String, dynamic>{
      'number': instance.number,
      'fact': instance.fact,
    };
