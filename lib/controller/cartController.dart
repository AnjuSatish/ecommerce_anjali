import 'package:ecommerce/model/productListModel.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RxList<ProductListModel> cartItems = <ProductListModel>[].obs;

  void addToCart(ProductListModel product) {
    if (cartItems.any((item) => item.id == product.id)) {
      increaseQuantity(product.id!);
    } else {
      product.quantity = 1;
      cartItems.add(product);
    }
  }

  void removeFromCart(int productId) {
    cartItems.removeWhere((item) => item.id == productId);
  }

  void increaseQuantity(int productId) {
    final itemIndex = cartItems.indexWhere((item) => item.id == productId);
    if (itemIndex != -1) {
      cartItems[itemIndex].quantity++;

      updateTotalPrice(cartItems[itemIndex]);

    }
  }

  void decreaseQuantity(int productId) {
    final itemIndex = cartItems.indexWhere((item) => item.id == productId);
    if (itemIndex != -1) {
      cartItems[itemIndex].quantity--;

      if (cartItems[itemIndex].quantity == 0) {
        removeFromCart(productId);
      } else {
        updateTotalPrice(cartItems[itemIndex]);
      }

    }
  }

  void updateTotalPrice(ProductListModel item) {
    if (item.price != null) {
      item.totalPrice = item.price! * item.quantity;
    }
  }
}
