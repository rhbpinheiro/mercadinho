// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mercadinho/src/models/item_carrinho.dart';

class PedidosModel {
  String id;
  DateTime dataPedido;
  DateTime dataValidadeQrCode;
  List<CartItemModel> items;
  String sttatus;
  String copiaECola;
  double total;
  PedidosModel({
    required this.id,
    required this.dataPedido,
    required this.dataValidadeQrCode,
    required this.items,
    required this.sttatus,
    required this.copiaECola,
    required this.total,
  });
}
