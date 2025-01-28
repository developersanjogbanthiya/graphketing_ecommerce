import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:graphketing_assignment/models/product_model.dart';
import 'package:graphketing_assignment/providers/products_provider.dart';
import 'package:graphketing_assignment/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class SingleProduct extends StatelessWidget {
  const SingleProduct({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // Navigating to detail screen
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (builder) => ProductDetailScreen(productModel: productModel),
            ),
          );
        },
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.5),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Displaying image
                  Image.network(
                    productModel.image,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  Gap(8),
                  // Title, price and rating
                  Text(
                    productModel.title,
                    style: TextStyle(fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
                  ),
                  Text(
                    'Price - \$${productModel.price.toString()}',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Rating - ${productModel.rating.rate} / 5'),
                ],
              ),
            ),
            // Add to cart button
            Positioned(
              right: 0,
              child: Consumer<ProductsProvider>(
                builder: (context, value, child) {
                  bool isProductInCart = value.cartProducts.where((element) => element.id == productModel.id).isNotEmpty;

                  return IconButton(
                    onPressed: () {
                      if (!isProductInCart) {
                        value.addProductToCart(productModel);
                      } else {
                        value.removeProductFromCart(productModel.id);
                      }
                    },
                    icon: !isProductInCart
                        ? Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.green,
                          )
                        : Icon(
                            Icons.shopping_bag,
                            color: Colors.green,
                          ),
                  );
                },
              ),
            )
          ],
        ));
  }
}
