# Shopping App

A simple Flutter-based shopping app for managing a product list. Users can add, search, and delete products. The app utilizes Hive for local data storage and Provider for state management.

## Features
- **Add Products**: Add a product with a name, price, and an image.
- **View Products**: Display a horizontally scrollable list of products.
- **Delete Products**: Remove products directly from the list.
- **Search Products**: Quickly search for products by their name.
- **Local Storage**: Store product data locally using Hive.
- **State Management**: Manage state efficiently using the Provider package.

## Screenshots
*(Add your screenshots here)*

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/mayankyadav06/shopping-app-flutter.git
   ```
2. Navigate to the project directory:
   ```bash
   cd shopping_app_flutter
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## Project Structure
```plaintext
lib/
├── models/
│   └── product.dart      # Product model with Hive annotations
├── providers/
│   └── product_provider.dart # Provider for managing product state
├── screens/
    ├── home_screen.dart  # Screen for displaying products
    ├── login_screen.dart  # Screen for login
    ├── search_result_screen.dart  # Screen to show search results
│   └── add_product_screen.dart # Screen for adding products
├── widgets/
│   ├── product_card.dart     # Widget for displaying individual product cards
│   └── product_list_widget.dart # Widget for displaying product list
├── main.dart                # Entry point of the app
```


## How It Works
1. **Adding a Product**:
   - Users can enter a product name and price.
   - They can pick an image from their gallery.
   - On submission, the product is stored in Hive and the list is updated.

2. **Viewing Products**:
   - Products are displayed in a horizontally scrollable list with their name, price, and image.

3. **Searching Products**:
   - Users can search for products by typing a name in the search bar.
   - The product list dynamically updates to show matching results.

4. **Deleting a Product**:
   - Users can delete a product using the delete icon on the product card.
   - The product is removed from Hive and the list is updated.

## Dependencies
- **Flutter**: Framework for building the UI.
- **Hive**: For local data storage.
- **Provider**: For state management.
- **Image Picker**: For selecting images from the gallery.

## Setup for Hive
1. Initialize Hive in your `main.dart`:
   ```dart
   void main() async {
     WidgetsFlutterBinding.ensureInitialized();
     await Hive.initFlutter();
     Hive.registerAdapter(ProductAdapter());
     await Hive.openBox<Product>('productBox');
     runApp(MyApp());
   }
   ```
2. Generate the Hive adapter:
   ```bash
   flutter packages pub run build_runner build
   ```

## Future Improvements
- Add product editing functionality.
- Implement advanced filter options.
- Improve UI and animations.
- Cart functionality etc.



