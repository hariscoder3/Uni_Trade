import 'package:flutter/material.dart';

import '../../../../../common/widgets/layout/grid_layout.dart';
import '../../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../constants/sizes.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Popular Products')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Products
              TGridLayout(
                  itemCount: 8,
                  itemBuilder: (_, index) => const TProductCardVertical()),
            ], // Children
          ), // Column
        ), // Padding
      ), //SingleChildScrollView
    ); // Scaffold
  }
}
