import 'dart:convert';
import 'dart:io';

import 'package:graphketing_assignment/models/product_model.dart';
import 'package:http/http.dart' as http;

class HttpsService {
  static const String apiUrl = 'https://fakestoreapi.com/products';

  // Fetching products data from the API
  Future<List<ProductModel>> getProductsData() async {
    List<ProductModel> productModel = [];
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        final List jsonData = json.decode(response.body);

        jsonData.map((product) {
          productModel.add(ProductModel.fromJson(product));
        }).toList();

        return productModel;
      } else {
        throw Exception('Failed to load products');
      }
    } on HttpException catch (e) {
      throw HttpException('Error: ${e.message}');
    }
  }
}
