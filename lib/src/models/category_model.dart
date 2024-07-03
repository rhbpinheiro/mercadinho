// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

import 'package:mercadinho/src/models/item_model.dart';

part "category_model.g.dart";

@JsonSerializable()
class CategoryModel {
  final String id;
  final String title;
  @JsonKey(defaultValue: [])
  List<ItemModel> items;
  @JsonKey(defaultValue: 0)
  int pagination;
  CategoryModel({
    required this.id,
    required this.title,
    required this.items,
    required this.pagination,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  @override
  String toString() => 'CategoryModel(id: $id, title: $title)';
}
