import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:mercadinho/src/components/item_tile_cart.dart';
import 'package:mercadinho/src/components/widget_qrcode_pix.dart';
import 'package:mercadinho/src/config/app_data.dart' as appData;
import 'package:mercadinho/src/models/item_carrinho.dart';
import 'package:mercadinho/src/utils/utils_service.dart';

class BodyCart extends StatefulWidget {
  const BodyCart({super.key});

  @override
  State<BodyCart> createState() => _BodyCartState();
}

String selectedCategory = 'Frutas';

final UtilsService utilsService = UtilsService();

class _BodyCartState extends State<BodyCart> {
  void removeCartItem(CartItemModel cartItem) {
    setState(() {
      appData.cartItems.remove(cartItem);
      utilsService.showToast(
        isError: false,
        message: '${cartItem.item.itemName} removido(a) do carrinho',
      );
    });
  }

  double cartTotalPrice() {
    double total = 0;
    for (var item in appData.cartItems) {
      total += item.totalPrice();
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.green,
          title: const Text(
            "Carrinho",
            style: TextStyle(
              color: Colors.white,
            ),
          )),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: appData.cartItems.length,
              itemBuilder: (_, index) {
                return ItemTileCart(
                  cartItem: appData.cartItems[index],
                  remove: removeCartItem,
                );
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 30,
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(45),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    spreadRadius: 2,
                    blurRadius: 3,
                  )
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Geral',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          UtilBrasilFields.obterReal(cartTotalPrice()),
                          style: const TextStyle(
                            fontSize: 23,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade300,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              18,
                            ),
                          ),
                        ),
                        onPressed: () async {
                          bool? result = await showDialogConfirm();
                          if (result ?? false) {
                            await showDialog(
                                context: context,
                                builder: (_) {
                                  return WidgetQrcodePix(
                                    pedido: appData.pedidos.first,
                                  );
                                });
                          } else {
                            utilsService.showToast(
                              isError: true,
                              message: 'Pedido não confirmado',
                            );
                          }
                        },
                        child: const Text(
                          'Concluir Pedido',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> showDialogConfirm() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmação'),
          content: const Text('Deseja realmente concluir o pedido?'),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text(
                'Não',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text(
                'Sim',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
