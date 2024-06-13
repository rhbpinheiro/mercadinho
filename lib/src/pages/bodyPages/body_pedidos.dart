import 'package:flutter/material.dart';
import 'package:mercadinho/src/components/pedido_tile.dart';
import 'package:mercadinho/src/config/app_data.dart' as appData;

class BodyPedidos extends StatefulWidget {
  const BodyPedidos({super.key});

  @override
  State<BodyPedidos> createState() => _BodyPedidosState();
}

String selectedCategory = 'Frutas';

class _BodyPedidosState extends State<BodyPedidos> {
  TextEditingController emailController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.green,
            title: const Text(
              "Pedidos",
              style: TextStyle(
                color: Colors.white,
              ),
            )),
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (_, index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemBuilder: (_, index) {
            return PedidoTile(
              pedido: appData.pedidos[index],
            );
          },
          itemCount: appData.pedidos.length,
        ));
  }
}
