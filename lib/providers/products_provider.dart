import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graphketing_assignment/models/product_model.dart';
import 'package:graphketing_assignment/services/https_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsProvider extends ChangeNotifier {
  // getProductsData will be called and all products will be loaded in _allProducts List
  ProductsProvider() {
    getProductsData();
  }

  final List<ProductModel> _cartProducts = [];
  List<ProductModel> get cartProducts => _cartProducts;

  List<ProductModel> _allProducts = [];
  List<ProductModel> get allProducts => _allProducts;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get erorMessage => _errorMessage;

  double _cartTotal = 0.0;
  double get cartTotal => _cartTotal;

  // Storing cart product IDs
  List<String> _cartProductIds = [];

  // Fetching the cart data from the local storage
  Future<void> fetchCartFromLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    _cartProductIds.clear();
    if (prefs.containsKey('productIds')) {
      // Fetching the product IDs from the local storage
      _cartProductIds = prefs.getStringList('productIds')!;

      // Fetching the cart products from allProducts matching the product IDs and loading it into cartProducts
      for (var cartProductId in _cartProductIds) {
        final product = _allProducts.firstWhere((element) => element.id == int.parse(cartProductId));
        _cartProducts.add(product);
      }
    }
    calculateCartTotal();
    notifyListeners();
  }

  // Fetching the products data from the API
  Future<void> getProductsData() async {
    try {
      // Setting loading state to true till the time products get loaded
      _isLoading = true;
      notifyListeners();
      _allProducts = await HttpsService().getProductsData();
      await fetchCartFromLocalStorage();
    } on HttpException catch (e) {
      _errorMessage = e.message;
    } on Exception catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Adding a product to the cart
  void addProductToCart(ProductModel product) async {
    _cartProducts.add(product);
    final prefs = await SharedPreferences.getInstance();
    // Clearing the product IDs list
    _cartProductIds.clear();
    // And loading it with the new product IDs along with the existing ones
    for (var element in _cartProducts) {
      _cartProductIds.add(element.id.toString());
    }
    // Saving into the local storage
    prefs.setStringList('productIds', _cartProductIds);
    // Calculating cart total
    calculateCartTotal();
    notifyListeners();
  }

  // Removing a product from the cart
  void removeProductFromCart(int id) async {
    _cartProducts.removeWhere((element) => element.id == id);
    final prefs = await SharedPreferences.getInstance();
    // Clearing the product IDs list
    _cartProductIds.clear();
    // And loading it with the product IDs after removing the product
    for (var element in _cartProducts) {
      _cartProductIds.add(element.id.toString());
    }
    // Saving into the local storage
    prefs.setStringList('productIds', _cartProductIds);
    // Calculating cart total
    calculateCartTotal();
    notifyListeners();
  }

  calculateCartTotal() {
    // Resetting cart total
    _cartTotal = 0.0;
    // Calculating cartTotal
    for (var cartProduct in cartProducts) {
      _cartTotal += cartProduct.price;
    }
    notifyListeners();
  }
}
