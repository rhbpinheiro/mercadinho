// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

import 'package:mercadinho/src/models/item_carrinho.dart';
import 'package:mercadinho/src/pages/common_widgets/widget_add_quantidade.dart';

class ItemTileCart extends StatefulWidget {
  const ItemTileCart({
    super.key,
    required this.cartItem,
    required this.remove,
  });
  final CartItemModel cartItem;
  final Function(CartItemModel) remove;

  @override
  State<ItemTileCart> createState() => _ItemTileCartState();
}

class _ItemTileCartState extends State<ItemTileCart> {
  int quantityItem = 1;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Image.asset(
          widget.cartItem.item.imgUrl,
          height: 60,
          width: 60,
        ),
        title: Text(
          widget.cartItem.item.itemName,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(UtilBrasilFields.obterReal(widget.cartItem.totalPrice()),
            style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            )),
        trailing: WidgetAddQuantidade(
          value: widget.cartItem.quantity,
          unidade: widget.cartItem.item.unit,
          isRemovable: true,
          result: (quantity) {
            setState(() {
              widget.cartItem.quantity = quantity;
              if (quantity == 0) {
                widget.remove(widget.cartItem);
              }
            });
          },
        ),
      ),
    );
  }
}
