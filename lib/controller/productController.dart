import 'package:ecommerce/model/productListModel.dart';
import 'package:ecommerce/remote/apiConfig.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductListController extends GetxController {
  final _products = List<ProductListModel>.empty().obs;
  List<ProductListModel> get products => _products;

  final _filteredProducts = List<ProductListModel>.empty().obs;
  List<ProductListModel> get filteredProducts => _filteredProducts;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    final response = await http.get(Uri.parse(ApiConfig.getProductsUrl));
    if (response.statusCode == 200) {
      final List<ProductListModel> productList =
          productListModelFromJson(response.body);
      _products.assignAll(productList);
      _filteredProducts.assignAll(
          productList); // Initially set filtered products to all products
    } else {
      throw Exception('Failed to load products');
    }
  }

  void filterProducts(String query) {
    _filteredProducts.value = _products.where((product) {
      return product.title!.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
