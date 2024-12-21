import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/product_provider.dart';
import 'package:shopping_app/screens/add_product_screen.dart';
import 'package:shopping_app/screens/login_screen.dart';
import 'package:shopping_app/screens/search_result_screen.dart';

import '../models/product.dart';
import '../widgets/product_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  void logout(BuildContext context) {
    final authBox = Hive.box('authBox');
    authBox.put('isLoggedIn', false);
    // Back to login screen after successful logout
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black26,
        automaticallyImplyLeading: false,
        title: const Text('Shopping App'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logout(context),
          ),
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          // Retrieving products list form shared preference
          List<Product> products = productProvider.productList;

          return Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      // Search bar
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[50], // Grey shade of 100
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                decoration: const InputDecoration(
                                  hintText: 'Search...',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.search_rounded),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchResultScreen(
                                      searchCtrl: _searchController,
                                      query: _searchController.text,
                                    ),
                                  ),
                                );
                                // FocusScope.of(context).unfocus();
                              },
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Welcome!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Products ${products.length}",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey[700]),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "See all",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      // List of available products
                      SizedBox(height: 250, child: buildProductList(products)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Accessories ${products.length}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[700]),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "See all",
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        ],
                      ),
                      // List of Accessories (using the same list)
                      SizedBox(height: 250, child: buildProductList(products)),
                    ],
                  ),
                ),
              ),

              // Button to add new products
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0, right: 12.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.grey[300], // Button background color
                      minimumSize: const Size(30, 50), // Square size
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12.0), // Circular border
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const AddProductScreen(), // redirecting to Add Product Screen
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.black87, // Icon color
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
