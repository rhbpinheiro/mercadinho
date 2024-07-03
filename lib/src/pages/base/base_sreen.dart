import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mercadinho/src/pages/cart/cart_tab.dart';
import 'package:mercadinho/src/pages/home/view/home_tab.dart';
import 'package:mercadinho/src/pages/orders/orders_tab.dart';
import 'package:mercadinho/src/pages/profile/profile_tab.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int currentIndex = 0;
  final pageController = PageController();
  // final navigationController = Get.find<NavigationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: const [
          HomeTab(),
          CartTab(),
          OedersTab(),
          ProfileTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          });
          currentIndex = index;
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withAlpha(100),
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
              Icons.home_outlined,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Carrinho',
            icon: Icon(
              Icons.shopping_cart_outlined,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Pedidos',
            icon: Icon(
              Icons.list_alt_outlined,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Perfil',
            icon: Icon(
              Icons.person_outline,
            ),
          ),
        ],
      ),
    );
  }
}
