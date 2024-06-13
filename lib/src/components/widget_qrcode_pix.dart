// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:mercadinho/src/models/pedidos_model.dart';

class WidgetQrcodePix extends StatelessWidget {
  final PedidosModel pedido;
  const WidgetQrcodePix({
    super.key,
    required this.pedido,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Pagamento com Pix',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                QrImageView(
                  data: '123456789',
                  version: QrVersions.auto,
                  size: 200.0,
                ),
                Text(
                  'Vencimento: '
                  '${UtilData.obterDataDDMMAAAA(pedido.dataValidadeQrCode)} '
                  '${UtilData.obterHoraHHMMSS(pedido.dataValidadeQrCode)} ',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  'Total: ${UtilBrasilFields.obterReal(pedido.total)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.green),
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.copy,
                    color: Colors.green,
                  ),
                  label: const Text(
                    'Copiar código Pix',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
