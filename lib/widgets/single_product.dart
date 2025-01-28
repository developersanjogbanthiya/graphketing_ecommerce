import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:graphketing_assignment/models/product_model.dart';
import 'package:graphketing_assignment/screens/product_detail_screen.dart';

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
      child: Container(
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
    );
  }
}
