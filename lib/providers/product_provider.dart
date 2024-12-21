import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shopping_app/models/product.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _productsList = [];
  List<Product> get productList => _productsList;
  final productBox = Hive.box<Product>('productBox');

  // add a product
  void addProduct(Product product, BuildContext context) async {
    // Check if a product with the same name already exists in the box
    if (productBox.containsKey(product.name.toLowerCase())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product already exists!')),
      );
      return;
    }

    productBox.put(product.name.toLowerCase(), product);
    getList();

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Product added successfully!')),
    );
  }

  // get product from hive
  void getList() {
    _productsList = productBox.values.toList();
    notifyListeners();
  }

  // delete a product
  void deleteProduct(String name, BuildContext context) async {
    if (productBox.containsKey(name.toLowerCase())) {
      productBox.delete(name.toLowerCase());
      getList();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product deleted successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product not found!')),
      );
    }
  }
}
