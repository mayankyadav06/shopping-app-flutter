import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/product_provider.dart';

class ProductCard extends StatefulWidget {
  final String name;
  final String price;
  final String imagePath;
  const ProductCard(
      {super.key,
      required this.name,
      required this.price,
      required this.imagePath});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 8.0),
      child: Card(
        color: Colors.grey[200],
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        elevation: 4.0,
        shadowColor: Colors.black45,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  width: 220,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: FileImage(
                        File(widget.imagePath),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Provider.of<ProductProvider>(context, listen: false)
                        .deleteProduct(widget.name, context);
                  },
                  icon: const Icon(
                    Icons.delete,
                    size: 32.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                widget.name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20.0),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Rs. ${widget.price}",
                style: TextStyle(color: Colors.grey[800], fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
