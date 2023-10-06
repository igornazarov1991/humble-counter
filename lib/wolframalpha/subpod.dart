import 'package:json_annotation/json_annotation.dart';
part 'subpod.g.dart';

@JsonSerializable(explicitToJson: true)
class Subpod {
  String plaintext;

  Subpod(this.plaintext);

  factory Subpod.fromJson(Map<String, dynamic> json) =>
      _$SubpodFromJson(json);
  Map<String, dynamic> toJson() => _$SubpodToJson(this);
}
