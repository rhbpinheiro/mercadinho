import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:mercadinho/src/models/category_model.dart';
import 'package:mercadinho/src/models/item_model.dart';
import 'package:mercadinho/src/pages/home/repository/home_repository.dart';
import 'package:mercadinho/src/pages/home/result/home_result.dart';
import 'package:mercadinho/src/utils/utils_service.dart';

const int itemsPage = 6;

class HomeController extends GetxController {
  bool isCategoryLoading = false;
  bool isProductLoading = true;
  final UtilsService utilsServices = UtilsService();
  List<CategoryModel> allCategories = [];
  List<ItemModel> get allProducts => currentCategory?.items ?? [];
  CategoryModel? currentCategory;

  RxString searchTitle = ''.obs;

  bool get isLastPage {
    if (currentCategory!.items.length < itemsPage) {
      return true;
    }
    return currentCategory!.pagination * itemsPage > allProducts.length;
  }

  void seletedCategory(CategoryModel category) {
    currentCategory = category;
    update();
    if (currentCategory!.items.isNotEmpty) return;
    getAllProducts();
  }

  void setLoading(bool value, {bool isProduct = false}) {
    if (!isProduct) {
      isCategoryLoading = value;
    } else {
      isProductLoading = value;
    }
    update();
  }

  final HomeRepository homeRepository = HomeRepository();

  @override
  void onInit() {
    super.onInit();
    debounce(
      searchTitle,
      (_) {
        filterByTitle();
      },
      time: const Duration(milliseconds: 600),
    );
    getAllCategories();
  }

  Future<void> getAllCategories() async {
    setLoading(true);
    HomeResult<CategoryModel> homeResult =
        await homeRepository.getAllCategories();
    setLoading(false);
    homeResult.when(
      success: (data) {
        allCategories.assignAll(data);
        if (allCategories.isEmpty) return;
        seletedCategory(allCategories.first);
        update();
      },
      error: (message) {
        utilsServices.showToast(
          isError: true,
          message: message,
        );
      },
    );
  }

  Future<void> getAllProducts({bool canLoad = true}) async {
    if (canLoad) {
      setLoading(true, isProduct: true);
    }
    Map<String, dynamic> body = {
      'page': currentCategory!.pagination,
      'categoryId': currentCategory!.id,
      'itemsPerPage': itemsPage
    };
    if (searchTitle.value.isNotEmpty) {
      body['title'] = searchTitle.value;
      if (currentCategory!.id == '') {
        body.remove('categoryId');
      }
    }
    HomeResult<ItemModel> homeResult =
        await homeRepository.getAllProducts(body);
    setLoading(false, isProduct: true);
    homeResult.when(
      success: (data) {
        currentCategory!.items.addAll(data);
      },
      error: (message) {
        utilsServices.showToast(
          isError: true,
          message: message,
        );
      },
    );
  }

  void loadOrProducts() {
    currentCategory!.pagination++;
    getAllProducts(canLoad: false);
  }

  void filterByTitle() {
    for (var category in allCategories) {
      category.items.clear();
      category.pagination = 0;
    }

    if (searchTitle.value.isEmpty) {
      allCategories.removeAt(0);
    } else {
      CategoryModel? c =
          allCategories.firstWhereOrNull((element) => element.id == '');
      if (c == null) {
        final allProductsCategory = CategoryModel(
          title: 'Todos',
          id: '',
          items: [],
          pagination: 0,
        );

        allCategories.insert(0, allProductsCategory);
      } else {
        c.items.clear();
        c.pagination = 0;
      }
    }
    currentCategory = allCategories.first;
    update();
    getAllProducts();
  }
}
