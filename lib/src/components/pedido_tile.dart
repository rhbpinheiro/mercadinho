// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

import 'package:mercadinho/src/components/pedido_status.dart';
import 'package:mercadinho/src/components/widget_qrcode_pix.dart';
import 'package:mercadinho/src/models/pedidos_model.dart';

class PedidoTile extends StatelessWidget {
  const PedidoTile({
    super.key,
    required this.pedido,
  });
  final PedidosModel pedido;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        elevation: 2,
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
          ),
          child: ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            initiallyExpanded: pedido.sttatus == 'peding_payment',
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Pedido ${pedido.id}',
                  style: const TextStyle(color: Colors.green),
                ),
                Text(
                  "Data ${UtilData.obterDataDDMMAAAA(pedido.dataPedido)} "
                  "${UtilData.obterHoraHHMM(pedido.dataPedido)}",
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            children: [
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: 150,
                        child: ListView(
                            children: pedido.items.map((e) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  '${e.quantity} ${e.item.unit} ',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    e.item.itemName,
                                  ),
                                ),
                                Text(UtilBrasilFields.obterReal(
                                  e.totalPrice(),
                                )),
                              ],
                            ),
                          );
                        }).toList()),
                      ),
                    ),
                    VerticalDivider(
                      color: Colors.grey.shade300,
                      thickness: 2,
                      width: 15,
                    ),
                    Expanded(
                        flex: 2,
                        child: PedidoStatus(
                          status: pedido.sttatus,
                          pixVencido: pedido.dataValidadeQrCode.isBefore(
                            DateTime.now(),
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text.rich(
                TextSpan(
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  children: [
                    const TextSpan(
                      text: 'Total ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: UtilBrasilFields.obterReal(
                        pedido.total,
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: pedido.sttatus == 'peding_payment',
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return WidgetQrcodePix(
                            pedido: pedido,
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.pix,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Ver QR Code Pix',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
