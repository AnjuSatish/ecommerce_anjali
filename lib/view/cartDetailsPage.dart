import 'package:ecommerce/controller/cartController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartDetailsPage extends StatefulWidget {
  @override
  State<CartDetailsPage> createState() => _CartDetailsPageState();
}

class _CartDetailsPageState extends State<CartDetailsPage> {
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (cartController.cartItems.isEmpty) {
                  return Center(child: Text("No items to show"));
                } else {
                  // Calculate total sum of prices
                  double totalSum = cartController.cartItems.fold(
                      0,
                      (sum, cartItem) =>
                          sum + (cartItem.price ?? 0) * cartItem.quantity);
                  return ListView.builder(
                    itemCount: cartController.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartController.cartItems[index];
                      final totalPrice = cartItem.totalPrice != null
                          ? '\$${cartItem.totalPrice!.toStringAsFixed(2)}'
                          : 'N/A';
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Card(
                          elevation: 3.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16.0),
                            title: Text(
                              cartItem.title ?? '',
                              style: const TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '\$${cartItem.price?.toStringAsFixed(2)}',
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                                Text(
                                  'Total Price: $totalPrice',
                                  style: const TextStyle(fontSize: 14.0),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    cartController
                                        .decreaseQuantity(cartItem.id!);
                                    setState(() {});
                                  },
                                ),
                                Text(
                                  '${cartItem.quantity}',
                                  style: TextStyle(fontSize: 20),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    cartController
                                        .increaseQuantity(cartItem.id!);
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
            ),
            const SizedBox(height: 10),
            Obx(() {
              // Calculate total sum of prices
              double totalSum = cartController.cartItems.fold(
                  0,
                  (sum, cartItem) =>
                      sum + (cartItem.price ?? 0) * cartItem.quantity);
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Total Amount: \$${totalSum.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Buy Now'),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
