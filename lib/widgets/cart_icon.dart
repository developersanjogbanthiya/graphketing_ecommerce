import 'package:flutter/material.dart';
import 'package:graphketing_assignment/providers/products_provider.dart';
import 'package:graphketing_assignment/screens/cart_screen.dart';
import 'package:provider/provider.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    // Stack widget is used to display the cart icon and the number of products in the cart
    return Stack(
      children: [
        IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CartScreen();
            }));
          },
          icon: const Icon(Icons.shopping_bag_outlined),
        ),
        // Displaying the number of products in the cart
        Positioned(
          top: 5,
          left: 5,
          child: Container(
            width: 18,
            height: 18,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            child: Consumer<ProductsProvider>(
              builder: (context, productsProvider, child) {
                return Text(
                  productsProvider.cartProducts.length.toString(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 12,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
