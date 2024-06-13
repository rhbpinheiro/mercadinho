// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';


class WidgetAddQuantidade extends StatelessWidget {
  const WidgetAddQuantidade({
    super.key,
    required this.value,
    required this.unidade,
    required this.result,
    this.isRemovable = false,
  });

  final int value;
  final String unidade;
  final Function(int quantity) result;
  final bool isRemovable;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 1,
              blurRadius: 2,
            ),
          ]),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _BotaoQuantidade(
              color: !isRemovable || value > 1 ? Colors.grey : Colors.red,
              icon: !isRemovable || value > 1
                  ? Icons.remove
                  : Icons.delete_forever,
              onpressed: () {
                if (value == 1 && !isRemovable ) return;
                int resultCount = value - 1;
                result(resultCount);
              }),
          const SizedBox(
            width: 10,
          ),
          Text(
            '$value$unidade',
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
          const SizedBox(
            width: 10,
          ),
          _BotaoQuantidade(
            color: Colors.green,
            icon: Icons.add,
            onpressed: () {
              int resultCount = value + 1;
              result(resultCount);
            },
          ),
        ],
      ),
    );
  }
}

class _BotaoQuantidade extends StatelessWidget {
  const _BotaoQuantidade({
    required this.color,
    required this.icon,
    required this.onpressed,
  });

  final Color color;
  final IconData icon;
  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onpressed,
        child: Ink(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
