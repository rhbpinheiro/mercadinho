import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mercadinho/src/pages/home/view/components/category_tile.dart';
import 'package:mercadinho/src/pages/home/view/components/item_tile.dart';
import 'package:mercadinho/src/pages/common_widgets/app_name_widget.dart';
import 'package:mercadinho/src/pages/common_widgets/widget_grid_view_shimmer.dart';
import 'package:mercadinho/src/pages/home/controller/home_controller.dart';
import 'package:mercadinho/src/utils/custom_shimmer.dart';
import 'package:mercadinho/src/utils/utils_service.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  GlobalKey<CartIconKey> globalKeyCartIyems = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;
  void itemSeletedCartAnimation(GlobalKey gkImage) async {
    await runAddToCartAnimation(gkImage);
    await globalKeyCartIyems.currentState!.runCartAnimation();
  }

  final searchController = TextEditingController();

  final UtilsService utilsService = UtilsService();

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const AppNameWidget(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: InkWell(
              onTap: () {},
              child: Badge(
                backgroundColor: Colors.red.shade300,
                label: const Text(
                  '2',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                child: AddToCartIcon(
                  key: globalKeyCartIyems,
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.green,
                  ),
                  badgeOptions: const BadgeOptions(
                    active: false,
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: AddToCartAnimation(
        cartKey: globalKeyCartIyems,
        createAddToCartAnimation: (addToCartAnimationMetyhod) {
          runAddToCartAnimation = addToCartAnimationMetyhod;
        },
        jumpAnimation: const JumpAnimationOptions(
          curve: Curves.ease,
          duration: Duration(
            microseconds: 50,
          ),
        ),
        child: Column(
          children: [
            GetBuilder<HomeController>(
              builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: TextFormField(
                    controller: searchController,
                    onChanged: (value) {
                      controller.searchTitle.value = value;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                      hintText: 'Pesquise aqui...',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 14,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 21,
                        color: Colors.orangeAccent,
                      ),
                      suffixIcon: controller.searchTitle.value.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                searchController.clear();
                                controller.searchTitle.value = '';
                                FocusScope.of(context).unfocus();
                              },
                              icon: const Icon(Icons.close,
                                  color: Colors.orangeAccent, size: 21),
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            GetBuilder<HomeController>(
              builder: (controller) {
                return Container(
                  padding: const EdgeInsets.only(
                    left: 30,
                  ),
                  height: 40,
                  child: !controller.isCategoryLoading
                      ? ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return CategoryTile(
                              category: controller.allCategories[index].title,
                              isSelected: controller.allCategories[index] ==
                                  controller.currentCategory,
                              onTap: () {
                                controller.seletedCategory(
                                    controller.allCategories[index]);
                              },
                            );
                          },
                          separatorBuilder: (_, index) => const SizedBox(
                            width: 10,
                          ),
                          itemCount: controller.allCategories.length,
                        )
                      : ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            10,
                            (_) => Container(
                              margin: const EdgeInsets.only(
                                right: 10,
                              ),
                              alignment: Alignment.center,
                              child: CustomShimmer(
                                height: 30,
                                width: 80,
                                borderRadius: BorderRadius.circular(
                                  20,
                                ),
                              ),
                            ),
                          ),
                        ),
                );
              },
            ),
            GetBuilder<HomeController>(
              builder: (controller) {
                return Expanded(
                  child: !controller.isProductLoading
                      ? Visibility(
                          visible: (controller.currentCategory?.items ?? [])
                              .isNotEmpty,
                          replacement: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               Icon(
                                Icons.search_off,
                                size: 40,
                                color: Colors.grey,
                              ),
                              Text('Nenhum resultado encontrado')
                            ],
                          ),
                          child: GridView.builder(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 9 / 11.5,
                            ),
                            itemCount: controller.allProducts.length,
                            itemBuilder: (_, index) {
                              if ((index + 1) ==
                                      controller.allProducts.length &&
                                  (!controller.isLastPage)) {
                                controller.loadOrProducts();
                              }
                              return ItemTile(
                                item: controller.allProducts[index],
                                cartAnimationMethod: itemSeletedCartAnimation,
                              );
                            },
                          ),
                        )
                      : const WidgetGridViewShimmer(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
