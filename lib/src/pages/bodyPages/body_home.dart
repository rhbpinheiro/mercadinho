import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:mercadinho/src/components/category_tile.dart';
import 'package:mercadinho/src/components/item_tile.dart';
import 'package:mercadinho/src/config/app_data.dart' as appData;
import 'package:mercadinho/src/pages/common_widgets/app_name_widget.dart';
import 'package:mercadinho/src/pages/common_widgets/widget_grid_view_shimmer.dart';
import 'package:mercadinho/src/utils/custom_shimmer.dart';
import 'package:mercadinho/src/utils/utils_service.dart';

class BodyHome extends StatefulWidget {
  const BodyHome({super.key});

  @override
  State<BodyHome> createState() => _BodyHomeState();
}

String selectedCategory = 'Frutas';

class _BodyHomeState extends State<BodyHome> {
  GlobalKey<CartIconKey> globalKeyCartIyems = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;
  void itemSeletedCartAnimation(GlobalKey gkImage) async {
    await runAddToCartAnimation(gkImage);
    await globalKeyCartIyems.currentState!.runCartAnimation();
  }

  final UtilsService utilsService = UtilsService();

  bool isLoading = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          isLoading = false;
        });
      });
    });
    super.initState();
  }

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
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: TextFormField(
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(60),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 30,
              ),
              height: 40,
              child: !isLoading
                  ? ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) {
                        return CategoryTile(
                          category: appData.categories[index],
                          isSelected:
                              appData.categories[index] == selectedCategory,
                          onTap: () {
                            setState(() {
                              selectedCategory = appData.categories[index];
                            });
                          },
                        );
                      },
                      separatorBuilder: (_, index) => const SizedBox(
                            width: 10,
                          ),
                      itemCount: appData.categories.length)
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
            ),
            Expanded(
              child: !isLoading
                  ? GridView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 9 / 11.5,
                      ),
                      itemCount: appData.items.length,
                      itemBuilder: (_, index) {
                        return ItemTile(
                          item: appData.items[index],
                          cartAnimationMethod: itemSeletedCartAnimation,
                        );
                      },
                    )
                  : const WidgetGridViewShimmer(),
            )
          ],
        ),
      ),
    );
  }
}
