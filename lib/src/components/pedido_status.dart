// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class PedidoStatus extends StatelessWidget {
  PedidoStatus({
    super.key,
    required this.status,
    required this.pixVencido,
  });
  final String status;

  final bool pixVencido;

  final Map<String, int> allStatus = <String, int>{
    'peding_payment': 0,
    'refunded': 1,
    'paid': 2,
    'preparing_purchase': 3,
    'shipping': 4,
    'delivered': 5,
  };

  int get currentStatus => allStatus[status]!;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const WidgetStatus(
          isActive: true,
          title: 'Pedido Confirmado',
        ),
        const _WidgetSeparadorStatus(),
        if (currentStatus == 1) ...[
          const WidgetStatus(
            isActive: true,
            title: 'Pix estornado',
            corStatus: Colors.orange,
          ),
        ] else if (pixVencido) ...[
          const WidgetStatus(
            isActive: true,
            title: 'Pagamento pix vencido',
            corStatus: Colors.red,
          ),
        ] else ...[
           WidgetStatus(
            isActive: currentStatus >= 2,
            title: 'Pagamento',
          ),
          const _WidgetSeparadorStatus(),
           WidgetStatus(
            isActive: currentStatus >= 3,
            title: 'Preparando',
          ),
          const _WidgetSeparadorStatus(),
           WidgetStatus(
            isActive: currentStatus >= 4,
            title: 'Envio',
          ),
          const _WidgetSeparadorStatus(),
           WidgetStatus(
            isActive: currentStatus ==5,
            title: 'Entrege',
          ),
        ]
      ],
    );
  }
}

class _WidgetSeparadorStatus extends StatelessWidget {
  const _WidgetSeparadorStatus();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      height: 10,
      width: 2,
      color: Colors.grey.shade300,
    );
  }
}

class WidgetStatus extends StatefulWidget {
  const WidgetStatus({
    super.key,
    required this.isActive,
    required this.title,
    this.corStatus,
  });

  @override
  State<WidgetStatus> createState() => _WidgetStatusState();
  final bool isActive;
  final String title;
  final Color? corStatus;
}

class _WidgetStatusState extends State<WidgetStatus> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 20,
          width: 20,
          margin: const EdgeInsets.only(
            right: 5,
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.green,
              ),
              color: widget.isActive
                  ? widget.corStatus ?? Colors.green
                  : Colors.transparent),
          child: widget.isActive
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 13,
                )
              : const SizedBox.shrink(),
        ),
        Expanded(
          child: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        )
      ],
    );
  }
}
