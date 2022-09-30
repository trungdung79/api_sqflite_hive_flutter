import 'package:json_annotation/json_annotation.dart';

part 'food_model.g.dart';

@JsonSerializable()
class FoodModel {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'thumbnail')
  String? thumbnail;

  @JsonKey(name: 'decscription')
  String? description;

  FoodModel();

  FoodModel.name1({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.description
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) =>
      _$FoodModelFromJson(json);

  Map<String, dynamic> toJson() => _$FoodModelToJson(this);
}
