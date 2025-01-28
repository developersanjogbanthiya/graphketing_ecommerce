import 'package:flutter/material.dart';
import 'package:graphketing_assignment/models/product_model.dart';
import 'package:graphketing_assignment/providers/products_provider.dart';
import 'package:graphketing_assignment/widgets/cart_icon.dart';
import 'package:graphketing_assignment/widgets/single_product.dart';
import 'package:provider/provider.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetching the products data from the provider
    final productsProvider = Provider.of<ProductsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Products',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          CartIcon(),
        ],
      ),
      body: Consumer<ProductsProvider>(
        builder: (context, value, child) {
          // Checking the state of the data
          if (value.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          // Checking if there is no data
          if (value.allProducts.isEmpty) {
            return Center(
              child: Text('No products found'),
            );
          }
          // Checking if there is any error message
          if (value.erorMessage.isNotEmpty) {
            return Center(
              child: Text(value.erorMessage),
            );
          }
          // Displaying the products
          return Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              itemCount: productsProvider.allProducts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.9, // width / height
                crossAxisSpacing: 20, // Spacing vertically
                mainAxisSpacing: 20, // Spacing horizontally
              ),
              itemBuilder: (context, index) {
                ProductModel productModel = productsProvider.allProducts[index];
                // Passing each product data to the SingleProduct widget
                return SingleProduct(
                  productModel: productModel,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
