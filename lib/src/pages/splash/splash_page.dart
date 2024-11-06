import 'package:flutter/material.dart';

import 'package:mercadinho/src/pages/common_widgets/app_name_widget.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.green, Colors.yellowAccent])),
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppNameWidget(
                greenTitleColor: Colors.white,
              ),
              SizedBox(
                height: 10,
              ),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                  Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
