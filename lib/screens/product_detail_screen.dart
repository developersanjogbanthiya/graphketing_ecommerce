import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:graphketing_assignment/models/product_model.dart';
import 'package:graphketing_assignment/providers/products_provider.dart';
import 'package:graphketing_assignment/screens/cart_screen.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            productModel.title,
            style: TextStyle(fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Displaying image
                Image.network(
                  productModel.image,
                  height: 264,
                  width: 264,
                  fit: BoxFit.cover,
                ),
                Gap(8),
                // Title, price, rating and description
                Text(
                  productModel.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Gap(8),
                Text(
                  'Price - \$${productModel.price.toString()}',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Gap(8),
                Text(
                  'Rating - ${productModel.rating.rate} / 5',
                  style: TextStyle(fontSize: 16),
                ),
                Gap(8),
                Text(
                  productModel.description,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Gap(8),
                Consumer<ProductsProvider>(
                  builder: (context, value, child) {
                    // Checking the product if it is there in cart or not
                    bool isProductInCart =
                        productsProvider.cartProducts.where((element) => element.id == productModel.id).isNotEmpty;

                    return ElevatedButton.icon(
                      onPressed: () {
                        // Adding the product to cart
                        if (!isProductInCart) {
                          productsProvider.addProductToCart(productModel);
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Added to Cart'),
                            action: SnackBarAction(
                              label: 'Go to Cart',
                              onPressed: () {
                                Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (builder) => CartScreen()));
                              },
                            ),
                          ));
                        } else {
                          // Removing the product from cart
                          productsProvider.removeProductFromCart(productModel.id);
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Removed from Cart'),
                          ));
                        }
                      },
                      iconAlignment: IconAlignment.end,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      icon: Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.white,
                      ),
                      // Changing the button label based on the product is in cart or not
                      label: !isProductInCart ? Text('Add to Cart') : Text('Remove from Cart'),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
