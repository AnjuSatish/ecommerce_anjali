import 'package:ecommerce/controller/cartController.dart';
import 'package:ecommerce/model/productListModel.dart';
import 'package:ecommerce/view/cartDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductListModel product;
  final CartController cartController;

  ProductDetailPage({required this.product, required this.cartController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Get.to(CartDetailsPage());
                },
              ),
              Positioned(
                top: 0,
                right: 0,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 10,
                  child: Obx(
                    () => Text(cartController.cartItems.length.toString()),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (product.image != null)
                  Image.network(
                    product.image!,
                    height: 200,
                  ),
                const SizedBox(height: 20),
                Text(
                  product.title ?? '',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  product.description ?? '',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 10),
                Text(
                  '\$${product.price}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                Obx(() {
                  final isItemInCart = cartController.cartItems
                      .any((item) => item.id == product.id);
                  return isItemInCart
                      ? ElevatedButton(
                          onPressed: () {
                            showToast('Item already added to cart');
                          },
                          child: const Text('Already Added'),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            cartController.addToCart(product);

                            showToast('Item added to cart');
                          },
                          child: const Text('Add to Cart'),
                        );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showToast(String message) {
    Get.snackbar(
      'Cart',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.grey[800],
      colorText: Colors.white,
    );
  }
}
