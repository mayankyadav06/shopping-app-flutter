import 'package:flutter/cupertino.dart';
import 'package:shopping_app/widgets/product_card.dart';

import '../models/product.dart';

// custom widget to showcase products
Widget buildProductList(List<Product> products) {
  return products.isEmpty
      ? const Center(
          child: Text('No products added yet.'),
        )
      : ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(
                name: product.name,
                price: "${product.price}",
                imagePath: product.imagePath);
          },
        );
}
