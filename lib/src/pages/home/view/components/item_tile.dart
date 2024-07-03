// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

import 'package:mercadinho/src/models/item_model.dart';
import 'package:mercadinho/src/pages/product/product_page.dart';

class ItemTile extends StatefulWidget {
  const ItemTile({
    super.key,
    required this.item,
    required this.cartAnimationMethod,
  });

  final ItemModel item;

  final void Function(GlobalKey) cartAnimationMethod;

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  final GlobalKey imageGk = GlobalKey();
  bool toogleIcon = true;

  Future<void> switchIcon() async {
    setState(() {
      toogleIcon = false;
    });

    await Future.delayed(
      const Duration(
        microseconds: 3000,
      ),
    );

    setState(() {
      toogleIcon = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductPage(
                  item: widget.item,
                ),
              ),
            );
          },
          child: Card(
            elevation: 1,
            shadowColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Hero(
                      tag: widget.item.imgUrl,
                      child: Container(
                        key: imageGk,
                        child: Image.network(
                          widget.item.imgUrl,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    widget.item.itemName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        UtilBrasilFields.obterReal(widget.item.price),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.green),
                      ),
                      Text(
                        '/${widget.item.unit}',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              topRight: Radius.circular(20),
            ),
            child: Material(
              child: InkWell(
                onTap: () {
                  widget.cartAnimationMethod(imageGk);
                  switchIcon();
                },
                child: Ink(
                  height: 40,
                  width: 35,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                  ),
                  child: Icon(
                    toogleIcon ? Icons.add_shopping_cart_outlined : Icons.check,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
