// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mercadinho/src/models/item_model.dart';

import '../common_widgets/widget_add_quantidade.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({
    super.key,
    required this.item,
  });

  final ItemModel item;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int quantityItem = 1;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(230),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Hero(
                        tag: widget.item.imgUrl,
                        child: Image.network(widget.item.imgUrl)),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 40,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(45),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.item.itemName,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 27,
                                  ),
                                ),
                              ),
                              WidgetAddQuantidade(
                                unidade: widget.item.unit,
                                value: quantityItem,
                                result: (quantity) {
                                  setState(() {
                                    quantityItem = quantity;
                                  });
                                },
                              )
                            ],
                          ),
                          Text(
                            UtilBrasilFields.obterReal(widget.item.price),
                            style: const TextStyle(
                              fontSize: 23,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: SingleChildScrollView(
                                child: Text(
                                  widget.item.description,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    18,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Get.back();
                                // navigationController
                                //     .navigatePageView(NavigationTabs.cart);
                              },
                              icon: const Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.white,
                              ),
                              label: const Text(
                                'Add ao carrinho',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 10,
                left: 10,
                child: SafeArea(
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
