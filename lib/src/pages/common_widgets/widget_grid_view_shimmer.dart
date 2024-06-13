import 'package:flutter/material.dart';
import 'package:mercadinho/src/utils/custom_shimmer.dart';

class WidgetGridViewShimmer extends StatelessWidget {
  const WidgetGridViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      physics: const BouncingScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 9 / 11.5,
      children: List.generate(
        10,
        (_) => CustomShimmer(
          height: double.infinity,
          width: double.infinity,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
