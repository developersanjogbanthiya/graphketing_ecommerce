import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:graphketing_assignment/models/product_model.dart';
import 'package:graphketing_assignment/providers/products_provider.dart';
import 'package:graphketing_assignment/widgets/single_product.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Your Shopping Cart',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Consumer<ProductsProvider>(
                builder: (context, value, child) {
                  return Text(
                    'Cart Total: \$${value.cartTotal}',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  );
                },
              ),
              Gap(12),
              Expanded(
                child: GridView.builder(
                  itemCount: productsProvider.cartProducts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    ProductModel productModel = productsProvider.cartProducts[index];
                    return SingleProduct(
                      productModel: productModel,
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
