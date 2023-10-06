import 'package:humble_counter/wolframalpha/subpod.dart';
import 'package:json_annotation/json_annotation.dart';
part 'pod.g.dart';

@JsonSerializable(explicitToJson: true)
class Pod {
  bool? primary;
  List<Subpod> subpods;

  Pod(this.primary, this.subpods);

  factory Pod.fromJson(Map<String, dynamic> json) =>
      _$PodFromJson(json);
  Map<String, dynamic> toJson() => _$PodToJson(this);
}