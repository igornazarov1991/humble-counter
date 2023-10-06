// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pod.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pod _$PodFromJson(Map<String, dynamic> json) => Pod(
      json['primary'] as bool?,
      (json['subpods'] as List<dynamic>)
          .map((e) => Subpod.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PodToJson(Pod instance) => <String, dynamic>{
      'primary': instance.primary,
      'subpods': instance.subpods.map((e) => e.toJson()).toList(),
    };
