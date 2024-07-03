// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel {
  final String id;
  @JsonKey(name: 'picture')
  final String imgUrl;
  @JsonKey(name: 'title')
  final String itemName;
  final double price;
  final String unit;
  final String description;

  ItemModel({
    this.id = "",
    required this.imgUrl,
    required this.itemName,
    required this.price,
    required this.unit, 
    required this.description,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);

  @override
  String toString() {
    return 'ItemModel(id: $id, imgUrl: $imgUrl, itemName: $itemName, price: $price, unit: $unit, description: $description)';
  }
}
