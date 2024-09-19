import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:uni_trade/utils/features/authentication/models/product/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uni_trade/utils/features/authentication/screens/product_details/product_detail.dart';
import 'package:uni_trade/utils/constants/colors.dart';
import 'package:uni_trade/utils/constants/sizes.dart';
import 'package:uni_trade/utils/features/device/device_utility.dart';

class TSearchContainer extends StatelessWidget {
  const TSearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SearchScreen()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
        child: Container(
          width: TDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(TSizes.md),
          decoration: BoxDecoration(
            color: showBackground ? TColors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
            border: showBorder ? Border.all(color: TColors.grey) : null,
          ),
          child: Row(
            children: [
              Icon(icon, color: TColors.darkerGrey),
              const SizedBox(width: TSizes.spaceBtwItems),
              Text(text, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> _searchResults = [];
  bool _isLoading = false;
  double? _minPrice;
  double? _maxPrice;

  void _searchProducts(String query) async {
    setState(() {
      _isLoading = true;
    });

    // Convert query to lowercase
    String lowerCaseQuery = query.toLowerCase();

    final snapshot =
        await FirebaseFirestore.instance.collection('Product').get();

    // Filter the products by checking if the title contains the lowerCaseQuery
    List<DocumentSnapshot> filteredProducts = snapshot.docs.where((doc) {
      String title = (doc['Title'] as String).toLowerCase();
      double price = doc['Price'].toDouble();
      bool matchesPriceRange = true;

      if (_minPrice != null && price < _minPrice!) {
        matchesPriceRange = false;
      }
      if (_maxPrice != null && price > _maxPrice!) {
        matchesPriceRange = false;
      }

      return title.contains(lowerCaseQuery) && matchesPriceRange;
    }).toList();

    setState(() {
      _searchResults = filteredProducts;
      _isLoading = false;
    });
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController minPriceController = TextEditingController();
        TextEditingController maxPriceController = TextEditingController();

        return AlertDialog(
          title: const Text('Filter by Price'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: minPriceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Min Price',
                ),
              ),
              TextField(
                controller: maxPriceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Max Price',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _minPrice = minPriceController.text.isNotEmpty
                      ? double.tryParse(minPriceController.text)
                      : null;
                  _maxPrice = maxPriceController.text.isNotEmpty
                      ? double.tryParse(maxPriceController.text)
                      : null;
                });
                Navigator.of(context).pop();
                _searchProducts(_searchController.text);
              },
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: const Text('Search Results'),
        actions: [
          IconButton(
            icon: Icon(Iconsax.filter),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Enter product name',
                prefixIcon: Icon(Iconsax.search_normal),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                ),
              ),
              onChanged: (value) {
                _searchProducts(value);
              },
            ),
            const SizedBox(height: TSizes.defaultSpace),
            _isLoading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final product = _searchResults[index];
                        return ListTile(
                          title: Text(product['Title']),
                          subtitle: Text(product['Price'].toString()),
                          onTap: () async {
                            final DocumentSnapshot<Map<String, dynamic>>
                                docSnapshot = await FirebaseFirestore.instance
                                    .collection('Product')
                                    .doc(product.id)
                                    .get();
                            Get.to(() => ProductDetail(
                                  product:
                                      ProductModel.fromSnapshot(docSnapshot),
                                ));
                          },
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
