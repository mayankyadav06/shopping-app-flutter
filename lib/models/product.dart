import 'package:hive/hive.dart';

part 'product.g.dart';

// Product Model
@HiveType(typeId: 0)
class Product {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final double price;

  @HiveField(2)
  final String imagePath;

  Product({required this.name, required this.price, required this.imagePath});
}
