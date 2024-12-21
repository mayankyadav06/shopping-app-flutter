import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';

class SearchResultScreen extends StatefulWidget {
  final String query;
  final TextEditingController searchCtrl;
  const SearchResultScreen(
      {super.key, required this.query, required this.searchCtrl});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  Widget build(BuildContext context) {
    final productList = Provider.of<ProductProvider>(context).productList;
    // filtering products based on query
    final filteredProducts = productList
        .where((product) =>
            product.name.toLowerCase().contains(widget.query.toLowerCase()))
        .toList();
    widget.searchCtrl.clear();
    FocusScope.of(context).unfocus();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(),
      body: filteredProducts.isEmpty
          ? const Center(
              child: Text('No products found'),
            )
          : Column(
              children: [
                Text(
                  "Search Results for '${widget.query}'",
                  style: TextStyle(fontSize: 24, color: Colors.grey[700]),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[300], // Background color of the tile
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: ListTile(
                        leading: Container(
                          width: 80,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: FileImage(
                                File(product.imagePath),
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        title: Text(
                          product.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "Rs. ${product.price}",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
    );
  }
}
